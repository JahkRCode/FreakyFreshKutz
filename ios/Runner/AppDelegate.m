#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import GoogleMobileAds;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
