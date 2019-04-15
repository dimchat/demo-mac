//
//  AppDelegate.m
//  Sechat
//
//  Created by Albert Moky on 2019/3/21.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "User.h"
#import "Client.h"
#import "MainWindowController.h"
#import "AppDelegate.h"
#import "Log.h"

@interface AppDelegate ()

@property (nonatomic, strong) MainWindowController *mainController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    
    // GSP station
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gsp" ofType:@"plist"];
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithDictionary:notification.userInfo];
    if (!mDict) {
        mDict = [[NSMutableDictionary alloc] init];
    }
    [mDict setObject:path forKey:@"ConfigFilePath"];
    
    [[Client sharedInstance] didFinishLaunchingWithOptions:mDict];
    
    // Insert code here to initialize your application
    if(self.mainController == nil){
        self.mainController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
    }
    
    DBG(@"Did finish launching");
    [self.mainController.window makeKeyAndOrderFront:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    [[Client sharedInstance] willTerminate];
}


@end
