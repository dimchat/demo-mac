//
//  Client.m
//  DIMClient
//
//  Created by Albert Moky on 2019/1/28.
//  Copyright © 2019 DIM Group. All rights reserved.
//

#import "NSObject+Singleton.h"
#import "NSObject+JsON.h"
#import "NSData+Extension.h"
#import "NSNotificationCenter+Extension.h"

#import "Facebook+Profile.h"
#import "Facebook+Register.h"
#import "MessageProcessor.h"

#import "Client.h"

NSString * const kNotificationName_MessageUpdated = @"MessageUpdated";
NSString * const kNotificationName_MessageCleaned = @"MessageCleaned";
NSString * const kNotificationName_UsersUpdated = @"UsersUpdated";

@interface Client () {
    
    NSString *_userAgent;
}

@end

@implementation Client

SingletonImplementations(Client, sharedInstance)

- (NSString *)displayName {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info valueForKey:@"CFBundleDisplayName"];
    if (name) {
        return name;
    }
    return @"DIM!";
}

- (NSString *)userAgent {
    if (!_userAgent) {
        // device model & system
//        UIDevice *device = [UIDevice currentDevice];
//        NSString *model = device.model;          // e.g. @"iPhone", @"iPod touch"
//        NSString *sysName = device.systemName;   // e.g. @"iOS"
//        NSString *sysVer = device.systemVersion; // e.g. @"4.0"
//
//        // current language
//        NSString *lang = self.language;
//
//        NSString *format = @"DIMP/1.0 (%@; U; %@ %@; %@) DIMCoreKit/1.0 (Terminal, like WeChat) DIM-by-GSP/1.0.1";
//        _userAgent = [[NSString alloc] initWithFormat:format, model, sysName, sysVer, lang];
//        NSLog(@"User-Agent: %@", _userAgent);
    }
    return _userAgent;
}

- (void)onHandshakeAccepted:(NSString *)session {
    [super onHandshakeAccepted:session];
    
    // post device token
    NSString *token = [self.deviceToken hexEncode];
    if (token) {
        DIMCommand *cmd = [[DIMCommand alloc] initWithCommand:@"broadcast"];
        [cmd setObject:@"apns" forKey:@"title"];
        [cmd setObject:token forKey:@"device_token"];
        [self sendCommand:cmd];
    }
}

@end

@implementation Client (AppDelegate)

- (void)_startServer:(NSDictionary *)station withProvider:(DIMServiceProvider *)sp {
    // save meta for server ID
    DIMID *ID = DIMIDWithString([station objectForKey:@"ID"]);
    DIMMeta *meta = MKMMetaFromDictionary([station objectForKey:@"meta"]);
    
    Facebook *facebook = [Facebook sharedInstance];
    [[DIMFacebook sharedInstance] saveMeta:meta forID:ID];
    
    // prepare for launch star
    NSMutableDictionary *serverOptions = [[NSMutableDictionary alloc] init];
    NSString *IP = [station objectForKey:@"host"];
    if (IP) {
        //[launchOptions setObject:IP forKey:@"LongLinkAddress"];
        [serverOptions setObject:@"dim.chat" forKey:@"LongLinkAddress"];
        NSDictionary *ipTable = @{
                                  @"dim.chat": @[IP],
                                  };
        [serverOptions setObject:ipTable forKey:@"NewDNS"];
    }
    NSNumber *port = [station objectForKey:@"port"];
    if (port != nil) {
        [serverOptions setObject:port forKey:@"LongLinkPort"];
    }
    
    // configure FTP server
    DIMFileServer *ftp = [DIMFileServer sharedInstance];
    ftp.userAgent = self.userAgent;
    ftp.uploadAPI = self.uploadAPI;
    ftp.downloadAPI = self.downloadAPI;
    ftp.avatarAPI = self.avatarAPI;
    
    // connect server
    DIMServer *server = [[DIMServer alloc] initWithDictionary:station];
    server.delegate = self;
    [server startWithOptions:serverOptions];
    _currentStation = server;
    
    [MessageProcessor sharedInstance];
    
    [facebook addStation:ID provider:sp];
    
    // scan users
    NSArray *users = [facebook scanUserIDList];
#if DEBUG && 0
    NSMutableArray *mArray;
    if (users.count > 0) {
        mArray = [users mutableCopy];
    } else {
        mArray = [[NSMutableArray alloc] initWithCapacity:2];
    }
    [mArray addObject:[DIMID IDWithID:MKM_IMMORTAL_HULK_ID]];
    [mArray addObject:[DIMID IDWithID:MKM_MONKEY_KING_ID]];
    users = mArray;
#endif
    // add users
    DIMLocalUser *user;
    for (DIMID *ID in users) {
        NSLog(@"[client] add user: %@", ID);
        user = DIMUserWithID(ID);
        [self addUser:user];
    }
    
    [NSNotificationCenter addObserver:self
                             selector:@selector(onProfileUpdated:)
                                 name:kNotificationName_ProfileUpdated
                               object:self];
    
}

