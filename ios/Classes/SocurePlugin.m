#import "SocurePlugin.h"
#if __has_include(<socure/socure-Swift.h>)
#import <socure/socure-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "socure-Swift.h"
#endif

@implementation SocurePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSocurePlugin registerWithRegistrar:registrar];
}
@end
