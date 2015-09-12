#import "NSString+URLEncode.h"


#pragma mark - Class Definition

@implementation NSString (URLEncode)


#pragma mark - Public Methods

- (NSString *)fd_urlDecode
{
	NSString *decodedString = [self stringByRemovingPercentEncoding];
	
	return decodedString;
}


#pragma mark - FDURLEncoding Methods

- (NSString *)fd_urlEncode
{
	NSString *charactersToEscape = @"!*'();:@&=+$,/?#[]%\" |";
	NSCharacterSet *characterSetToEscape = [NSCharacterSet characterSetWithCharactersInString: charactersToEscape];
	NSCharacterSet *allowedCharacters = [characterSetToEscape invertedSet];
	
	NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacters];
	
	return encodedString;
}


@end