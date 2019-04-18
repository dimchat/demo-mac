//
//  ContactDetailViewController.m
//  Sechat
//
//  Created by John Chen on 2019/4/18.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "DimProfile+Extension.h"
#import "User.h"

@interface ContactDetailViewController ()

@property (weak) IBOutlet NSImageView *avatarImageView;
@property (weak) IBOutlet NSTextField *nicknameLabel;
@property (weak) IBOutlet NSTextField *numberLabel;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)setAccount:(DIMAccount *)account{
    
    _account = account;
    
    DIMProfile *profile = DIMProfileForID(account.ID);
    
    // avatar
    CGRect frame = self.avatarImageView.frame;
    NSImage *image = [profile avatarImageWithSize:frame.size];
    if (!image) {
        image = [NSImage imageNamed:@"AppIcon"];
    }
    [self.avatarImageView setImage:image];
    
    // name
    self.nicknameLabel.stringValue = account_title(account);
    
    // desc
    self.numberLabel.stringValue = (NSString *)account.ID;
}

@end
