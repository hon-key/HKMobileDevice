# Intro
HKMobileDevice 是一个屏幕设备适配库， 它能够以非常灵活的方式适配任何ios设备，包括iphone、ipad、ipod touch 等等
使用方式非常简单，

# Usage
```objc
// device type
#define hk_is_iPhone hk_device_is(iPhone)
#define hk_is_iPad hk_device_is(iPad)
#define hk_is_iPod hk_device_is(iPod)
// serial
#define hk_is_iPhone5_serial hk_device_in(iPhone5,iPhone5c,iPhone5s)
#define hk_is_iPhone6_serial hk_device_in(iPhone6,iPhone6s,iPhone6p,iPhone6sp)
#define hk_is_iPhone7_serial hk_device_in(iPhone7,iPhone7p)
#define hk_is_iPhone8_serial hk_device_in(iPhone8,iPhone8p)
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
#define hk_is_iPadPro_serial hk_device_in(iPadPro9_7,iPadPro12_9,iPadPro10_5)
// size
#define hk_screen_320x568 hk_device_in(iPhone5,iPhone5c,iPhone5s,iPhoneSE)
#define hk_screen_375x667 hk_device_in(iPhone6,iPhone6s,iPhone7,iPhone8)
#define hk_screen_414x736 hk_device_in(iPhone6p,iPhone6sp,iPhone7p,iPhone8p)
#define hk_screen_375x812 hk_device_in(iPhoneX,iPhoneXS)
#define hk_screen_414x896 hk_device_in(iPhoneXSMax,iPhoneXR)

if (hk_screen_320x568) {
        ····
}

```
使用以上宏定义可以判断系列型号类型的设备、屏幕系列的设备，也可以通过以下方式判断任何设备
```objc
#define hk_device_in(...) [HKMobileDevice isOneOfThem: __VA_ARGS__, nil]
#define hk_device_is(is) [HKMobileDevice isOneOfThem:is,nil]

hk_device_in(iPhone4,iPhone7);

```
如果你不想使用宏定义，可以通过
```objc
+ (BOOL)isOneOfThem:(HKMobileDeviceType)firstType,...NS_REQUIRES_NIL_TERMINATION;

[HKMobileDevice isOneOfThem:iphone4,iPhone7, nil];
```
HKMobileDevice 提供通用匹配功能，如果你在对iphone和ipad进行同时同时开发，你可以对通用设备进行匹配
```objc
hk_device_in(iPhone)/hk_device_is(iPhone) // 判断是否是iPhone
hk_device_in(iPad)/hk_device_is(iPad) // 判断是否是iPad
hk_device_in(iPod)/hk_device_is(iPod) // 判断是否是iPod touch
```

对于模拟器调试，由于模拟器架构为 x86_64或者i385，调试目标设备时，需要将模拟器设为目标设备，例如在启动模拟器iphone8p之前，你需要在app启动时调用以下代码：
```objc
[HKMobileDevice simulatorType:iPhone8p];
```

# Installation
推荐使用 CocoaPods
```
pod 'HKMobileDevice'
```
也可以拷贝以下文件至工程：
```
HKMobileDevice.h
HKMobileDevice.m
```

# Version
1.1.1

ios 8.0

已添加全面屏 iPad Pro

## License

HKMobileDevice is released under the MIT license. See [LICENSE](https://github.com/hon-key/HKMobileDevice/raw/master/LICENSE) for details.
