//
//  Client.h
//  DIMClient
//
//  Created by Albert Moky on 2019/1/28.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>

#import <DIMClient/DIMClient.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kNotificationName_MessageUpdated;
extern NSString * const kNotificationName_MessageCleaned;
extern NSString * const kNotificationName_UsersUpdated;

@interface Client : DIMTerminal<UNUserNotificationCenterDelegate>

@property (strong, nonatomic) NSData *deviceToken;

@property (readonly, nonatomic) NSString *displayName;

+ (instancetype)sharedInstance;

@end

@interface Client (AppDelegate)

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)didEnterBackground;
- (void)willEnterForeground;
- (void)willTerminate;

@end

@interface Client (API)

// @"https://sechat.dim.chat/{ID}}/upload"
@property (readonly, copy, nonatomic) NSString *uploadAPI;

// @"https://sechat.dim.chat/download/{ID}/{filename}"
@property (readonly, copy, nonatomic) NSString *downloadAPI;

// @"https://sechat.dim.chat/avatar/{ID}/{filename}"
@property (readonly, copy, nonatomic) NSString *avatarAPI;

// @"https://sechat.dim.chat/report?type={type}&identifier={ID}&sender={sender}"
@property (readonly, copy, nonatomic) NSString *reportAPI;

@property (readonly, copy, nonatomic) NSString *termsAPI;
@property (readonly, copy, nonatomic) NSString *aboutAPI;

@end

@interface Client (Register)

- (BOOL)saveUser:(DIMID *)ID meta:(DIMMeta *)meta privateKey:(DIMPrivateKey *)SK name:(nullable NSString *)nickname;
- (BOOL)importUser:(DIMID *)ID meta:(DIMMeta *)meta privateKey:(DIMPrivateKey *)SK name:(nullable NSString *)nickname;

@end

#pragma mark - DOS

NSString *document_directory(void);
NSString *caches_directory(void);

void make_dirs(NSString *dir);

BOOL file_exists(NSString *path);
BOOL remove_file(NSString *path);

NS_ASSUME_NONNULL_END
