#import "FDDeclaredProperty.h"


#pragma mark Class Interface

@interface NSObject (PropertyType)


#pragma mark - Static Methods

+ (FDDeclaredProperty *)declaredPropertyForName: (NSString *)propertyName;
+ (FDDeclaredProperty *)declaredPropertyForKeyPath: (NSString *)keyPath;
+ (NSArray *)declaredPropertiesForSubclass: (Class)subclass;


@end