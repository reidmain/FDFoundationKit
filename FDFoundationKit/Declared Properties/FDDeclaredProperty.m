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
			unichar encodeType = [attribute characterAtIndex: 1];
			switch (encodeType)
			{
				case 'c':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingChar;
					
					break;
				}
				
				case 'i':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingInt;
					
					break;
				}
				
				case 's':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingShort;
					
					break;
				}
				
				case 'l':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingLong;
					
					break;
				}
				
				case 'q':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingLongLong;
					
					break;
				}
				
				case 'C':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingUnsignedChar;
					
					break;
				}
				
				case 'I':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingUnsignedInt;
					
					break;
				}
				
				case 'S':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingUnsignedShort;
					
					break;
				}
				
				case 'L':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingUnsignedLong;
					
					break;
				}
				
				case 'Q':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingUnsignedLongLong;
					
					break;
				}
				
				case 'f':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingFloat;
					
					break;
				}
				
				case 'd':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingDouble;
					
					break;
				}
				
				case 'B':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingBool;
					
					break;
				}
				
				case '*':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingCharacterString;
					
					break;
				}
				
				case '@':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingObject;
					
					// If the attribute contains quotes the object class can be extracted.
					NSRange quoteRange = [attribute rangeOfString: @"\""];
					if (quoteRange.location != NSNotFound)
					{
						NSString *objectClassString = [attribute substringFromIndex: 2];
						
						objectClassString = [objectClassString stringByReplacingOccurrencesOfString: @"\""
							withString: @""];
						
						declaredProperty->_objectClass = NSClassFromString(objectClassString);
					}
					
					break;
				}
				
				case '#':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingClass;
					
					break;
				}
				
				case ':':
				{
					declaredProperty->_typeEncoding = FDDeclaredPropertyTypeEncodingSelector;
					
					break;
				}
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
			declaredProperty->_isReadOnly = YES;
		}
		// If the first character is a "N" the attribute indicates the property is non-atomic.
		else if (firstCharacter == 'N')
		{
			declaredProperty->_isNonAtomic = YES;
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
		// If the first character is a "G" the attribute indicates the property has a custom getter.
		else if (firstCharacter == 'G')
		{
			declaredProperty->_customGetterSelectorName = [attribute substringFromIndex: 1];
		}
		// If the first character is a "S" the attribute indicates the property has a custom setter.
		else if (firstCharacter == 'S')
		{
			declaredProperty->_customSetterSelectorName = [attribute substringFromIndex: 1];
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
		_objectClass ?: [self _typeEncodingAsString]];
	
	return description;
}


#pragma mark - Private Methods

- (NSString *)_typeEncodingAsString
{
	NSString *typeEncodingAsString = nil;
	
	switch (_typeEncoding)
	{
		case FDDeclaredPropertyTypeEncodingUnknown:
		{
			typeEncodingAsString = @"Unknown";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingChar:
		{
			typeEncodingAsString = @"Char";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingInt:
		{
			typeEncodingAsString = @"Int";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingShort:
		{
			typeEncodingAsString = @"Short";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingLong:
		{
			typeEncodingAsString = @"Long";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingLongLong:
		{
			typeEncodingAsString = @"Long Long";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingUnsignedChar:
		{
			typeEncodingAsString = @"Unsigned Char";
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingUnsignedInt:
		{
			typeEncodingAsString = @"Unsigned Int";
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingUnsignedShort:
		{
			typeEncodingAsString = @"Unsigned Int";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingUnsignedLong:
		{
			typeEncodingAsString = @"Unsigned Long";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingUnsignedLongLong:
		{
			typeEncodingAsString = @"Unsigned Long Long";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingFloat:
		{
			typeEncodingAsString = @"Float";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingDouble:
		{
			typeEncodingAsString = @"Double";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingBool:
		{
			typeEncodingAsString = @"Bool";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingCharacterString:
		{
			typeEncodingAsString = @"Character String";
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingObject:
		{
			typeEncodingAsString = @"Object";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingClass:
		{
			typeEncodingAsString = @"Class";
			
			break;
		}
		
		case FDDeclaredPropertyTypeEncodingSelector:
		{
			typeEncodingAsString = @"Selector";
			
			break;
		}
	}
	
	return typeEncodingAsString;
}


@end