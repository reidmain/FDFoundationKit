#import "FDThreadSafeMutableDictionary.h"


#pragma mark Constants


#pragma mark - Class Extension

@interface FDThreadSafeMutableDictionary ()

@end


#pragma mark - Class Variables


#pragma mark - Class Definition

@implementation FDThreadSafeMutableDictionary
{
	@private __strong NSMutableDictionary *_mutableDictionary;
}


#pragma mark - Properties


#pragma mark - Constructors

- (instancetype)initWithCapacity: (NSUInteger)capacity
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

- (id)init
{
	// Abort if base initializer fails.
	if ((self = [self initWithCapacity: 0]) == nil)
	{
		return nil;
	}
	
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


#pragma mark - Overridden Methods

- (NSUInteger)count
{
	@synchronized (self)
	{
		NSUInteger count = [_mutableDictionary count];
		
		return count;
	}
}

- (id)objectForKey: (id)key
{
	@synchronized (self)
	{
		id object = [_mutableDictionary objectForKey: key];
		
		return object;
	}
}

- (NSEnumerator *)keyEnumerator
{
	@synchronized (self)
	{
		NSEnumerator *keyEnumerator = [_mutableDictionary keyEnumerator];
		
		return keyEnumerator;
	}
}

- (void)setObject: (id)object 
	forKey: (id<NSCopying>)key
{
	@synchronized (self)
	{
		[_mutableDictionary setObject: object 
			forKey: key];
	}
}

- (void)removeObjectForKey: (id)key
{
	@synchronized (self)
	{
		[_mutableDictionary removeObjectForKey: key];
	}
}


@end