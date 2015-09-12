@import Foundation;


#pragma mark - Class Interface

/**
This category adds methods on the NSDictionary class that make creating or modifying dictionaries easier.
*/
@interface NSDictionary (Modifying)


#pragma mark - Instance Methods

/**
Returns a new dictionary that is a copy of the receiving dictionary with the entries in another dictionary added to it.

@param dictionary A dictionary to add to the receiver.

@return A copy of the receiver with the entries in dictionary added on.
*/
- (instancetype)fd_dictionaryByAddingEntriesFromDictionary: (NSDictionary *)dictionary;


@end