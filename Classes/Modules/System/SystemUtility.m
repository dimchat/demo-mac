//
//  SystemUtility.m
//  FinalsubX
//
//  Created by Macbook Air on 18/10/14.
//  Copyright (c) 2014 alex. All rights reserved.
//

#import "SystemUtility.h"
#import "NSString+Utility.h"
#import <AppKit/AppKit.h>
#include <IOKit/IOKitLib.h>

@implementation SystemUtility

+(instancetype)sharedInstance{
    
    static SystemUtility *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

-(NSString *)getOSVersion{
    
    NSString *systemVersion = [[NSProcessInfo processInfo] operatingSystemVersionString];
    
    NSString *regex = @"10\\.\\d+\\.?\\d+";
    NSRegularExpression *subtitlesExpression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
    NSArray *matchs = [subtitlesExpression matchesInString:systemVersion options:0 range:NSMakeRange(0, [systemVersion length])];
    
    if(matchs > 0){
        
        NSTextCheckingResult *result = matchs[0];
        NSString *subString = [[systemVersion substringWithRange:result.range] trim];
        systemVersion = subString;
    }
    
    return systemVersion;
}

- (NSString *)getSerialNumber
{
    NSString *serial = nil;
    io_service_t platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                              IOServiceMatching("IOPlatformExpertDevice"));
    if (platformExpert) {
        CFTypeRef serialNumberAsCFString =
        IORegistryEntryCreateCFProperty(platformExpert,
                                        CFSTR(kIOPlatformSerialNumberKey),
                                        kCFAllocatorDefault, 0);
        if (serialNumberAsCFString) {
            serial = CFBridgingRelease(serialNumberAsCFString);
        }
        
        IOObjectRelease(platformExpert);
    }
    return serial;
}

-(NSString *)getAppVersion{
    
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [dic objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}

-(NSString *)getBundleName{
    
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    NSString *productName = [dic objectForKey:@"CFBundleName"];
    
    return productName;
}

-(void)sendEmailToAddress:(NSString *)address withSubject:(NSString *)subject withContent:(NSString *)content attachment:(NSArray *)attachments{
    
    if([[SystemUtility sharedInstance] isSystemVersionGreaterOrEqualThan:@"10.9"]){
        
        NSAttributedString* textAttributedString = [[NSAttributedString alloc] initWithString:content];
        
        NSSharingService* mailShare = [NSSharingService sharingServiceNamed:NSSharingServiceNameComposeEmail];
        mailShare.recipients = @[address];
        mailShare.subject = subject;
        
        NSMutableArray *shareItems = [[NSMutableArray alloc] init];
        [shareItems addObject:textAttributedString];
        [shareItems addObjectsFromArray:attachments];
        [mailShare performWithItems:shareItems];
        
    } else {
        
        NSString *mailtoAddress = [[NSString stringWithFormat:@"mailto:%@?Subject=%@&body=%@", address, subject, content] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:mailtoAddress]];
    }
}

-(BOOL)isSystemVersionGreaterOrEqualThan:(NSString *)version{
    
    NSString *systemVersion = [self getOSVersion];
    NSArray *versionArray = [version componentsSeparatedByString:@"."];
    NSArray *systemVersionArray = [systemVersion componentsSeparatedByString:@"."];
    
    BOOL result = YES;
    
    NSUInteger index = 0;
    
    while(index < [versionArray count] && index < [systemVersionArray count]){
        
        NSString *versionString = [versionArray objectAtIndex:index];
        NSString *systemVersionString = [systemVersionArray objectAtIndex:index];
        
        if([systemVersionString integerValue] < [versionString integerValue]){
            result = NO;
            break;
        }
        
        index ++;
    }
    
    return result;
}

-(BOOL)isApplicationInstalled:(NSString *)bundleIdString{
    
    BOOL result = NO;
    
    CFStringRef bundleId = CFStringCreateWithCString(NULL, [bundleIdString UTF8String], kCFStringEncodingUTF8);
    
    CFURLRef appURL = NULL;
    OSStatus resultStatus = LSFindApplicationForInfo (kLSUnknownCreator,
                                                      bundleId,
                                                      NULL,
                                                      NULL,
                                                      &appURL
                                                      );
    if(resultStatus == noErr){
        result = YES;
    }else{
        result = NO;
    }
    
    if(appURL){
        CFRelease(appURL);
    }
    
    CFRelease(bundleId);
    return result;
}

-(void)showFileInFinder:(NSURL *)url{
    
    [url startAccessingSecurityScopedResource];
    NSWorkspace *ws = [NSWorkspace sharedWorkspace];
    NSArray *fileURLs = @[url];
    [ws activateFileViewerSelectingURLs:fileURLs];
    [url stopAccessingSecurityScopedResource];
}

-(NSString *)firstLaunchKey{
    
    NSString *appVersion = [self getAppVersion];
    NSString *key = [NSString stringWithFormat:@"First_Launch_%@", appVersion];
    return key;
}

-(BOOL)hasLaunchForCurrentVersion{
    
    NSString *key = [self firstLaunchKey];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

-(void)markHasLaunchforCurrentVersion{
    
    NSString *key = [self firstLaunchKey];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
