//
//  AppDelegate.m
//  Sechat
//
//  Created by Albert Moky on 2019/3/21.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "User.h"
#import "Client.h"

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // GSP station
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gsp" ofType:@"plist"];
    [[Client sharedInstance] startWithConfigFile:path];
    
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
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    [[Client sharedInstance] willTerminate];
}


@end
