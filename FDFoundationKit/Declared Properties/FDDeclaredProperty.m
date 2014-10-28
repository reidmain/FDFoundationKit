#import "FDDeclaredProperty.h"


#pragma mark Class Definition

@implementation FDDeclaredProperty


#pragma mark - Constructors

+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType
{
	// Create an instance of FDDeclaredProperty.
	FDDeclaredProperty *declaredProperty = [FDDeclaredProperty new];
	
	// Load the name of the property type.
	const char *propertyName = property_getName(propertyType);
	declaredProperty->_name = [NSString stringWithUTF8String: propertyName];
	
	// Load the attribute string for the property type.
	const char *attributesCString = property_getAttributes(propertyType);
	NSString *attributesString = [NSString stringWithUTF8String: attributesCString];
	
	// Break the attributes string up into its component attributes.
	NSArray *attributes = [attributesString componentsSeparatedByString: @","];
	
	// Iterate over all the attributes and extract the releveant information.
	for (NSString *attribute in attributes)
	{
		unichar firstCharacter = [attribute characterAtIndex: 0];
		
		// If the first character is a "T" the attribute describes the type of the property.
		if (firstCharacter == 'T')
		{
			// If the attribute contains quotes the property is an object type.
			NSRange quoteRange = [attribute rangeOfString: @"\""];
			if (quoteRange.location != NSNotFound)
			{
				NSString *typeName = [attribute substringFromIndex: 2];
				
				typeName = [typeName stringByReplacingOccurrencesOfString: @"\""
					withString: @""];
				
				declaredProperty->_type = NSClassFromString(typeName);
			}
			// If the attribute does not contain quotes the property is an id or non-object type so extract the @encode type.
			else
			{
				NSString *encodeType = [attribute substringFromIndex: 1];
				declaredProperty->_encodeType = encodeType;
			}
		}
		// If the first character is a "&" the attribute indicates the property retains the value.
		else if (firstCharacter == '&')
		{
			declaredProperty->_memoryManagementPolicy = FDDeclaredPropertyMemoryManagementPolicyRetain;
		}
		// If the first character is a "C" the attribute indicates the property copies the value.
		else if (firstCharacter == 'C')
		{
			declaredProperty->_memoryManagementPolicy = FDDeclaredPropertyMemoryManagementPolicyCopy;
		}
		// If the first character is a "W" the attribute indicates the property weakly references the value.
		else if (firstCharacter == 'W')
		{
			declaredProperty->_isWeakReference = YES;
		}
		// If the first character is a "R" the attribute indicates the property is read-only.
		else if (firstCharacter == 'R')
		{
			declaredProperty->_isReadonly = YES;
		}
		// If the first character is a "N" the attribute indicates the property is non-atomic.
		else if (firstCharacter == 'N')
		{
			declaredProperty->_isNonatomic = YES;
		}
		// If the first character is a "D" the attribute indicates the property is dynamic.
		else if (firstCharacter == 'D')
		{
			declaredProperty->_isDynamic = YES;
		}
		// If the first character is a "V" the attribute describes the name of the backing instance variable of the property.
		else if (firstCharacter == 'V')
		{
			declaredProperty->_backingInstanceVariableName = [attribute substringFromIndex: 1];
		}
	}
	
	return declaredProperty;
}


#pragma mark - Overridden Methods

- (NSString *)debugDescription
{
	NSString *description = [NSString stringWithFormat: @"<%@: %p; name = %@; type = %@>", 
		[self class], 
		self, 
		_name, 
		_type ?: _encodeType];
	
	return description;
}


@end