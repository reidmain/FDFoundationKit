#import "NSDictionary+Modifying.h"


#pragma mark Class Definition

@implementation NSDictionary (Modifying)


#pragma mark - Properties


#pragma mark - Public Methods

- (instancetype)dictionaryByAddingEntriesFromDictionary: (NSDictionary *)dictionary
{
	// Make a copy of self.
	NSMutableDictionary *copiedDictionary = [self mutableCopy];
	
	// Add the dictionary to the copy of self.
	[copiedDictionary addEntriesFromDictionary: dictionary];
	
	// Return the copy.
	return copiedDictionary;
}


@end