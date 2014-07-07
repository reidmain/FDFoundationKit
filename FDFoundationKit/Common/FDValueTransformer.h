@import Foundation;


#pragma mak Type Definitions

typedef id (^FDValueTransformerBlock)(id value);


#pragma mark - Constants


#pragma mark - Enumerations


#pragma mark - Class Interface

@interface FDValueTransformer : NSValueTransformer


#pragma mark - Properties


#pragma mark - Constructors

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;
+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock;

- (instancetype)initWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;

+ (void)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;
+ (void)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock;


#pragma mark - Static Methods


#pragma mark - Instance Methods


@end