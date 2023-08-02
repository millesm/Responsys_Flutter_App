#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+PIOConvert.h"
#import "NSDictionary+PIOConvert.h"
#import "PushIOManagerFlutterPlugin.h"

FOUNDATION_EXPORT double pushiomanager_flutterVersionNumber;
FOUNDATION_EXPORT const unsigned char pushiomanager_flutterVersionString[];

