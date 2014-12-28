//
//  CompilerTests.m
//  phoenix
//
//  Created by Krzysztof Kaczor on 12/28/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "Compiler.h"

@interface CompilerTests : XCTestCase

@end

@implementation CompilerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicTranslation {
    NSString* source = @"print(\"test\")";
    Compiler* compiler = [[Compiler alloc] initWithSourceCode:source
                                                        andPrefix:@"ObjC"];
    
    [compiler compile];
    NSString *outputCode = [compiler output];
    NSString *errors = [compiler errors];

    XCTAssert(errors == nil);
    XCTAssertEqualObjects(outputCode, @"print(\"test\");\n");
}

@end
