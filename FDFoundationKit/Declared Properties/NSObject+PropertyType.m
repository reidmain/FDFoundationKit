#import "NSObject+PropertyType.h"
#import "FDThreadSafeMutableDictionary.h"
#import <objc/runtime.h>


#pragma mark Constants

static void * const _DeclaredPropertiesForClassKey = (void *)&_DeclaredPropertiesForClassKey;


#pragma mark - Class Definition

@implementation NSObject (PropertyType)


#pragma mark - Public Methods

+ (FDDeclaredProperty *)declaredPropertyForName: (NSString *)propertyName
{
	// Check if the declared property for the specified name has been cached.
	FDThreadSafeMutableDictionary *declaredPropertiesByName = [self _declaredPropertiesForClass: self];
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

+ (FDDeclaredProperty *)declaredPropertyForKeyPath: (NSString *)keyPath
{
	// Break the key path into its components.
	NSArray *keys = [keyPath componentsSeparatedByString:@"."];
	
	// Get the declared property for the first key.
	NSString *firstKey = [keys firstObject];
	
	FDDeclaredProperty *firstDeclaredProperty = [self declaredPropertyForName: firstKey];
	
	// If there is only one key the first declared property can be immediately returned.
	if ([keys count] == 1)
	{
		return firstDeclaredProperty;
	}
	
	// Create a new key path of the remaining keys.
	NSArray *remainingKeys = [keys subarrayWithRange: NSMakeRange(1, [keys count] - 1)];
	NSString *remainingKeyPath = [remainingKeys componentsJoinedByString: @"."];
	
	// Get the declared property of the remaining key path on the first declared property.
	FDDeclaredProperty *declaredProperty = [firstDeclaredProperty.type declaredPropertyForKeyPath: remainingKeyPath];
	
	return declaredProperty;
}

+ (NSArray *)declaredPropertiesForSubclass: (Class)subclass
{
	NSMutableArray *declaredProperties = [NSMutableArray array];
	NSMutableSet *namesOfDeclaredProperties = [NSMutableSet set];
	
	Class objectClass = self;
	while ([objectClass isSubclassOfClass: subclass] == YES)
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
			FDThreadSafeMutableDictionary *declaredPropertiesByName = [self _declaredPropertiesForClass: self];
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

+ (FDThreadSafeMutableDictionary *)_declaredPropertiesForClass: (Class)objectClass
{
	// Store a dictionary of all the declared properties on the class so subsequent calls for the same property name can be cached.
	FDThreadSafeMutableDictionary *declaredPropertiesForClass = objc_getAssociatedObject(objectClass, _DeclaredPropertiesForClassKey);
	if (declaredPropertiesForClass == nil)
	{
		declaredPropertiesForClass = [FDThreadSafeMutableDictionary new];
		
		// TODO: Invesigate the need to wrap this in a dispatch_once because in their two seperate threads could be requesting property info for the first time at the exact same time which could lead to two dictionaries being created and one overwriting the other leading to lost data.
		objc_setAssociatedObject(objectClass, _DeclaredPropertiesForClassKey, declaredPropertiesForClass, OBJC_ASSOCIATION_RETAIN);
	}
	
	return declaredPropertiesForClass;
}


@end