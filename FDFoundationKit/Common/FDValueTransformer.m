#import "FDValueTransformer.h"


#pragma mark - Class Definition

@implementation FDValueTransformer
{
	@private __strong FDValueTransformerBlock _transformBlock;
	@private __strong FDValueTransformerBlock _reverseTransformBlock;
}


#pragma mark - Initializers

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock
{
	id transformer = [[self alloc] 
		initWithBlock: transformBlock 
			reverseBlock: reverseTransformBlock];
	
	return transformer;
}

+ (instancetype)transformerWithBlock: (FDValueTransformerBlock)transformBlock
{
	id transformer = [self transformerWithBlock: transformBlock 
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

+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock 
	reverseBlock: (FDValueTransformerBlock)reverseTransformBlock
{
	id transformer = [NSValueTransformer valueTransformerForName: name];
	
	if (transformer == nil)
	{
		transformer = [self transformerWithBlock: transformBlock 
			reverseBlock: reverseTransformBlock];
		
		[NSValueTransformer setValueTransformer: transformer 
			forName: name];
	}
	else if ([transformer isKindOfClass: [self class]] == NO)
	{
//		FDLog(FDLogLevelDebug, @"There is already a value transformer registered under the name '%@' but it is not a subclass of %@", name, [self class]);
		
		transformer = nil;
	}
	
	return transformer;
}

+ (instancetype)registerTransformerWithName: (NSString *)name 
	block: (FDValueTransformerBlock)transformBlock
{
	id transformer = [self registerTransformerWithName: name 
		block: transformBlock 
		reverseBlock: nil];
	
	return transformer;
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


@end