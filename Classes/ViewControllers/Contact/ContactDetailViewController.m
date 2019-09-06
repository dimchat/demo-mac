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
#import "Client.h"

@interface ContactDetailViewController ()

@property (weak) IBOutlet NSImageView *avatarImageView;
@property (weak) IBOutlet NSTextField *nicknameLabel;
@property (weak) IBOutlet NSTextField *numberLabel;

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self updateUI];
}

-(void)setContact:(DIMUser *)contact{
    
    _contact = contact;
    [self updateUI];
}

-(void)updateUI{
    
    if(_contact == nil){
        return;
    }
    
    DIMProfile *profile = DIMProfileForID(_contact.ID);
    
    // avatar
    CGRect frame = self.avatarImageView.frame;
    NSImage *image = [profile avatarImageWithSize:frame.size];
    if (!image) {
        image = [NSImage imageNamed:@"AppIcon"];
    }
    [self.avatarImageView setImage:image];
    
    // name
    self.nicknameLabel.stringValue = user_title(_contact.ID);
    
    // desc
    self.numberLabel.stringValue = [NSString stringWithFormat:@"%@", _contact.ID];
}

- (IBAction)didPressAddFriendButton:(id)sender {
    
    Client *client = [Client sharedInstance];
    DIMLocalUser *user = client.currentUser;
    
    // send meta & profile first as handshake
    DIMMeta *meta = DIMMetaForID(user.ID);
    DIMProfile *profile = DIMProfileForID(user.ID);
    DIMCommand *cmd;
    if (profile) {
        cmd = [[DIMProfileCommand alloc] initWithID:user.ID
                                               meta:meta
                                            profile:profile];
    } else {
        cmd = [[DIMMetaCommand alloc] initWithID:user.ID
                                            meta:meta];
    }
    [client sendContent:cmd to:_contact.ID];
    
    // add to contacts
    [[DIMFacebook sharedInstance] user:user addContact:_contact.ID];
    NSLog(@"contact %@ added to user %@", _contact, user);
}


@end
