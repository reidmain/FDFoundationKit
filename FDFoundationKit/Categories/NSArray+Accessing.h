@import Foundation;


#pragma mark Class Interface

/**
This category adds methods on the NSArray class to make accessing elements easier.
*/
@interface NSArray (Accessing)


#pragma mark - Instance Methods

/**
Returns a random object in the array.
*/
- (id)randomObject;

/**
Returns the object located at the specified index, if that index is within the bounds of the array.

@param index An index that may be inside the bounds of the array.

@return The object located at index if it is within the bounds of the array otherwise nil.
*/
- (id)tryObjectAtIndex: (NSUInteger)index;


@end