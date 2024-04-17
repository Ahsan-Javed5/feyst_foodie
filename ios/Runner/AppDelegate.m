#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
@import GoogleMaps;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyCNH9ADSeYEvEVLHQ_XnYBqVjBvsZ69hxQ"];
    //[GMSPlacesClient provideAPIKey:@"AIzaSyCNH9ADSeYEvEVLHQ_XnYBqVjBvsZ69hxQ"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
