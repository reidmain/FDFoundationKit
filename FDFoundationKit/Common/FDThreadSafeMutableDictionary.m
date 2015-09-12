#import "FDThreadSafeMutableDictionary.h"


#pragma mark - Class Definition

@implementation FDThreadSafeMutableDictionary
{
	@private __strong NSMutableDictionary *_mutableDictionary;
}


#pragma mark - Initializers

- (instancetype)initWithCapacity: (NSUInteger)capacity
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_mutableDictionary = [NSMutableDictionary dictionaryWithCapacity: capacity];
	
	// Return initialized instance.
	return self;
}

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_mutableDictionary = [NSMutableDictionary new];
	
	// Return initialized instance.
	return self;
}

- (instancetype)initWithObjects: (NSArray *)objects 
	forKeys: (NSArray *)keys
{
	// Ensure there are the same number of objects as there are keys.
	if ([objects count] != [keys count])
	{
		return nil;
	}
	
	// Abort if base initializer fails.
	if ((self = [self initWithCapacity: [objects count]]) == nil)
	{
		return nil;
	}
	
	// Iterate over all the object, key pairs and add them to the dictionary.
	[objects enumerateObjectsUsingBlock: ^(id object, NSUInteger index, BOOL *stop)
		{
			id key = [keys objectAtIndex: index];
			[_mutableDictionary setObject: object 
				forKey: key];
		}];
	
	// Return initialized instance.
	return self;
}


#pragma mark - NSDictionary Overridden Methods

- (NSUInteger)count
{
	@synchronized (_mutableDictionary)
	{
		NSUInteger count = [_mutableDictionary count];
		
		return count;
	}
}

- (id)objectForKey: (id)key
{
	@synchronized (_mutableDictionary)
	{
		id object = [_mutableDictionary objectForKey: key];
		
		return object;
	}
}

- (NSEnumerator *)keyEnumerator
{
	@synchronized (_mutableDictionary)
	{
		NSEnumerator *keyEnumerator = [_mutableDictionary keyEnumerator];
		
		return keyEnumerator;
	}
}


#pragma mark - NSMutableDictionary Overridden Methods

- (void)setObject: (id)object 
	forKey: (id<NSCopying>)key
{
	@synchronized (_mutableDictionary)
	{
		[_mutableDictionary setObject: object 
			forKey: key];
	}
}

- (void)removeObjectForKey: (id)key
{
	@synchronized (_mutableDictionary)
	{
		[_mutableDictionary removeObjectForKey: key];
	}
}


@end