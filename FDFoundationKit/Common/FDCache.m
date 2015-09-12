#import "FDCache.h"

#import "FDWeakMutableDictionary.h"


#pragma mark - Class Definition

@implementation FDCache
{
	@private __strong NSCache *_cache;
	@private __strong FDWeakMutableDictionary *_weakDictionary;
}


#pragma mark - Initializers

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
	@synchronized (self)
	{
		id object = [_cache objectForKey: key];
		
		if (object == nil)
		{
			object = [_weakDictionary objectForKey: key];
		}
		
		return object;
	}
}

- (void)setObject: (id)obj 
	forKey: (id<NSCopying>)key
{
	@synchronized (self)
	{
		[_cache setObject: obj 
			forKey: key];
		[_weakDictionary setObject: obj 
			forKey: key];
	}
}

- (void)removeObjectForKey: (id)key
{
	@synchronized (self)
	{
		[_cache removeObjectForKey: key];
		[_weakDictionary removeObjectForKey: key];
	}
}

- (NSArray *)allObjects
{
	@synchronized (self)
	{
		return _weakDictionary.allValues;
	}
}


#pragma mark - NSObject Overridden Methods

- (NSString *)debugDescription
{
	NSString *description = [NSString stringWithFormat: @"<%@: %p; count = %lu>", 
		[self class], 
		self, 
		(unsigned long)[_weakDictionary count]];
	
	return description;
}


@end