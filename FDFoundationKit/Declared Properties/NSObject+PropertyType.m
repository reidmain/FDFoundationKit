#import "NSObject+PropertyType.h"
#import <objc/runtime.h>


#pragma mark Constants

static void * const _DeclaredPropertyForNameKey = (void *)&_DeclaredPropertyForNameKey;
static void * const _DeclaredPropertiesForSubclassKey = (void *)&_DeclaredPropertiesForSubclassKey;


#pragma mark - Class Definition

@implementation NSObject (PropertyType)


#pragma mark - Public Methods

+ (FDDeclaredProperty *)declaredPropertyForName: (NSString *)propertyName
{
	// Store a dictionary of all the declared properties on the class so subsequent calls for the same property name are cached.
	NSMutableDictionary *declaredProperties = objc_getAssociatedObject(self, _DeclaredPropertyForNameKey);
	if (declaredProperties == nil)
	{
		declaredProperties = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, _DeclaredPropertyForNameKey, declaredProperties, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Check if the declared property for the specified name has been cached.
	FDDeclaredProperty *declaredProperty = [declaredProperties objectForKey: propertyName];
	
	// If the declared property has not been cached create it from the property metadata.
	if(declaredProperty == nil)
	{
		objc_property_t propertyType = class_getProperty([self class], [propertyName UTF8String]);
		
		if (propertyType == nil)
		{
			return nil;
		}
		
		declaredProperty = [FDDeclaredProperty declaredPropertyForPropertyType: propertyType];
		[declaredProperties setValue: declaredProperty 
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
	NSString *subclassAsString = NSStringFromClass(subclass);

	// Store a dictionary of the declared properties for a specific subclass on the class so subsequent calls for the same subclass are cached.
	NSMutableDictionary *declaredPropertiesForSubclass = objc_getAssociatedObject(self, _DeclaredPropertiesForSubclassKey);
	if (declaredPropertiesForSubclass == nil)
	{
		declaredPropertiesForSubclass = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, _DeclaredPropertiesForSubclassKey, declaredPropertiesForSubclass, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Check if the declared properties for this subclass have already been cached.
	NSMutableArray *declaredProperties = [declaredPropertiesForSubclass objectForKey: subclassAsString];
	
	// If the declared properties have not been cached create them.
	if (declaredProperties == nil)
	{
		declaredProperties = [NSMutableArray array];
		NSMutableSet *namesOfDeclaredProperties = [NSMutableSet set];
		
		Class class = self;
		while ([class isSubclassOfClass: subclass] == YES)
		{
			unsigned int numberOfProperties = 0;
			objc_property_t *properties = class_copyPropertyList(class, &numberOfProperties);
			
			for (unsigned int i=0; i < numberOfProperties; i++)
			{
				objc_property_t propertyType = properties[i];
				
				// Load the name of the property type.
				const char *rawPropertyName = property_getName(propertyType);
				NSString *propertyName = [NSString stringWithUTF8String: rawPropertyName];
				
				// Store a dictionary of all the declared properties on the class so subsequent calls for the same property name are cached.
				NSMutableDictionary *declaredPropertiesForClass = objc_getAssociatedObject(class, _DeclaredPropertyForNameKey);
				if (declaredPropertiesForClass == nil)
				{
					declaredPropertiesForClass = [NSMutableDictionary dictionary];
					
					objc_setAssociatedObject(class, _DeclaredPropertyForNameKey, declaredPropertiesForClass, OBJC_ASSOCIATION_RETAIN);
				}
				
				// Check if the declared property for the property type has been cached.
				FDDeclaredProperty *declaredProperty = [declaredPropertiesForClass objectForKey: propertyName];
				if (declaredProperty == nil)
				{
					declaredProperty = [FDDeclaredProperty declaredPropertyForPropertyType: propertyType];
					[declaredPropertiesForClass setObject: declaredProperty 
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
			
			class = [class superclass];
		}
		
		[declaredPropertiesForSubclass setObject: declaredProperties 
			forKey: subclassAsString];
	}
	
	return declaredProperties;
}


@end