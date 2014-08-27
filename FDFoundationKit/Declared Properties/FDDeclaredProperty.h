@import Foundation;
@import ObjectiveC;


#pragma mark Class Interface

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


#pragma mark - Constructors

/**
Creates a declared property from the metadata of the specified property type.

@param propertyType The property type to extract the metadata from.
*/
+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType;


@end