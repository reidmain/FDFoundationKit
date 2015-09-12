@import Foundation;


#pragma mark - Class Interface

@interface FDDeclaredPropertyTestModel : NSObject


#pragma mark - Properties

@property (nonatomic, assign) char charProperty;
@property (nonatomic, assign) int intProperty;
@property (nonatomic, assign) short shortProperty;
@property (nonatomic, assign) long longProperty;
@property (nonatomic, assign) long long longLongProperty;
@property (nonatomic, assign) unsigned char unsignedCharProperty;
@property (nonatomic, assign) unsigned int unsignedIntProperty;
@property (nonatomic, assign) unsigned short unsignedShortProperty;
@property (nonatomic, assign) unsigned long unsignedLongProperty;
@property (nonatomic, assign) unsigned long long unsignedLongLongProperty;
@property (nonatomic, assign) float floatProperty;
@property (nonatomic, assign) double doubleProperty;
@property (nonatomic, assign) BOOL boolProperty;
@property (nonatomic, assign) char *characterStringProperty;
@property (nonatomic, strong) NSObject *objectProperty;
@property (nonatomic, copy) NSString *stringProperty;
@property (nonatomic, assign) Class classProperty;
@property (nonatomic, assign) SEL selectorProperty;

@property (nonatomic, assign) int assignedProperty;
@property (nonatomic, weak) id weakProperty;
@property (nonatomic, strong) id strongProperty;
@property (nonatomic, copy) id copiedProperty;

@property (nonatomic, assign) int notReadonlyProperty;
@property (nonatomic, readonly) int readonlyProperty;

@property (nonatomic, assign) int nonAtomicProperty;
@property (atomic, assign) int atomicProperty;

@property (nonatomic, assign) int synthesizedProperty;
@property (nonatomic, assign) int dynamicProperty;

@property (nonatomic, assign, getter=myCustomGetter) int customGetterProperty;
@property (nonatomic, assign, setter=myCustomSetter:) int customSetterProperty;

@property (nonatomic, strong) FDDeclaredPropertyTestModel *testModel;


@end