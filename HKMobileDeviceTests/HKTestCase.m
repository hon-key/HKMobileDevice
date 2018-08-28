//
//  HKTestCase.m
//  HKMobileDeviceTests
//
//  Created by 工作 on 2018/5/11.
//  Copyright © 2018年 com.CAI. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HKMobileDevice.h"

@interface HKTestCase : XCTestCase

@end

@implementation HKTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    [HKMobileDevice simulatorType:iPhone4];
    
    NSLog(@"%fx%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    BOOL value = hk_screen_320x568;
    XCTAssert(value);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
