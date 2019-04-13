//
//  ViewController.m
//  Sechat
//
//  Created by Albert Moky on 2019/3/21.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "MKMImmortals.h"

#import "User.h"
#import "Client.h"

#import "ViewController.h"

@interface ViewController () {
    
    DIMPrivateKey *_privateKey;
    const DIMMeta *_meta;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    NSString *path = document_directory();
    path = [path stringByAppendingPathComponent:@".dim"];
    path = [path stringByAppendingPathComponent:@"test-users.plist"];
    NSArray *users = [[NSArray alloc] initWithContentsOfFile:path];
    if (users.count > 0) {
        DIMID *ID = [DIMID IDWithID:users.firstObject];
        _usernameTextField.stringValue = ID.name;
        _addressTextField.stringValue = (NSString *)ID.address;
        _numberTextField.stringValue = search_number(ID.number);
        
        _privateKey = [DIMPrivateKey loadKeyWithIdentifier:ID.address];
        NSLog(@"private key for %@: %@", ID, _privateKey);
        
        if (_privateKey) {
            _meta = [[DIMMeta alloc] initWithVersion:MKMMetaDefaultVersion
                                                seed:ID.name
                                          privateKey:_privateKey
                                           publicKey:nil];
        }
    }
}

- (IBAction)onGenerateClicked:(NSButton *)sender {
    
    NSString *username = _usernameTextField.stringValue;
    NSLog(@"username: %@", username);
    
    if (username.length == 0) {
        NSLog(@"username cannot be empty");
        return ;
    }
    
    // 1. generate private key
    _privateKey = [[DIMPrivateKey alloc] init];
    //    _privateKey = [DIMPrivateKey loadKeyWithIdentifier:[DIMID IDWithID:MKM_IMMORTAL_HULK_ID].address];
    
    // 2. generate meta
    _meta = [[DIMMeta alloc] initWithVersion:MKMMetaDefaultVersion
                                        seed:username
                                  privateKey:_privateKey
                                   publicKey:nil];
    
    // 3. generate ID
    DIMID *ID = [_meta buildIDWithNetworkID:MKMNetwork_Main];
    
    NSLog(@"new ID: %@, private key: %@", ID, _privateKey);
    
    _addressTextField.stringValue = (NSString *)ID.address;
    _numberTextField.stringValue = search_number(ID.number);
}

- (IBAction)onRegisterClicked:(NSButton *)sender {
    
    if (_privateKey == nil || _meta == nil) {
        NSLog(@"generate first");
        return ;
    }
    
    DIMBarrack *barrack = [DIMBarrack sharedInstance];
    
    DIMID *ID = nil;
    DIMPrivateKey *SK = nil;
    
    ID = [DIMID IDWithID:MKM_IMMORTAL_HULK_ID];
    SK = [DIMPrivateKey loadKeyWithIdentifier:ID.address];
    NSLog(@"loaded private key for: %@ -> %@", ID, SK);
    
    // 1. generate ID
    ID = [_meta buildIDWithNetworkID:MKMNetwork_Main];
    
    // 2. save private key to the keychain
    [_privateKey saveKeyWithIdentifier:ID.address];
    NSLog(@"private key saved for ID: %@, %@", ID, _privateKey);
    SK = [DIMPrivateKey loadKeyWithIdentifier:ID.address];
    NSLog(@"private key loaded: %@", SK);
    
    // 3. create user
    DIMUser *user = [[DIMUser alloc] initWithID:ID];
    user.dataSource = barrack;
    NSLog(@"new user: %@", user);
    
    // 4. post meta to the station
    NSString *path = document_directory();
    path = [path stringByAppendingPathComponent:@".dim"];
    path = [path stringByAppendingPathComponent:@"test-users.plist"];
    NSArray *users = [[NSArray alloc] initWithObjects:ID, nil];
    [users writeToFile:path atomically:YES];
    NSLog(@"users %@ wrote into file: %@", users, path);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
