@import Foundation;
@import ObjectiveC;


#pragma mark - Enumerations

typedef NS_ENUM(NSUInteger, FDDeclaredPropertyTypeEncoding)
{
    FDDeclaredPropertyTypeEncodingUnknown,
    FDDeclaredPropertyTypeEncodingChar,
    FDDeclaredPropertyTypeEncodingInt,
    FDDeclaredPropertyTypeEncodingShort,
    FDDeclaredPropertyTypeEncodingLong,
    FDDeclaredPropertyTypeEncodingLongLong,
    FDDeclaredPropertyTypeEncodingUnsignedChar,
    FDDeclaredPropertyTypeEncodingUnsignedInt,
    FDDeclaredPropertyTypeEncodingUnsignedShort,
    FDDeclaredPropertyTypeEncodingUnsignedLong,
    FDDeclaredPropertyTypeEncodingUnsignedLongLong,
    FDDeclaredPropertyTypeEncodingFloat,
    FDDeclaredPropertyTypeEncodingDouble,
    FDDeclaredPropertyTypeEncodingBool,
    FDDeclaredPropertyTypeEncodingCharacterString,
    FDDeclaredPropertyTypeEncodingObject,
    FDDeclaredPropertyTypeEncodingClass,
	FDDeclaredPropertyTypeEncodingSelector,
};

typedef NS_ENUM(NSUInteger, FDDeclaredPropertyMemoryManagementPolicy)
{
	/// The value of declared property is assigned when it is set.
    FDDeclaredPropertyMemoryManagementPolicyAssign,

	/// The value of declared property is retained when it is set.	
    FDDeclaredPropertyMemoryManagementPolicyRetain,
	
	/// The value of declared property is copied when it is set.
    FDDeclaredPropertyMemoryManagementPolicyCopy,
};


#pragma mark - Class Interface

/**
The FDDeclaredProperty class encapsulates the metadata associated with a property declaration.
*/
@interface FDDeclaredProperty : NSObject


#pragma mark - Properties

/**
The name of the declared property.
*/
@property (nonatomic, readonly) NSString *name;

/**
The class of the declared property.

If typeEncoding is FDDeclaredPropertyTypeEncodingObject this will not be nil.
*/
@property (nonatomic, readonly) Class objectClass;

/**
The Objective-C type encoding of the declared property.
*/
@property (nonatomic, readonly) FDDeclaredPropertyTypeEncoding typeEncoding;

/**
The memory management policy of the declared property.
*/
@property (nonatomic, readonly) FDDeclaredPropertyMemoryManagementPolicy memoryManagementPolicy;

/**
A Boolean value that indicates whether or not the declared property is a weak-reference.
*/
@property (nonatomic, readonly) BOOL isWeakReference;

/**
A Boolean value that indicates whether or not the declared property is read-only.
*/
@property (nonatomic, readonly) BOOL isReadOnly;

/**
A Boolean value that indicates whether or not the declared property is non-atomic.
*/
@property (nonatomic, readonly) BOOL isNonAtomic;

/**
A Boolean value that indicates whether or not the declared property is dynamic.
*/
@property (nonatomic, readonly) BOOL isDynamic;

/**
The name of the backing instance variable of the declared property.
*/
@property (nonatomic, readonly) NSString *backingInstanceVariableName;

/**
The name of the getter selector of the declared property. This is nil if a custom getter was not defined.
*/
@property (nonatomic, readonly) NSString *customGetterSelectorName;

/**
The name of the setter selector of the declared property. This is nil if a custom setter was not defined.
*/
@property (nonatomic, readonly) NSString *customSetterSelectorName;


#pragma mark - Constructors

/**
Creates a declared property from the metadata of the specified property type.

@param propertyType The property type to extract the metadata from.
*/
+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType;


@end