#import "NSDictionary+URLEncode.h"
#import "NSString+URLEncode.h"


#pragma mark Class Definition

@implementation NSDictionary (URLEncode)


#pragma mark - Public Methods

- (NSString *)urlEncode
{
	// URL encode each key-object pair in the dictionary and concatonate them together with &.
	NSMutableString *encodedMutableString = [[NSMutableString alloc] 
		init];
	
	NSArray *keys = [self allKeys];
	
	[keys enumerateObjectsUsingBlock: ^(NSString *key, NSUInteger index, BOOL *stop)
		{
			id object = [self objectForKey: key];
			
			NSString *urlEncodedKey = [key urlEncode];
			NSString *urlEncodedObject = [[object description] urlEncode];
			
			[encodedMutableString appendFormat: (index == 0 ? @"%@=%@" : @"&%@=%@"), 
				urlEncodedKey, 
				urlEncodedObject];
		}];
	
	NSString *encodedString = [NSString stringWithString: encodedMutableString];
	
	return encodedString;
}


@end