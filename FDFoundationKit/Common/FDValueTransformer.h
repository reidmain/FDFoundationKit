@import Foundation;


#pragma mak - Type Definitions

typedef id (^FDValueTransformerBlock)(id value);


#pragma mark - Class Interface

/**
A block-based subclass of NSValueTransformer.
*/
@interface FDValueTransformer : NSValueTransformer


#pragma mark - Initializers

/**
Creates a transformer with the specified blocks.

@param transformBlock The forward transformation block. This parameter must not be nil.
@param reverseTransformBlock The reverse transformation block. This parameter may be nil.
*/
+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;

/**
Creates a transformer with the specified block.

@param transformBlock The forward transformation block. This parameter must not be nil.
*/
+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock;

/**
Returns an initialized transformer with the specified blocks.

This is the designated initializer for this class.

@param transformBlock The forward transformation block. This parameter must not be nil.
@param reverseTransformBlock The reverse transformation block. This parameter may be nil.
*/
- (instancetype)initWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;


#pragma mark - Static Methods

/**
Check if a transformer has already been registered with NSValueTransformer and register one if it has not.

@param name The name to register the transformer with.
@param transformBlock The forward transformation block. This parameter must not be nil.
@param reverseTransformBlock The reverse transformation block. This parameter may be nil.

@return Returns a transformer that is guaranteed to be registered with NSValueTransformer. If a transformer has already been registered under the name that does not match the same class nil will be returned.
*/
+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock;

/**
Check if a transformer has already been registered with NSValueTransformer and register one if it has not.

@param name The name to register the transformer with.
@param transformBlock The forward transformation block. This parameter must not be nil.

@see registerTransformerWithName:block:reverseBlock:
*/
+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock;


@end