//  HKMobileDevice.m
//  Copyright (c) 2018 HJ-Cai
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  型号列表：https://www.theiphonewiki.com/wiki/Models

#import "HKMobileDevice.h"
#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import "SystemConfiguration/CaptiveNetwork.h"

static NSUInteger HKSimulatorType = simulator;
static NSDictionary *deviceMap;

@implementation HKMobileDevice

+ (NSDictionary *)deviceMap {
    return @{
             // iPhone
             @"iPhone3,1":@(iPhone4),@"iPhone3,2":@(iPhone4),@"iPhone3,3":@(iPhone4),
             @"iPhone4,1":@(iPhone4s),
             @"iPhone5,1":@(iPhone5),@"iPhone5,2":@(iPhone5),
             @"iPhone5,3":@(iPhone5c),@"iPhone5,4":@(iPhone5c),
             @"iPhone6,1":@(iPhone5s),@"iPhone6,2":@(iPhone5s),
             @"iPhone7,1":@(iPhone6p),
             @"iPhone7,2":@(iPhone6),
             @"iPhone8,1":@(iPhone6s),
             @"iPhone8,2":@(iPhone6sp),
             @"iPhone8,4":@(iPhoneSE),
             @"iPhone9,1":@(iPhone7),@"iPhone9,3":@(iPhone7),
             @"iPhone9,2":@(iPhone7p),@"iPhone9,4":@(iPhone7p),
             @"iPhone10,1":@(iPhone8),@"iPhone10,4":@(iPhone8),
             @"iPhone10,2":@(iPhone8p),@"iPhone10,5":@(iPhone8p),
             @"iPhone10,3":@(iPhoneX),@"iPhone10,6":@(iPhoneX),
             @"iPhone11,2":@(iPhoneXS),
             @"iPhone11,4":@(iPhoneXSMax),@"iPhone11,6":@(iPhoneXSMax),
             @"iPhone11,8":@(iPhoneXR),
             @"iPhone12,1":@(iPhone11),@"iPhone12,3":@(iPhone11Pro),@"iPhone12,5":@(iPhone11ProMax),
             // iPod
             @"iPod1,1":@(iPod1G),@"iPod2,1":@(iPod2G),
             @"iPod3,1":@(iPod3G),@"iPod4,1":@(iPod4G),
             @"iPod5,1":@(iPod5Gen),
             @"iPod7,1":@(iPod6Gen),
             // iPad
             @"iPad1,1":@(iPad1),@"iPad1,2":@(iPad1_3G),
             @"iPad2,1":@(iPad2WiFi),@"iPad2,2":@(iPad2),@"iPad2,3":@(iPad2CDMA),@"iPad2,4":@(iPad2),
             @"iPad2,5":@(iPadMiniWiFi),@"iPad2,6":@(iPadMini),@"iPad2,7":@(iPadMiniGSM_CDMA),
             @"iPad3,1":@(ipad3WiFi),@"iPad3,2":@(ipad3GSM_CDMA),@"iPad3,3":@(iPad3),
             @"iPad3,4":@(ipad4WiFi),@"iPad3,5":@(iPad4),@"iPad3,6":@(iPad4GSM_CDMA),
             @"iPad4,1":@(iPadAirWiFi),@"iPad4,2":@(iPadAirCellular),@"iPad4,3":@(iPadAirCellular),
             @"iPad4,4":@(iPadMini2WiFi),@"iPad4,5":@(iPadMini2Cellular),@"iPad4,6":@(iPadMini2),
             @"iPad4,7":@(iPadMini3),@"iPad4,8":@(iPadMini3),@"iPad4,9":@(iPadMini3),
             @"iPad5,1":@(iPadMini4WiFi),@"iPad5,2":@(iPadMini4LTE),
             @"iPad5,3":@(iPadAir2),@"iPad5,4":@(iPadAir2),
             @"iPad6,3":@(iPadPro9_7),@"iPad6,4":@(iPadPro9_7),
             @"iPad6,7":@(iPadPro12_9),@"iPad6,8":@(iPadPro12_9),
             @"iPad6,11":@(iPad5WiFi),@"iPad6,12":@(iPad5Cellular),
             @"iPad7,1":@(iPadPro12_9),@"iPad7,2":@(iPadPro12_9),
             @"iPad7,3":@(iPadPro10_5),@"iPad7,4":@(iPadPro10_5),
             @"iPad7,5":@(iPad6WiFi),@"iPad7,6":@(iPad6Cellular),
             @"iPad8,1":@(iPadPro11),@"iPad8,2":@(iPadPro11),@"iPad8,3":@(iPadPro11),@"iPad8,4":@(iPadPro11),
             @"iPad8,5":@(iPadPro12_9),@"iPad8,6":@(iPadPro12_9),@"iPad8,7":@(iPadPro12_9),@"iPad8,8":@(iPadPro12_9),
             @"iPad11,1":@(iPadMini5),@"iPad11,2":@(iPadMini5),
             @"iPad11,3":@(iPadAir3),@"iPad11,4":@(iPadAir3),
             // simulator
             @"i386":@(simulatori386),@"x86_64":@(simulatorx86_64),
             };
}

