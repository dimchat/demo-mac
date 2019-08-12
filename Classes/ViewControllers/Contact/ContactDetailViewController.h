//
//  ContactDetailViewController.h
//  Sechat
//
//  Created by John Chen on 2019/4/18.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Facebook.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactDetailViewController : NSViewController

@property(nonatomic, strong) DIMUser *contact;

@end

NS_ASSUME_NONNULL_END
