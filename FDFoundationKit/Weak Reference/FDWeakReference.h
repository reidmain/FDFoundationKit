@import Foundation;


#pragma mark - Macros

#define FDWeakVar(var)            __weak_ ## var

#define FDWeakDeclare(var)        __weak id FDWeakVar(var) = var
#define FDWeakImport(var)         __typeof__(var) var = FDWeakVar(var)
#define FDWeakImportReturn(var)   FDWeakImport(var); do { if(var == nil) return; } while(NO)

#define FDWeakSelfDeclare()       FDWeakDeclare(self)
#define FDWeakSelfImport()        FDWeakImport(self)
#define FDWeakSelfImportReturn()  FDWeakImportReturn(self)


#pragma mark - Class Interface

/**
FDWeakRefence is a class designed to encapsulate weak references to Objective-C objects. Primarily used for having weak references in collections.
*/
@interface FDWeakReference : NSObject


#pragma mark - Properties

/**
A weak reference to the referenced object.
*/
@property (nonatomic, weak) id referencedObject;


#pragma mark - Initializers

/**
Creates a weak reference to the specified object.

@param object The object to reference weakly.
*/
+ (id)weakReferenceWithObject: (id)object;


@end