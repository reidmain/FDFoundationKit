#import "FDWeakMutableDictionary.h"
#import "FDWeakReference.h"
#import "FDThreadSafeMutableDictionary.h"


#pragma mark Class Definition

@implementation FDWeakMutableDictionary
{
	@private __strong FDThreadSafeMutableDictionary *_mutableDictionary;
}


#pragma mark - Constructors

- (instancetype)initWithCapacity: (NSUInteger)capacity
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_mutableDictionary = [FDThreadSafeMutableDictionary dictionaryWithCapacity: capacity];
	
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
			[self setObject: object 
				forKey: key];
		}];
	
	// Return initialized instance.
	return self;
}


#pragma mark - Overridden Methods

- (NSUInteger)count
{
	NSUInteger count = [_mutableDictionary count];
	
	return count;
}

- (id)objectForKey: (id)key
{
	FDWeakReference *weakReference = [_mutableDictionary objectForKey: key];
	
	id object = weakReference.referencedObject;
	
	// If the reference object is nil it has been released from memory and so the key can be removed from the dictionary.
	if (object == nil 
		&& key != nil)
	{
		[_mutableDictionary removeObjectForKey: key];
	}
	
	return object;
}

- (NSEnumerator *)keyEnumerator
{
	// Return an enumerator from an array of all the keys because using the dictionary's keyEnumerator could cause an exception since -objectForKey: modifies the dictionary.
	NSEnumerator *keyEnumerator = [[_mutableDictionary allKeys] objectEnumerator];
	
	return keyEnumerator;
}

- (void)setObject: (id)object 
	forKey: (id<NSCopying>)key
{
	// Wrap the object in a weak reference so the dictionary does not retain the object.
	FDWeakReference *weakReference = [FDWeakReference weakReferenceWithObject: object];
	
	[_mutableDictionary setObject: weakReference 
		forKey: key];
}

- (void)removeObjectForKey: (id)key
{
	[_mutableDictionary removeObjectForKey: key];
}


@end