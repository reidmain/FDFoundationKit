#import "FDDeclaredProperty.h"


#pragma mark - Class Interface

/**
This category adds methods on NSObject to simplfy the creation of FDDeclaredProperty objects.
*/
@interface NSObject (DeclaredProperty)


#pragma mark - Static Methods

/**
Loads the declared property for the specified property name on the receiver.

@param propertyName The name of the property to load metadata for.

@return Returns a declared property object if a property with the specified name exists on the receiver otherwise nil.
*/
+ (FDDeclaredProperty *)fd_declaredPropertyForName: (NSString *)propertyName;

/**
Loads the declared property for the specified key path on the receiver.

@param keyPath The key path to the property to load metadata for.

@return Returns a declared property object if a property exists for the specified key path on the receiver otherwise nil.
*/
+ (FDDeclaredProperty *)fd_declaredPropertyForKeyPath: (NSString *)keyPath;

/**
Loads all the declared properties on the receiver's class and its superclasses up to but not including the specified superclass.

@param superclass A superclass of the receiver that is the upper bounds for what properties should be returned. If nil it defaults NSObject.

@param Returns an array of FDDeclaredProperty objects.
*/
+ (NSArray *)fd_declaredPropertiesUntilSuperclass: (Class)superclass;


@end