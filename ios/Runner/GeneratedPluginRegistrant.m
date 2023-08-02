//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<pendo_sdk/PendoFlutterPlugin.h>)
#import <pendo_sdk/PendoFlutterPlugin.h>
#else
@import pendo_sdk;
#endif

#if __has_include(<pushiomanager_flutter/PushIOManagerFlutterPlugin.h>)
#import <pushiomanager_flutter/PushIOManagerFlutterPlugin.h>
#else
@import pushiomanager_flutter;
#endif

#if __has_include(<webview_flutter_wkwebview/FLTWebViewFlutterPlugin.h>)
#import <webview_flutter_wkwebview/FLTWebViewFlutterPlugin.h>
#else
@import webview_flutter_wkwebview;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [PendoFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"PendoFlutterPlugin"]];
  [PushIOManagerFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"PushIOManagerFlutterPlugin"]];
  [FLTWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTWebViewFlutterPlugin"]];
}

@end
