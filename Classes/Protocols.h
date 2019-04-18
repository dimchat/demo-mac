//
//  Protocols.h
//  Sechat
//
//  Created by John Chen on 2019/4/18.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <AppKit/AppKit.h>

#ifndef Protocols_h
#define Protocols_h

@protocol ListViewControllerDelegate <NSObject>

-(void)listViewController:(NSViewController *)controller didSelectCell:(NSView *)cell;

@end

#endif /* Protocols_h */
