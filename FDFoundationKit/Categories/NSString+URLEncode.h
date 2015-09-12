@import Foundation;

#import "FDURLEncoding.h"


#pragma mark - Class Interface

/**
This category ensures that NSString conforms to the FDURLEncoding protocol.

It also adds a method to allow for URL decoding.
*/
@interface NSString (URLEncode)
<
	FDURLEncoding
>


#pragma mark - Instance Methods

/**
Returns a string that is receiver URL decoded.
*/
- (NSString *)fd_urlDecode;


@end