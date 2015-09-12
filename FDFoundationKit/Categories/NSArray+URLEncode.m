#import "NSArray+URLEncode.h"
#import "NSString+URLEncode.h"

#import "FDLogger.h"


#pragma mark - Class Definition

@implementation NSArray (URLEncode)


#pragma mark - FDURLEncoding Methods

- (NSString *)fd_urlEncode
{
	// URL encode each object in the array and concatonate them together with commas.
	NSMutableString *encodedMutableString = [[NSMutableString alloc] 
		init];
	
	[self enumerateObjectsUsingBlock: ^(id object, NSUInteger index, BOOL *stop)
		{
			if ([object conformsToProtocol: @protocol(FDURLEncoding)] == YES)
			{
				NSString *urlEncodedObject = [object fd_urlEncode];
				
				[encodedMutableString appendFormat: (index == 0 ? @"%@" : @",%@"), 
					urlEncodedObject];
			}
			else
			{
				FDLog(FDLogLevelInfo, @"Could not url encode object of class %@ because it does not conform to the FDURLCoding protocol.\n%@", [object class], object);
			}
		}];
	
	NSString *encodedString = [NSString stringWithString: encodedMutableString];
	
	return encodedString;
}


@end