#define FDWeakVar(var)            __weak_ ## var

#define FDWeakDeclare(var)        __weak id FDWeakVar(var) = var
#define FDWeakImport(var)         __typeof__(var) var = FDWeakVar(var)
#define FDWeakImportReturn(var)   FDWeakImport(var); do { if(var == nil) return; } while(NO)

#define FDWeakSelfDeclare()       FDWeakDeclare(self)
#define FDWeakSelfImport()        FDWeakImport(self)
#define FDWeakSelfImportReturn()  FDWeakImportReturn(self)


#pragma mark Class Interface

@interface FDWeakReference : NSObject


#pragma mark - Properties

@property (nonatomic, weak) id referencedObject;


#pragma mark - Constructors

+ (id)weakReferenceWithObject: (id)object;


@end