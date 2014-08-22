@import Foundation;


#pragma mak Type Definitions

typedef id (^FDValueTransformerBlock)(id value);


#pragma mark - Class Interface

@interface FDValueTransformer : NSValueTransformer


#pragma mark - Constructors

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;
+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock;

- (instancetype)initWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;


#pragma mark - Static Methods

+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;
+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock;


@end