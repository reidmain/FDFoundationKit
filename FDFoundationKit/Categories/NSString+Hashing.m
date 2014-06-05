#import "NSString+Hashing.h"
#include <CommonCrypto/CommonDigest.h>


#pragma mark Class Definition

@implementation NSString (Hashing)


#pragma mark - Public Methods

- (NSString *)sha256HashString
{
	const char *message = [self UTF8String];
	unsigned char messageDigest[CC_SHA256_DIGEST_LENGTH];
	
	CC_SHA256(message, (CC_LONG)strlen(message), messageDigest);
	
	NSMutableString *hashString = [NSMutableString new];
	for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
	{
		[hashString appendFormat:@"%02x", 
			messageDigest[i]];
	}
	
	return hashString;
}


@end