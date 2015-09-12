@import XCTest;

#import "FDKeypath.h"


@interface FDKeypathTests : XCTestCase

@end

@implementation FDKeypathTests

- (void)testKeypathForObject
{
	NSLock *lock = [NSLock new];
	
	XCTAssertNotNil(lock);
	XCTAssertEqualObjects(@"name", @keypathForObject(lock.name));
	XCTAssertEqualObjects(@"name.uppercaseString", @keypathForObject(lock.name.uppercaseString));
}

- (void)testKeypathForClass
{
	XCTAssertEqualObjects(@"name", @keypathForClass(NSLock, name));
	XCTAssertEqualObjects(@"name.uppercaseString", @keypathForClass(NSLock, name.uppercaseString));
}

- (void)testKeypathAlias
{
	NSLock *lock = [NSLock new];
	
	XCTAssertEqualObjects(@keypathForObject(lock.name), @keypath(lock.name));
	XCTAssertEqualObjects(@keypathForObject(lock.name.uppercaseString), @keypath(lock.name.uppercaseString));
	XCTAssertEqualObjects(@keypathForClass(NSLock, name), @keypath(NSLock, name));
	XCTAssertEqualObjects(@keypathForClass(NSLock, name.uppercaseString), @keypath(NSLock, name.uppercaseString));
}

@end