- (void)onProfileUpdated:(NSNotification *)notification {
    if (![notification.name isEqual:kNotificationName_ProfileUpdated]) {
        return ;
    }
    DIMProfileCommand *cmd = (DIMProfileCommand *)notification.userInfo;
    DIMProfile *profile = cmd.profile;
    NSAssert([profile.ID isEqual:cmd.ID], @"profile command error: %@", cmd);
    [profile removeObjectForKey:@"lastTime"];
    
    // check avatar
    NSString *avatar = profile.avatar;
    if (avatar) {
        //        // if old avatar exists, remove it
        //        DIMID *ID = profile.ID;
        //        DIMProfile *old = [self profileForID:ID];
        //        NSString *ext = [old.avatar pathExtension];
        //        if (ext/* && ![avatar isEqualToString:old.avatar]*/) {
        //            // Cache directory: "Documents/.mkm/{address}/avatar.png"
        //            NSString *path = [NSString stringWithFormat:@"%@/.mkm/%@/avatar.%@", document_directory(), ID.address, ext];
        //            NSFileManager *fm = [NSFileManager defaultManager];
        //            if ([fm fileExistsAtPath:path]) {
        //                NSError *error = nil;
        //                if (![fm removeItemAtPath:path error:&error]) {
        //                    NSLog(@"failed to remove old avatar: %@", error);
        //                } else {
        //                    NSLog(@"old avatar removed: %@", path);
        //                }
        //            }
        //        }
    }
    
    // update profile
    DIMFacebook *facebook = [DIMFacebook sharedInstance];
    [facebook saveProfile:profile];
}

- (void)_launchServiceProviderConfig:(NSDictionary *)config {
    DIMServiceProvider *sp = nil;
    {
        DIMID *ID = DIMIDWithString([config objectForKey:@"ID"]);
        //        DIMID *founder = [config objectForKey:@"founder"];
        //        founder = DIMIDWithString(founder);
        
        sp = [[DIMServiceProvider alloc] initWithID:ID];
    }
    
    // choose the fast station
    NSArray *stations = [config objectForKey:@"stations"];
    NSDictionary *station = stations.firstObject;
    NSLog(@"got station: %@", station);
    
    [self _startServer:station withProvider:sp];
}

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // launch server
    NSString *spConfig = [launchOptions objectForKey:@"ConfigFilePath"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:spConfig];
    [self _launchServiceProviderConfig:config];
}

- (void)didEnterBackground {
    // report client state
    DIMCommand *cmd = [[DIMCommand alloc] initWithCommand:@"broadcast"];
    [cmd setObject:@"report" forKey:@"title"];
    [cmd setObject:@"background" forKey:@"state"];
    [self sendCommand:cmd];
    
    [_currentStation pause];
}

- (void)willEnterForeground {
    [_currentStation resume];
    
    // report client state
    DIMCommand *cmd = [[DIMCommand alloc] initWithCommand:@"broadcast"];
    [cmd setObject:@"report" forKey:@"title"];
    [cmd setObject:@"foreground" forKey:@"state"];
    [self sendCommand:cmd];
}

- (void)willTerminate {
    [_currentStation end];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"willPresentNotification: %@", notification);
    // show alert even in foreground
    completionHandler(UNNotificationPresentationOptionAlert);
}

@end

