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

#import "PendoFlutterPlugin.h"

FOUNDATION_EXPORT double pendo_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char pendo_sdkVersionString[];

