//
//  UIColor+Extension.h
//  Sechat
//
//  Created by Albert Moky on 2019/3/26.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (Hex)

+ (NSColor *)colorWithHexString:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
