#import "FDDeclaredProperty.h"


#pragma mark Constants


#pragma mark - Class Extension

@interface FDDeclaredProperty ()

@end


#pragma mark - Class Variables


#pragma mark - Class Definition

@implementation FDDeclaredProperty


#pragma mark - Properties


#pragma mark - Constructors

+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType
{
	// Create an instance of FDDeclaredProperty.
	FDDeclaredProperty *declaredProperty = [FDDeclaredProperty new];
	
	// Load the name of the property type.
	const char *propertyName = property_getName(propertyType);
	declaredProperty.name = [NSString stringWithUTF8String: propertyName];
	
	// Load the attribute string for the property type.
	const char *attributesString = property_getAttributes(propertyType);
	
	// If the property is an object type the attribute string should contain a quoted string so look for the first set of quotation marks.
	const char *startOfTypeString = strchr(attributesString, '"') ;
	if (startOfTypeString != nil)
	{
		// Increment the start of the type string by one to move past the quotation marks.
		startOfTypeString++;
		
		// Look for the second set of quotation marks.
		const char *endOfTypeString = strchr(startOfTypeString, '"');
		
		// Calculate the length of the class name.
		size_t classNameLength = endOfTypeString - startOfTypeString;
		
		// Extract the class name from the attributes string.
		char className[classNameLength + 1];
		className[classNameLength] = '\0';
		strncpy(className, startOfTypeString, classNameLength);
		
		declaredProperty.type = objc_getClass(className);
	}
	// If the property is an id or not an object type extract the @encode type.
	else
	{
		// The attribute string must start with "T" so increment the start of the string by one to get the start of the type string.
		const char *typeString = attributesString + 1;
		const char *nextTypeString = NSGetSizeAndAlignment(typeString, nil, nil);
		if (nextTypeString != nil)
		{
			size_t typeLength = nextTypeString - typeString;
			
			char type[typeLength + 1];
			type[typeLength] = '\0';
			strncpy(type, typeString, typeLength);
			
			declaredProperty.encodeType = [NSString stringWithUTF8String: type];
		}
	}
	
	return declaredProperty;
}

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	
	// Return initialized instance.
	return self;
}


#pragma mark - Public Methods


#pragma mark - Overridden Methods

- (NSString *)description
{
	NSString *description = [NSString stringWithFormat: @"<%@: %p; name = %@; type = %@>", 
		[self class], 
		self, 
		_name, 
		_type ?: _encodeType];
	
	return description;
}


#pragma mark - Private Methods


@end