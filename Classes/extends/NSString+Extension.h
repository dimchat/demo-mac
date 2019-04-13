//
//  NSString+Extension.h
//  DIMClient
//
//  Created by Albert Moky on 2019/2/1.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

- (CGSize)sizeWithFont:(NSFont *)font maxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
