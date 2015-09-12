#import "NSArray+Accessing.h"


#pragma mark - Class Definition

@implementation NSArray (Accessing)


#pragma mark - Public Methods

- (id)fd_randomObject
{
	id object = nil;
	
	if ([self count] > 0)
	{
		NSUInteger randomIndex = arc4random() % [self count];
		
		object = [self objectAtIndex: randomIndex];
	}
	
	return object;
}

- (id)fd_tryObjectAtIndex: (NSUInteger)index
{
	id object = nil;
	
	if (index < [self count])
	{
		object = [self objectAtIndex: index];
	}
	
	return object;
}


@end