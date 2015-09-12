#import "NSValue+URLEncode.h"

#import "NSString+URLEncode.h"


#pragma mark - Class Definition

@implementation NSValue (URLEncode)


#pragma mark - Public Methods

- (NSString *)fd_urlEncode
{
	NSString *description = [self description];
	
	NSString *encodedString = [description fd_urlEncode];
	
	return encodedString;
}


@end