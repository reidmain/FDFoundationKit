#import "FDCache.h"
#import "FDWeakMutableDictionary.h"


#pragma mark Class Definition

@implementation FDCache
{
	@private __strong NSCache *_cache;
	@private __strong FDWeakMutableDictionary *_weakDictionary;
}


#pragma mark - Constructors

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_cache = [NSCache new];
	_weakDictionary = [FDWeakMutableDictionary new];
	
	// Return initialized instance.
	return self;
}


#pragma mark - Public Methods

- (id)objectForKey: (id)key
{
	id object = [_cache objectForKey: key];
	
	if (object == nil)
	{
		object = [_weakDictionary objectForKey: key];
	}
	
	return object;
}

- (void)setObject: (id)obj 
	forKey: (id<NSCopying>)key
{
	[_cache setObject: obj 
		forKey: key];
	[_weakDictionary setObject: obj 
		forKey: key];
}


#pragma mark - Overridden Methods

- (NSString *)description
{
	NSString *description = [NSString stringWithFormat: @"<%@: %p; count = %lu>", 
		[self class], 
		self, 
		(unsigned long)[_weakDictionary count]];
	
	return description;
}


@end