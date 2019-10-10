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
    [HKMobileDevice simulatorType:iPhone8];
    NSLog(@"%fx%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
}

- (void)tearDown {
    [super tearDown];
}

- (void)testScreen {
    [HKMobileDevice networkType];
//    BOOL value = hk_screen_375x812;
//    XCTAssert(value);
}

- (void)testIn {
    BOOL value = hk_is_iPhoneWithHair_serial;
    XCTAssert(value);
}

@end
