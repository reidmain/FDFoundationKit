@import Foundation;


#pragma mark - Class Interface

/**
This category adds methods on NSString to provide a variety of hashing functions.
*/
@interface NSString (Hashing)


#pragma mark - Instance Methods

/**
Returns the receiver run through a SHA256 hashing function.
*/
- (NSString *)fd_sha256HashString;


@end