@import Foundation;
@import XCTest;

@import FDFoundationKit;


@interface FDWeakMutableDictionaryTests : XCTestCase

@end

@implementation FDWeakMutableDictionaryTests

- (void)testAllValues
{
	// Test to make sure that allValues on FDWeakMutableDictionary works even if some of the values inside it have been released from memory.
	FDWeakMutableDictionary *weakMutableDictionary = [FDWeakMutableDictionary new];
	NSMutableArray *mutArray = [NSMutableArray new];
	
	for (int i=0; i < 1000; i++)
	{
		NSObject *object = [NSObject new];
		
		[weakMutableDictionary setObject: object 
			forKey: @(i)];
		
		// Generate a random number to determine whether or not to strongly retain an object.
		if (arc4random_uniform(2) == 0)
		{
			[mutArray addObject:object];
		}
	}
	
	[weakMutableDictionary allValues];
}


@end