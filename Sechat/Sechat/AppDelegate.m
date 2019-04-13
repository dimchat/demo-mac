//
//  AppDelegate.m
//  Sechat
//
//  Created by Albert Moky on 2019/3/21.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "MKMImmortals.h"

#import "User.h"
#import "Client.h"
#import "Facebook.h"

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    // Override point for customization after application launch.
    
    // GSP station
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gsp" ofType:@"plist"];
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:notification.userInfo];
    if (!mDict) {
        mDict = [[NSMutableDictionary alloc] init];
    }
    [mDict setObject:path forKey:@"ConfigFilePath"];
    
    [[Client sharedInstance] didFinishLaunchingWithOptions:mDict];
    
#if DEBUG && 0
    {
        // moky
        NSString *path = [[NSBundle mainBundle] pathForResource:@"usr-moky" ofType:@"plist"];
        DIMUser *user = [DIMUser userWithConfigFile:path];
        [[Client sharedInstance] addUser:user];
    }
#endif
#if DEBUG && 0
    {
        // selina
        NSString *path = [[NSBundle mainBundle] pathForResource:@"usr-selina" ofType:@"plist"];
        DIMUser *user = [DIMUser userWithConfigFile:path];
        [[Client sharedInstance] addUser:user];
    }
#endif
#if DEBUG && 0
    {
        // monkey king
        DIMID *ID = [DIMID IDWithID:MKM_MONKEY_KING_ID];
        DIMUser *user = DIMUserWithID(ID);
        [[Client sharedInstance] addUser:user];
//        // reset the immortal account's profile
//        MKMImmortals *immortals = [[MKMImmortals alloc] init];
//        DIMProfile * profile = [immortals profileForID:ID];
//        Facebook *facebook = [Facebook sharedInstance];
//        [facebook setProfile:profile forID:ID];
    }
#endif
#if DEBUG && 0
    {
        // hulk
        DIMID *ID = [DIMID IDWithID:MKM_IMMORTAL_HULK_ID];
        DIMUser *user = DIMUserWithID(ID);
        [[Client sharedInstance] addUser:user];
//        // reset the immortal account's profile
//        MKMImmortals *immortals = [[MKMImmortals alloc] init];
//        DIMProfile * profile = [immortals profileForID:ID];
//        Facebook *facebook = [Facebook sharedInstance];
//        [facebook setProfile:profile forID:ID];
    }
#endif
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillBecomeActive:(NSNotification *)notification {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[Client sharedInstance] willTerminate];
}

@end