@implementation Client (APNs)

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [deviceToken hexEncode];
    NSLog(@"APNs token: %@", deviceToken);
    NSLog(@"APNs token(hex): %@", token);
    // TODO: send this device token to server
    if (deviceToken.length > 0) {
        self.deviceToken = deviceToken;
    }
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"APNs failed to get token: %@", error);
}

@end

@implementation Client (API)

- (NSString *)uploadAPI {
    return @"https://sechat.dim.chat/{ID}/upload";
}

- (NSString *)downloadAPI {
    return @"https://sechat.dim.chat/download/{ID}/{filename}";
}

- (NSString *)avatarAPI {
    return @"https://sechat.dim.chat/avatar/{ID}/{filename}";
}

- (NSString *)reportAPI {
    return @"https://sechat.dim.chat/report?type={type}&identifier={ID}&sender={sender}";
}

- (NSString *)termsAPI {
    return @"https://wallet.dim.chat/dimchat/sechat/privacy.html";
}

- (NSString *)aboutAPI {
    //return @"https://dim.chat/sechat";
    return @"https://sechat.dim.chat/support";
}

@end

@implementation Client (Register)

- (BOOL)saveUser:(DIMID *)ID meta:(DIMMeta *)meta privateKey:(DIMPrivateKey *)SK name:(nullable NSString *)nickname {
    
    DIMFacebook *facebook = [DIMFacebook sharedInstance];
    
    // 1. save meta & private key
    if (![facebook savePrivateKey:SK forID:ID]) {
        NSAssert(false, @"failed to save private key for new user: %@", ID);
        return NO;
    }
    if (![facebook saveMeta:meta forID:ID]) {
        NSAssert(false, @"failed to save meta for new user: %@", ID);
        return NO;
    }
    
    // 2. save nickname in profile
    if (nickname.length > 0) {
        
        DIMProfile *profile = [[DIMProfile alloc] initWithID:ID];
        
        [profile setName:nickname];
        [profile sign:SK];
        if (![facebook saveProfile:profile]) {
            NSAssert(false, @"failedo to save profile for new user: %@", ID);
            return NO;
        }
    }
    
    // 3. create user for client
    DIMLocalUser *user = [[DIMLocalUser alloc] initWithID:ID];
    user.dataSource = facebook;
    self.currentUser = user;
    
    Facebook *book = [Facebook sharedInstance];
    BOOL saved = [book saveUserList:self.users withCurrentUser:user];
    NSAssert(saved, @"failed to save users: %@, current user: %@", self.users, user);
    return saved;
}

- (BOOL)importUser:(DIMID *)ID meta:(DIMMeta *)meta privateKey:(DIMPrivateKey *)SK name:(nullable NSString *)nickname {
    
    DIMFacebook *facebook = [DIMFacebook sharedInstance];
    
    // 1. save meta & private key
    if (![facebook savePrivateKey:SK forID:ID]) {
        NSAssert(false, @"failed to save private key for new user: %@", ID);
        return NO;
    }
    if (![facebook saveMeta:meta forID:ID]) {
        NSAssert(false, @"failed to save meta for new user: %@", ID);
        return NO;
    }
    
    MKMLocalUser *user = DIMUserWithID(ID);
    [self login:user];
    
    //    DIMProfile *profile = [facebook profileForID:ID];
    
    Facebook *book = [Facebook sharedInstance];
    BOOL saved = [book saveUserList:self.users withCurrentUser:user];
    NSAssert(saved, @"failed to save users: %@, current user: %@", self.users, user);
    
    return saved;
}

@end

#pragma mark - DOS

NSString *document_directory(void) {
    NSArray *paths;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES);
    return paths.firstObject;
}

NSString *caches_directory(void) {
    NSArray *paths;
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                NSUserDomainMask, YES);
    return paths.firstObject;
}

void make_dirs(NSString *dir) {
    // check base directory exists
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dir isDirectory:nil]) {
        NSError *error = nil;
        // make sure directory exists
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES
                       attributes:nil error:&error];
        assert(!error);
    }
}

BOOL file_exists(NSString *path) {
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:path];
}

BOOL remove_file(NSString *path) {
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSError *err = nil;
        [fm removeItemAtPath:path error:&err];
        if (err) {
            NSLog(@"failed to remove file: %@", err);
            return NO;
        }
    }
    return YES;
}
