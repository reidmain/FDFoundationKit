#import "NSString+URLEncode.h"


#pragma mark Class Definition

@implementation NSString (URLEncode)


#pragma mark - Public Methods

- (NSString *)urlEncode
{
	CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(
		kCFAllocatorDefault, 
		(CFStringRef)self, 
		NULL, 
		(CFStringRef)@"!*'();:@&=+$,/?%#[]",
		kCFStringEncodingUTF8);
	
	return (__bridge_transfer NSString *)encodedString;
}


@end