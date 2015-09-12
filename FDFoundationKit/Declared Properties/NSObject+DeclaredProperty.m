#import "NSObject+DeclaredProperty.h"
#import "FDThreadSafeMutableDictionary.h"
@import ObjectiveC.runtime;


#pragma mark Constants

static void * const _DeclaredPropertiesForClassKey = (void *)&_DeclaredPropertiesForClassKey;


#pragma mark - Class Definition

@implementation NSObject (PropertyType)


#pragma mark - Public Methods

+ (FDDeclaredProperty *)fd_declaredPropertyForName: (NSString *)propertyName
{
	// Check if the declared property for the specified name has been cached.
	FDThreadSafeMutableDictionary *declaredPropertiesByName = [self fd_declaredPropertiesForClass: self];
	FDDeclaredProperty *declaredProperty = [declaredPropertiesByName objectForKey: propertyName];
	
	// If the declared property has not been cached create it from the property metadata.
	if(declaredProperty == nil)
	{
		objc_property_t propertyType = class_getProperty([self class], [propertyName UTF8String]);
		if (propertyType == nil)
		{
			return nil;
		}
		
		declaredProperty = [FDDeclaredProperty declaredPropertyForPropertyType: propertyType];
		
		[declaredPropertiesByName setValue: declaredProperty 
			forKey: propertyName];
	}
	
	return declaredProperty;
}

+ (FDDeclaredProperty *)fd_declaredPropertyForKeyPath: (NSString *)keyPath
{
	// Break the key path into its components.
	NSArray *keys = [keyPath componentsSeparatedByString:@"."];
	
	// Get the declared property for the first key.
	NSString *firstKey = [keys firstObject];
	
	FDDeclaredProperty *firstDeclaredProperty = [self fd_declaredPropertyForName: firstKey];
	
	// If there is only one key the first declared property can be immediately returned.
	if ([keys count] == 1)
	{
		return firstDeclaredProperty;
	}
	
	// Create a new key path from the remaining keys.
	NSArray *remainingKeys = [keys subarrayWithRange: NSMakeRange(1, [keys count] - 1)];
	NSString *remainingKeyPath = [remainingKeys componentsJoinedByString: @"."];
	
	// Get the declared property of the remaining key path on the first declared property.
	FDDeclaredProperty *declaredProperty = [firstDeclaredProperty.objectClass fd_declaredPropertyForKeyPath: remainingKeyPath];
	
	return declaredProperty;
}

+ (NSArray *)fd_declaredPropertiesUntilSuperclass: (Class)superclass
{
	// If no superclass was specified default to NSObject.
	if (superclass == nil)
	{
		superclass = [NSObject class];
	}
	
	static FDThreadSafeMutableDictionary *declaredPropertiesByClassUntilSuperClass = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		declaredPropertiesByClassUntilSuperClass = [FDThreadSafeMutableDictionary new];
	});
	
	NSString *key = [NSString stringWithFormat: @"%@->%@", 
		NSStringFromClass(self), 
		NSStringFromClass(superclass)];
	
	NSMutableArray *declaredProperties = [declaredPropertiesByClassUntilSuperClass objectForKey: key];
	if (declaredProperties == nil)
	{
		declaredProperties = [NSMutableArray array];
		[declaredPropertiesByClassUntilSuperClass setValue: declaredProperties 
			forKey: key];
	}
	else
	{
		return declaredProperties;
	}
	
	NSMutableSet *namesOfDeclaredProperties = [NSMutableSet set];
	
	Class objectClass = self;
	while (objectClass != superclass 
		 && [objectClass isSubclassOfClass: superclass] == YES)
	{
		unsigned int numberOfProperties = 0;
		objc_property_t *properties = class_copyPropertyList(objectClass, &numberOfProperties);
		
		for (unsigned int i=0; i < numberOfProperties; i++)
		{
			objc_property_t propertyType = properties[i];
			
			// Load the name of the property type.
			const char *rawPropertyName = property_getName(propertyType);
			NSString *propertyName = [NSString stringWithUTF8String: rawPropertyName];
			
			// Check if the declared property for the property type has been cached.
			FDThreadSafeMutableDictionary *declaredPropertiesByName = [self fd_declaredPropertiesForClass: self];
			FDDeclaredProperty *declaredProperty = [declaredPropertiesByName objectForKey: propertyName];
			
			// If the declared property has not been cached create it from the property type.
			if (declaredProperty == nil)
			{
				declaredProperty = [FDDeclaredProperty declaredPropertyForPropertyType: propertyType];
				
				[declaredPropertiesByName setValue: declaredProperty 
					forKey: propertyName];
			}
			
			// If a property by this name has not yet been encountered add it to the array. If a property by this name already exists ignore it because it means that the property has been redefined in a subclass.
			if ([namesOfDeclaredProperties containsObject: declaredProperty.name] == NO)
			{
				[declaredProperties addObject: declaredProperty];
				[namesOfDeclaredProperties addObject: declaredProperty.name];
			}
		}
		
		free(properties);
		
		objectClass = [objectClass superclass];
	}
	
	return declaredProperties;
}

#pragma mark - Private Methods

+ (FDThreadSafeMutableDictionary *)fd_declaredPropertiesForClass: (Class)objectClass
{
	// Store a dictionary of all the declared properties on the class so subsequent calls for the same property name can be cached.
	FDThreadSafeMutableDictionary *declaredPropertiesForClass = objc_getAssociatedObject(objectClass, _DeclaredPropertiesForClassKey);
	if (declaredPropertiesForClass == nil)
	{
		declaredPropertiesForClass = [FDThreadSafeMutableDictionary new];
		
		// TODO: Invesigate the need to wrap this in a dispatch_once because in theory two seperate threads could be requesting property info for the first time at the exact same time which could lead to two dictionaries being created and one overwriting the other leading to lost data. However it doesn't really matter that much because the next time that lost data is requested it will be properly cached.
		objc_setAssociatedObject(objectClass, _DeclaredPropertiesForClassKey, declaredPropertiesForClass, OBJC_ASSOCIATION_RETAIN);
	}
	
	return declaredPropertiesForClass;
}


@end