//
//  SystemUtility.h
//  FinalsubX
//
//  Created by Macbook Air on 18/10/14.
//  Copyright (c) 2014 alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtility : NSObject

+(instancetype)sharedInstance;

-(NSString *)getOSVersion;
-(NSString *)getSerialNumber;
-(NSString *)getAppVersion;
-(NSString *)getBundleName;

-(void)sendEmailToAddress:(NSString *)address withSubject:(NSString *)subject withContent:(NSString *)content attachment:(NSArray *)attachments;

-(BOOL)isSystemVersionGreaterOrEqualThan:(NSString *)version;
-(BOOL)isApplicationInstalled:(NSString *)bundleIdString;
-(void)showFileInFinder:(NSURL *)url;

-(BOOL)hasLaunchForCurrentVersion;
-(void)markHasLaunchforCurrentVersion;

@end
