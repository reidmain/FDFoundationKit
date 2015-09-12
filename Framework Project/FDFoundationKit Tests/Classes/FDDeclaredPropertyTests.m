@import XCTest;

#import "FDDeclaredPropertyTestModel.h"
#import "FDDeclaredPropertyTestModelSubclass.h"
#import "FDKeypath.h"
#import "NSObject+DeclaredProperty.h"


@interface FDDeclaredPropertyTests : XCTestCase

@end

@implementation FDDeclaredPropertyTests

- (void)testName
{
	XCTAssertEqualObjects(@keypath(FDDeclaredPropertyTestModel, charProperty), [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, charProperty)].name);
	XCTAssertEqualObjects(@keypath(FDDeclaredPropertyTestModel, intProperty), [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, intProperty)].name);
	XCTAssertEqualObjects(@keypath(FDDeclaredPropertyTestModel, shortProperty), [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, shortProperty)].name);
}

- (void)testObjectClass
{
	XCTAssertEqualObjects(nil, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, charProperty)].objectClass);
	XCTAssertEqualObjects([NSObject class], [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, objectProperty)].objectClass);
	XCTAssertEqualObjects([NSString class], [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, stringProperty)].objectClass);
	XCTAssertEqualObjects(nil, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, weakProperty)].objectClass);
	XCTAssertEqualObjects(nil, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, classProperty)].objectClass);
}

- (void)testTypeEncodings
{
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingChar, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, charProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingInt, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, intProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingShort, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, shortProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingLongLong, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, longProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingLongLong, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, longLongProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingUnsignedChar, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, unsignedCharProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingUnsignedInt, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, unsignedIntProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingUnsignedShort, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, unsignedShortProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingUnsignedLongLong, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, unsignedLongProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingUnsignedLongLong, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, unsignedLongProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingFloat, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, floatProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingDouble, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, doubleProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingBool, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, boolProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingCharacterString, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, characterStringProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingObject, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, objectProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingObject, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, copiedProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingObject, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, weakProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingClass, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, classProperty)].typeEncoding);
	XCTAssertEqual(FDDeclaredPropertyTypeEncodingSelector, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, selectorProperty)].typeEncoding);
}

- (void)testMemoryManagementPolicy
{
	XCTAssertEqual(FDDeclaredPropertyMemoryManagementPolicyAssign, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, charProperty)].memoryManagementPolicy);
	XCTAssertEqual(FDDeclaredPropertyMemoryManagementPolicyRetain, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, strongProperty)].memoryManagementPolicy);
	XCTAssertEqual(FDDeclaredPropertyMemoryManagementPolicyAssign, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, weakProperty)].memoryManagementPolicy);
	XCTAssertEqual(FDDeclaredPropertyMemoryManagementPolicyCopy, [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, copiedProperty)].memoryManagementPolicy);
}

- (void)testWeakReference
{
	XCTAssertFalse([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, strongProperty)].isWeakReference);
	XCTAssertTrue([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, weakProperty)].isWeakReference);
}

- (void)testReadonly
{
	XCTAssertFalse([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, notReadonlyProperty)].isReadOnly);
	XCTAssertTrue([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, readonlyProperty)].isReadOnly);
}

- (void)testNonAtomic
{
	XCTAssertFalse([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, atomicProperty)].isNonAtomic);
	XCTAssertTrue([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, nonAtomicProperty)].isNonAtomic);
}

- (void)testDynamic
{
	XCTAssertFalse([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, synthesizedProperty)].isDynamic);
	XCTAssertTrue([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, dynamicProperty)].isDynamic);
}

- (void)testBackingInstanceVariable
{
	XCTAssertEqualObjects(@"_synthesizedProperty", [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, synthesizedProperty)].backingInstanceVariableName);
	XCTAssertNil([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, dynamicProperty)].backingInstanceVariableName);
}

- (void)testCustomGetter
{
	XCTAssertEqualObjects(@"myCustomGetter", [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, customGetterProperty)].customGetterSelectorName);
	XCTAssertNil([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, synthesizedProperty)].customGetterSelectorName);
}

- (void)testCustomSetter
{
	XCTAssertEqualObjects(@"myCustomSetter:", [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, customSetterProperty)].customSetterSelectorName);
	XCTAssertNil([FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, synthesizedProperty)].customSetterSelectorName);
}

- (void)testEquality
{
	FDDeclaredProperty *declaredPropertyFromKey = [FDDeclaredPropertyTestModel fd_declaredPropertyForName: @keypath(FDDeclaredPropertyTestModel, testModel)];
	FDDeclaredProperty *declaredPropertyFromKeyPath = [FDDeclaredPropertyTestModel fd_declaredPropertyForKeyPath: @keypath(FDDeclaredPropertyTestModel, testModel.testModel.testModel)];
	XCTAssertEqualObjects(declaredPropertyFromKey, declaredPropertyFromKeyPath);
}

- (void)testPropertyCount
{
	NSArray *allDeclaredPropertiesOnTestModel = [FDDeclaredPropertyTestModel fd_declaredPropertiesUntilSuperclass: nil];
	NSArray *allDeclaredPropertiesOnTestModelAltMethod = [FDDeclaredPropertyTestModel fd_declaredPropertiesUntilSuperclass: [NSObject class]];
	XCTAssertEqual(31, [allDeclaredPropertiesOnTestModel count]);
	XCTAssertEqual([allDeclaredPropertiesOnTestModel count], [allDeclaredPropertiesOnTestModelAltMethod count]);
	
	NSArray *allDeclaredPropertiesOnTestModelSubclass = [FDDeclaredPropertyTestModelSubclass fd_declaredPropertiesUntilSuperclass: nil];
	XCTAssertEqual(34, [allDeclaredPropertiesOnTestModelSubclass count]);
	
	NSArray *declaredPropertiesOnTestModelSubclass = [FDDeclaredPropertyTestModelSubclass fd_declaredPropertiesUntilSuperclass: [FDDeclaredPropertyTestModel class]];
	XCTAssertEqual([allDeclaredPropertiesOnTestModelSubclass count] - [allDeclaredPropertiesOnTestModel count], [declaredPropertiesOnTestModelSubclass count]);
	
	// TODO: Need to add a test using a object that adheres to a protocol that adheres to NSObject so the scenario where properties on the NSObject protocol will appear.
}

- (void)testPerformance
{
    [self measureBlock: ^
		{
			for (NSUInteger i=0; i < 50000; i++)
			{
				[FDDeclaredPropertyTestModel fd_declaredPropertiesUntilSuperclass: nil];
			}
		}];
}


@end