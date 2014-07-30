@import Foundation;
#import "FDURLEncoding.h"


#pragma mark Class Interface

@interface NSString (URLEncode) <FDURLEncoding>


#pragma mark - Instance Methods

- (NSString *)urlDecode;


@end