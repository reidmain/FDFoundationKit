@import Foundation;
@import ObjectiveC;


#pragma mark Constants


#pragma mark - Enumerations


#pragma mark - Class Interface

@interface FDDeclaredProperty : NSObject


#pragma mark - Properties

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) Class type;
@property (nonatomic, copy) NSString *encodeType;


#pragma mark - Constructors

+ (instancetype)declaredPropertyForPropertyType: (objc_property_t)propertyType;


#pragma mark - Static Methods


#pragma mark - Instance Methods


@end