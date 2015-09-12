#import "NSDictionary+URLEncode.h"

#import "FDLogger.h"
#import "NSString+URLEncode.h"


#pragma mark - Class Definition

@implementation NSDictionary (URLEncode)


#pragma mark - FDURLEncoding Methods

- (NSString *)fd_urlEncode
{
	// URL encode each key-object pair in the dictionary and concatonate them together with &.
	NSMutableString *encodedMutableString = [[NSMutableString alloc] 
		init];
	
	NSArray *keys = [self allKeys];
	
	[keys enumerateObjectsUsingBlock: ^(NSString *key, NSUInteger index, BOOL *stop)
		{
			id object = [self objectForKey: key];
			
			if ([object conformsToProtocol: @protocol(FDURLEncoding)] == YES)
			{
				NSString *urlEncodedKey = [key fd_urlEncode];
				NSString *urlEncodedObject = [object fd_urlEncode];
				
				[encodedMutableString appendFormat: (index == 0 ? @"%@=%@" : @"&%@=%@"), 
					urlEncodedKey, 
					urlEncodedObject];
			}
			else
			{
				FDLog(FDLogLevelInfo, @"Could not url encode object of class %@ because it does not conform to the FDURLCoding protocol.\nkey:\t%@\nobject:\t%@", [object class], key, object);
			}
		}];
	
	NSString *encodedString = [NSString stringWithString: encodedMutableString];
	
	return encodedString;
}


@end