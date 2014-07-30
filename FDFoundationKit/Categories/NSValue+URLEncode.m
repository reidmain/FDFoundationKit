#import "NSValue+URLEncode.h"
#import "NSString+URLEncode.h"


#pragma mark Class Definition

@implementation NSValue (URLEncode)


#pragma mark - Public Methods

- (NSString *)urlEncode
{
	NSString *description = [self description];
	
	NSString *encodedString = [description urlEncode];
	
	return encodedString;
}


@end