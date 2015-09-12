@import Foundation;


#pragma mark - Class Interface

/**
This category adds methods on the NSDictionary class to make accessing elements easier.
*/
@interface NSDictionary (Accessing)


/**
Returns the value associated with a given key and ensures that it is not NSNull.

@param key The key for which to return the corresponding value.

@return The value associated with the key, or nil if no value is associated with the key or the value is NSNull.
*/
#pragma mark - Instance Methods

- (id)fd_nonNullObjectForKey: (id)key;


@end