//
//  ViewController.h
//  Sechat
//
//  Created by Albert Moky on 2019/3/21.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *usernameTextField;
@property (weak) IBOutlet NSTextField *addressTextField;
@property (weak) IBOutlet NSTextField *numberTextField;

- (IBAction)onGenerateClicked:(NSButton *)sender;
- (IBAction)onRegisterClicked:(NSButton *)sender;

@end

