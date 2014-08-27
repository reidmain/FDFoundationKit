#import "FDDeclaredProperty.h"


#pragma mark Class Interface

/**
This category adds methods on NSObject to simplfy the creation of FDDeclaredProperty objects.
*/
@interface NSObject (PropertyType)


#pragma mark - Static Methods

/**
Loads the declared property for the specified property name on the receiver.

@param propertyName The name of the property to load metadata for.

@return Returns a declared property object if a property with the specified name exists on the receiver otherwise nil.
*/
+ (FDDeclaredProperty *)declaredPropertyForName: (NSString *)propertyName;

/**
Loads the declared property for the specified key path on the receiver.

@param keyPath The key path to the property to load metadata for.

@return Returns a declared property object if a property exists for the specified key path on the receiver otherwise nil.
*/
+ (FDDeclaredProperty *)declaredPropertyForKeyPath: (NSString *)keyPath;

/**
Loads all the declared properties on the receiver's class and its subclasses up to and including the specified subclass.

@param subclass A subclass of the receiver.

@param Returns an array of FDDeclaredProperty objects.
*/
+ (NSArray *)declaredPropertiesForSubclass: (Class)subclass;


@end