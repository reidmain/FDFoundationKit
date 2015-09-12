@import Foundation;


#pragma mark - Protocol

/**
The FDURLEncoding protocol is adopted by an object that can be URL encoded.
*/
@protocol FDURLEncoding
<
	NSObject
>


#pragma mark - Required Methods

@required

/**
Returns a string that is receiver URL encoded.
*/
- (NSString *)fd_urlEncode;


@end