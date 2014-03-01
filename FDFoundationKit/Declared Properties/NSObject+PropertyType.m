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
		
		declaredProperty = [FDDeclaredProperty new];
		[declaredProperties setValue: declaredProperty 
			forKey: propertyName];
		
		const char *attributesString = property_getAttributes(propertyType);
		
		// If the property is an object type it should contain a quoted string so look for the first quotation marks.
		const char *startOfTypeString = strchr(attributesString, '"') ;
		if (startOfTypeString != nil)
		{
			// Increment the start of the type string by one to move past the quotation marks.
			startOfTypeString++;
			
			// Look for the second quotation marks.
			const char *endOfTypeString = strchr(startOfTypeString, '"');
			
			// Calculate the length of the class name.
			size_t classNameLength = endOfTypeString - startOfTypeString;
			
			char className[classNameLength + 1];
			className[classNameLength] = '\0';
			strncpy(className, startOfTypeString, classNameLength);
			
			declaredProperty.type = objc_getClass(className);
		}
	}
	
	return declaredProperty;
}


@end