#import "FDDeclaredPropertyTestModel.h"


#pragma mark - Class Interface

@interface FDDeclaredPropertyTestModelSubclass : FDDeclaredPropertyTestModel


#pragma mark - Properties

@property (nonatomic, strong) NSString *randomString;
@property (nonatomic, readonly) NSArray *randomArray;
@property (nonatomic, readonly) NSDictionary *randomDictionary;


@end