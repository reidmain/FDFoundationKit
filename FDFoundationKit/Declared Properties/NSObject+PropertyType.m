#import "NSObject+PropertyType.h"
#import <objc/runtime.h>


#pragma mark Constants

static void * const _PropertyListKey;


#pragma mark - Class Definition

@implementation NSObject (PropertyType)


#pragma mark - Public Methods

+ (FDDeclaredProperty *)declaredPropertyForName: (NSString *)propertyName
{
	// Store a dictionary of all the declared properties on the object so subsequent calls for the same property name are cached.
	NSMutableDictionary *declaredProperties = objc_getAssociatedObject(self, _PropertyListKey);
	if (declaredProperties == nil)
	{
		declaredProperties = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, _PropertyListKey, declaredProperties, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Check if the declared property for the specified name has been already cached.
	FDDeclaredProperty *declaredProperty = [declaredProperties objectForKey: propertyName];
	
	// If the declared property has not been cached create one from the metadata for the property.
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
	
	// Get the declared property on the first key.
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
	
	Class class = self;
	while ([class isSubclassOfClass: subclass] == YES)
	{
		unsigned int numberOfProperties = 0;
		objc_property_t *properties = class_copyPropertyList(class, &numberOfProperties);
		
		for (unsigned int i=0; i < numberOfProperties; i++)
		{
			objc_property_t propertyType = properties[i];
			
			// TODO: Store this declared property in the dictionary associated with the object.
			FDDeclaredProperty *declaredProperty = [FDDeclaredProperty declaredPropertyForPropertyType: propertyType];
			
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
	
	return declaredProperties;
}


@end