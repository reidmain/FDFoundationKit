@import Foundation;


#pragma mark Class Interface

/**
FDCache is a wrapper object that behaves almost identically to NSCache. The subtle difference is that FDCache ensures that any object that is still being referenced by something other than the cache cannot be ejected from the cache.
*/
@interface FDCache : NSObject


#pragma mark - Instance Methods

/**
Returns the object associated with the specified key.

@param key The key for which to return the corresponding object.

@return The object associated with the key, or nil if no object is associated with the key.
*/
- (id)objectForKey: (id)key;

/**
Associates the object with the specified key in the cache.

@param object The object to store in the cache.
@param key The key that the object is associated with.
*/
- (void)setObject: (id)object 
	forKey: (id<NSCopying>)key;

/**
Removes the object associated with the specified key.

@param key The key for which to remove the corresponding object.
*/
- (void)removeObjectForKey: (id)key;

/**
Returns a new array containing all of the objects stored in the cache.
*/
- (NSArray *)allObjects;


@end