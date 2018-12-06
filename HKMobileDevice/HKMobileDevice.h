//  HKMobileDevice.h
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


#import <Foundation/Foundation.h>

#define hk_device_in(...) [HKMobileDevice isOneOfThem: __VA_ARGS__, nil]
#define hk_device_is(is) [HKMobileDevice isOneOfThem:is,nil]
// device type
#define hk_is_iPhone hk_device_is(iPhone)
#define hk_is_iPad hk_device_is(iPad)
#define hk_is_iPod hk_device_is(iPod)
// serial
#define hk_is_iPhone5_serial hk_device_in(iPhone5,iPhone5c,iPhone5s)
#define hk_is_iPhone6_serial hk_device_in(iPhone6,iPhone6s,iPhone6p,iPhone6sp)
#define hk_is_iPhone7_serial hk_device_in(iPhone7,iPhone7p)
#define hk_is_iPhone8_serial hk_device_in(iPhone8,iPhone8p)
#define hk_is_iPhoneX_serial hk_device_in(iPhoneX,iPhoneXR,iPhoneXS,iPhoneXSMax)
#define hk_is_iPad1_serial hk_device_in(iPad1,iPad1_3G)
#define hk_is_iPad2_serial hk_device_in(iPad2WiFi,iPad2,iPad2CDMA)
#define hk_is_iPad3_serial hk_device_in(iPad3,ipad3WiFi,ipad3GSM_CDMA)
#define hk_is_iPad4_serial hk_device_in(iPad4,ipad4WiFi,iPad4GSM_CDMA)
#define hk_is_iPad5_serial hk_device_in(iPad5WiFi,iPad5Cellular)
#define hk_is_iPad6_serial hk_device_in(iPad6WiFi,iPad6Cellular)
#define hk_is_iPadMini_serial hk_device_in(iPadMiniWiFi,iPadMini,iPadMiniGSM_CDMA)
#define hk_is_iPadMini2_serial hk_device_in(iPadMini2WiFi,iPadMini2Cellular,iPadMini2)
#define hk_is_iPadMini4_serial hk_device_in(iPadMini4WiFi,iPadMini4LTE)
#define hk_is_iPadAir_serial hk_device_in(iPadAirWiFi,iPadAirCellular)
#define hk_is_iPadPro_serial hk_device_in(iPadPro9_7,iPadPro12_9,iPadPro10_5,iPadPro11)
// size
#define hk_screen_320x568 hk_device_in(iPhone5,iPhone5c,iPhone5s,iPhoneSE)
#define hk_screen_375x667 hk_device_in(iPhone6,iPhone6s,iPhone7,iPhone8)
#define hk_screen_414x736 hk_device_in(iPhone6p,iPhone6sp,iPhone7p,iPhone8p)
#define hk_screen_375x812 hk_device_in(iPhoneX,iPhoneXS)
#define hk_screen_414x896 hk_device_in(iPhoneXSMax,iPhoneXR)


// 为了方便使用，将不为枚举添加前缀，请使用前注意没有冲突问题
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
    iPhoneXR,iPhoneXS,iPhoneXSMax,
    //==>iPod
    iPod,//20
    iPod1G,iPod2G,iPod3G,iPod4G,iPod5Gen,iPod6Gen,
    //==>ipad
    iPad,//27
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
    iPad6WiFi,iPad6Cellular,
    iPadPro11,
    //==>simulator
    simulator,//59
    simulatori386,simulatorx86_64,
    
    mobileDeviceTypeEnd//哨兵
};

typedef NS_ENUM(NSInteger,HKMobileDeviceNetworkType){
    none,
    _2G,_3G,_4G,
    LTE,WiFi
};

@interface HKMobileDevice : NSObject

/*
 *  因为模拟器运行所识别的型号为模拟器，可设置模拟器代替型号，以方便模拟器调试。
 *  设置为 simulator 则不做任何代替
 *  不要赋值为 iPhone等通用类型、mobileDeviceUnkown、mobileDeviceTypeEnd
 */
+ (void)simulatorType:(HKMobileDeviceType)type;
/*
 *  获取和判断移动设备的型号
 */
+ (HKMobileDeviceType)deviceType;
+ (BOOL)isOneOfThem:(HKMobileDeviceType)firstType,...NS_REQUIRES_NIL_TERMINATION;
+ (NSString *)platform;// 获取当前移动设备型号的字符串
/*
 * 获取和判断当前移动设备的网络类型
 */
+ (BOOL)isUsing:(HKMobileDeviceNetworkType)networkType;
+ (HKMobileDeviceNetworkType)networkType;


+ (BOOL)isJailBroken;// 判断设备是否越狱
+ (NSString *)WiFiSSID;//获取当前使用的 WIFI 的名称

@end
