//
//  LoginWindowController.m
//  Sechat
//
//  Created by John Chen on 2019/3/26.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "LoginWindowController.h"
#import "dimMacros.h"
#import "Client.h"

@interface LoginWindowController ()

@property (weak) IBOutlet NSTextField *nicknameLabel;
@property (weak) IBOutlet NSTextField *usernameLabel;

@end

@implementation LoginWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)didPressOKButton:(id)sender {
    
    NSString *nickname = self.nicknameLabel.stringValue;
    NSString *username = self.usernameLabel.stringValue;
    
    NSDictionary *params = @{
                             @"nickname" : nickname,
                             @"username" : username,
                             };
    [self generateWithParameters:params];
}

- (void)generateWithParameters:(NSDictionary *)parameters {
    
    NSString *nickname = [parameters objectForKey:@"nickname"];
    NSString *username = [parameters objectForKey:@"username"];
    
    DIMPrivateKey *SK;
    const DIMMeta *meta;
    const DIMID *ID;
    
    // 1. generate private key
    SK = [[DIMPrivateKey alloc] init];
    // 2. generate meta
    meta = [[DIMMeta alloc] initWithVersion:MKMMetaDefaultVersion
                                       seed:username
                                 privateKey:SK
                                  publicKey:nil];
    // 3. generate ID
    ID = [meta buildIDWithNetworkID:MKMNetwork_Main];
    
    Client *client = [Client sharedInstance];
    if (![client saveUser:ID meta:meta privateKey:SK name:nickname]) {
        [self showWarningMessage:@"Can not register user" completeHandler:nil];
    }
    
    // post notice
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName_UsersUpdated object:self];
    [[NSApplication sharedApplication] endSheet:self.window returnCode:-1];
}

@end
