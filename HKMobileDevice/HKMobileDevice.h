//
//  NV_MobileDevice.h
//  mynetvue
//
//  Created by 工作 on 2017/12/7.
//  Copyright © 2017年 Netviewtech. All rights reserved.
//
/*
 *                  该类提供区分不同设备的接口
 *                  并提供一些特定于设备的职能，如该设备是否越狱，该设备正在使用什么网络类型
 */


#import <Foundation/Foundation.h>

#define mobileDeviceIsOneOfThem(...) [NV_MobileDevice isOneOfThem: __VA_ARGS__, nil]

typedef NS_ENUM(NSUInteger, HKMobileDeviceType) {
    mobileDeviceUnkown = 0,
    
    //==>iPhone
    iPhone,// 1
    iPhone4,iPhone4s,
    iPhone5,iPhone5c,iPhone5s,
    iPhone6,iPhone6s,
    iPhone6p,iPhone6sp,
    iPhoneSE,
    iPhone7,iPhone7p,
    iPhone8,iPhone8p,
    iPhoneX,
    //==>iPod
    iPod,//17
    iPod1G,iPod2G,iPod3G,iPod4G,iPod5Gen,
    //==>ipad
    iPad,//23
    iPad1,iPad1_3G,
    iPad2WiFi,iPad2,iPad2CDMA,
    iPadMiniWiFi,iPadMini,iPadMiniGSM_CDMA,
    iPad3,ipad3WiFi,ipad3GSM_CDMA,
    iPad4,ipad4WiFi,iPad4GSM_CDMA,
    iPadAirWiFi,iPadAirCellular,
    iPadMini2WiFi,iPadMini2Cellular,iPadMini2,
    iPadMini3,
    iPadMini4WiFi,iPadMini4LTE,
    iPadAir2,
    iPadPro9_7,iPadPro12_9,iPadPro10_5,
    iPad5WiFi,iPad5Cellular,
    //==>simulator
    simulator,//52
    simulatori386,simulatorx86_64,
    
    mobileDeviceTypeEnd//哨兵
};

typedef NS_ENUM(NSInteger,NVMobileDeviceNetworkType){
    none,
    _2G,_3G,_4G,
    LTE,WiFi
};

@interface HKMobileDevice : NSObject
/*
 *  获取和判断移动设备的型号
 */
+ (HKMobileDeviceType)deviceType;
+ (BOOL)isOneOfThem:(HKMobileDeviceType)firstType,...NS_REQUIRES_NIL_TERMINATION;
+ (NSString *)platform;// 获取当前移动设备型号的字符串
/*
 * 获取和判断当前移动设备的网络类型
 */
+ (BOOL)isUsing:(NVMobileDeviceNetworkType)networkType;
+ (NVMobileDeviceNetworkType)networkType;


+ (BOOL)isJailBroken;// 判断设备是否越狱
+ (NSString *)WiFiSSID;//获取当前使用的 WIFI 的名称

@end
