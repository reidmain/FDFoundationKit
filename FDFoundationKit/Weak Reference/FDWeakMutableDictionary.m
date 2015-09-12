#import "FDWeakMutableDictionary.h"

#import "FDThreadSafeMutableDictionary.h"
#import "FDWeakReference.h"


#pragma mark - Class Definition

@implementation FDWeakMutableDictionary
{
	@private __strong FDThreadSafeMutableDictionary *_mutableDictionary;
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
	_mutableDictionary = [FDThreadSafeMutableDictionary dictionaryWithCapacity: capacity];
	
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
	_mutableDictionary = [FDThreadSafeMutableDictionary new];
	
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

- (NSArray *)allValues
{
	// NOTE: The default NSDictionary implementation of allValues cannot be used because it appears that it uses getObjects:andKeys: which breaks because objectForKey: can return back nil which results in nil attempting to be added to NSArray which is impossible and results in an exception. 
	NSMutableArray *allValues = [NSMutableArray new];
	
	[self enumerateKeysAndObjectsUsingBlock: ^(id key, id object, BOOL *stop)
		{
			if (object != nil)
			{
				[allValues addObject: object];
			}
		}];
	
	return allValues;
}


@end