+ (void)simulatorType:(HKMobileDeviceType)type {
    HKSimulatorType = type;
}
/*
 *  返回通用类型，可用于模糊查询
 */
+ (NSArray *)commonTypes {
    return @[@(iPhone),@(iPod),@(iPad),@(simulator)];
}

+ (HKMobileDeviceType)deviceType {
    
    NSUInteger type = mobileDeviceUnkown;
    NSString *platform = [self platform];
    NSNumber *numObj = [self deviceMap][platform];
    
    if (numObj)
        type = numObj.integerValue;
        
    return type;
}

+ (BOOL)isOneOfThem:(HKMobileDeviceType)firstType, ... {
    
    HKMobileDeviceType deviceType = [self deviceType];
    
    if ((deviceType == simulatori386 || deviceType == simulatorx86_64)
        && HKSimulatorType != simulator) {
        deviceType = HKSimulatorType;
    }
    
    va_list types;
    __block BOOL isEqual = NO;
    
    va_start(types, firstType);
    [self emurate:firstType list:types
           action:^(HKMobileDeviceType type,BOOL *_break) {
               *_break = isEqual = (deviceType == type);
    }];
    // 找不到相应的移动设备类型，有可能是调用者传入了通用类型（iPhone/iPad之类）
    if (!isEqual) {
        va_start(types, firstType);
        [self emurate:firstType list:types
               action:^(HKMobileDeviceType type, BOOL *_break) {
                   
                   if ([[self commonTypes] containsObject:@(type)] &&
                       [self type:deviceType isKindOfCommonType:type])
                       *_break = isEqual = YES;
                   
               }];
    }
    va_end(types);
    return isEqual;
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}


+ (HKMobileDeviceNetworkType)networkType {
    if (hk_is_iPhoneX_serial) {
        return none;
    }else {
        UIApplication *app = [UIApplication sharedApplication];
        UIView *statusBar = [app valueForKey:@"statusBar"];
        NSArray *subviews = [[statusBar valueForKey:@"foregroundView"] subviews];
        NSNumber *dataNetworkItemView = nil;
        
        for (id subview in subviews) {
            if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                dataNetworkItemView = subview;
                break;
            }
        }
        NSNumber *number = (NSNumber*)[dataNetworkItemView valueForKey:@"dataNetworkType"];
        return [number intValue];
    }
}

+ (BOOL)isUsing:(HKMobileDeviceNetworkType)networkType {
    if ([self networkType] == networkType)
        return YES;
    return NO;
}

+ (BOOL)isJailBroken {
    
    static BOOL __jailbreak;
    if (__jailbreak) return YES;
    
    static const char * __jb_apps[] = {
        "/Application/Cydia.app",
        "/Application/limera1n.app",
        "/Application/greenpois0n.app",
        "/Application/blackra1n.app",
        "/Application/blacksn0w.app",
        "/Application/redsn0w.app",
        NULL
    };
    
    for ( int i = 0; __jb_apps[i]; ++i ) {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] ) {
            __jailbreak = YES;
            return YES;
        }
    }
    if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ) {
        __jailbreak = YES;
        return YES;
    }
    
    return NO;
}

+ (NSString *)WiFiSSID {
    
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    NSString *ssid = [NSString stringWithFormat:@"%@",[info objectForKey:@"SSID"]] ;
    return ssid;
    
}

#pragma mark - helpers

+ (BOOL)type:(HKMobileDeviceType)originType isKindOfCommonType:(HKMobileDeviceType)commonType {
    
    NSArray *commonTypes = [self commonTypes];
    if ([commonTypes containsObject:@(commonType)]) {
        NSUInteger begin = commonType;
        NSUInteger end = mobileDeviceTypeEnd;
        if(![[commonTypes lastObject] isEqual:@(commonType)]) {
            NSInteger nextIndex = [commonTypes indexOfObject:@(commonType)] + 1;
            NSNumber *numObj = [commonTypes objectAtIndex:nextIndex];
            end = numObj.integerValue;
        }
        
        if (originType > begin && originType < end)
            return YES;
    }
    
    return NO;
}

+ (void)emurate:(HKMobileDeviceType)firstType list:(va_list)types action:(void (^)(HKMobileDeviceType,BOOL *_break))action {

    if (!action) return;
    BOOL _break = NO;
    action(firstType,&_break);
    if (_break) return;

    HKMobileDeviceType nextType;
    while ((nextType = va_arg(types, HKMobileDeviceType))) {
        action(nextType,&_break);
        if (_break) return;
    }
}

@end
