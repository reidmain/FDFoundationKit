#import "FDValueTransformer.h"


#pragma mark Constants


#pragma mark - Class Extension

@interface FDValueTransformer ()

@end


#pragma mark - Class Variables


#pragma mark - Class Definition

@implementation FDValueTransformer
{
	@private __strong FDValueTransformerBlock _transformBlock;
	@private __strong FDValueTransformerBlock _reverseTransformBlock;
}


#pragma mark - Properties


#pragma mark - Constructors

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock
{
	FDValueTransformer *transformer = [[FDValueTransformer alloc] 
		initWithBlock: transformBlock 
			reverseBlock: reverseTransformBlock];
	
	return transformer;
}

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock
{
	FDValueTransformer *transformer = [FDValueTransformer transformerWithBlock: transformBlock 
		reverseBlock: nil];
	
	return transformer;
}

- (instancetype)initWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_transformBlock = transformBlock;
	_reverseTransformBlock = reverseTransformBlock;
	
	// Return initialized instance.
	return self;
}


#pragma mark - Public Methods

+ (void)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock
{
	FDValueTransformer *valueTransformer = [FDValueTransformer transformerWithBlock: transformBlock 
		reverseBlock: reverseTransformBlock];
	
	[NSValueTransformer setValueTransformer: valueTransformer 
		forName: name];
}

+ (void)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock
{
	[self registerTransformerWithName: name 
		block: transformBlock 
		reverseBlock: nil];
}


#pragma mark - Overridden Methods

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

+ (Class)transformedValueClass
{
	return [NSObject class];
}

- (id)transformedValue: (id)value
{
	id transformedValue = _transformBlock(value);
	
	return transformedValue;
}

- (id)reverseTransformedValue: (id)value
{
	id reverseTransformedValue = nil;
	
	if (_reverseTransformBlock != nil)
	{
		reverseTransformedValue = _reverseTransformBlock(value);
	}
	
	return reverseTransformedValue;
}


#pragma mark - Private Methods


@end