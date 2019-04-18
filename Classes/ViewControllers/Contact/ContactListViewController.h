//
//  ContactListViewController.h
//  Sechat
//
//  Created by John Chen on 2019/4/15.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Protocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactListViewController : NSViewController

@property(nonatomic, assign) id<NSObject, ListViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
