#import "FlutterDevicePlugin.h"

#if __has_include(<flutter_device/flutter_device-Swift.h>)
#import <flutter_device/flutter_device-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_device-Swift.h"

#endif

@implementation FlutterDevicePlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [SwiftFlutterDevicePlugin registerWithRegistrar:registrar];
}
@end
