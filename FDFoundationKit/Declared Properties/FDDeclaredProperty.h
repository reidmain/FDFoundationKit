@import Foundation;
@import ObjectiveC;


#pragma mark Enumerations

typedef NS_ENUM(NSUInteger, FDDeclaredPropertyMemoryManagementPolicy)
{
	/// The declared property assigns the value when it is set.
    FDDeclaredPropertyMemoryManagementPolicyAssign,
	
	/// The declared property retains the value when it is set.
    FDDeclaredPropertyMemoryManagementPolicyRetain,
	
	/// The declared property copies the value when it is set.
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

If encodedType is not nil then this will be nil.
*/
@property (nonatomic, readonly) Class type;

/**
The Objective-C type encoding of the declared property.

If type is not nil then this will be nil.
*/
@property (nonatomic, readonly) NSString *encodeType;

/**
The memory management policy of the declared property.
*/
@property (nonatomic, readonly) FDDeclaredPropertyMemoryManagementPolicy *memoryManagementPolicy;

/**
A Boolean value that indicates whether or not the declared property is a weak-reference.
*/
@property (nonatomic, readonly) BOOL isWeakReference;

/**
A Boolean value that indicates whether or not the declared property is read-only.
*/
@property (nonatomic, readonly) BOOL isReadonly;

/**
A Boolean value that indicates whether or not the declared property is non-atomic.
*/
@property (nonatomic, readonly) BOOL isNonatomic;

/**
A Boolean value that indicates whether or not the declared property is dynamic.
*/
@property (nonatomic, readonly) BOOL isDynamic;

/**
The name of the backing instance variable of the declared property.
*/
@property (nonatomic, readonly) NSString *backingInstanceVariableName;


#pragma mark - Constructors

/**
Creates a declared property from the metadata of the specified property type.

@param propertyType The property type to extract the metadata from.
*/
+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType;


@end