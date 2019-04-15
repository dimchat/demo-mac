#import "BaseWindowController.h"
#import "SystemUtility.h"
#import "Log.h"

typedef void (^AlertResponseBlock)(NSModalResponse returnCode);
typedef void (^MessageAlertResponseBlock)(NSString *buttonTitle);

@interface BaseWindowController ()

@property(nonatomic, strong) AlertResponseBlock alertHandler;
@property(nonatomic, strong) MessageAlertResponseBlock messageHandler;

@end

@implementation BaseWindowController

- (void)setWindowTitle{
    
    [self.window setTitle:[self defaultWindowTitleString]];
}

-(NSString *)defaultWindowTitleString{
    
    return [NSString stringWithFormat:NSLocalizedString(@"%@ %@ on OS X %@",@"title"), [[SystemUtility sharedInstance] getBundleName], [[SystemUtility sharedInstance] getAppVersion], [[SystemUtility sharedInstance] getOSVersion]];
}

-(void)showErrorMessage:(NSString *)errorMessage completeHandler:(void (^)(NSModalResponse returnCode))handler{
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleCritical;
    alert.messageText = NSLocalizedString(@"Error", @"title");
    alert.informativeText = errorMessage;
    
    if([[SystemUtility sharedInstance] isSystemVersionGreaterOrEqualThan:@"10.9"]){
        [alert beginSheetModalForWindow:self.window completionHandler:handler];
    }
}

-(void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    
    if(_alertHandler != nil){
        _alertHandler(returnCode);
    }
}

-(void)messageAlertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    
    if(_messageHandler != nil){
        NSButton *button = [alert.buttons objectAtIndex:returnCode];
        _messageHandler(button.title);
    }
}

-(void)showWarningMessage:(NSString *)warningMessage completeHandler:(void (^)(NSInteger returnCode))handler{
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = NSLocalizedString(@"Warning", @"title");
    alert.informativeText = warningMessage;
    
    if([[SystemUtility sharedInstance] isSystemVersionGreaterOrEqualThan:@"10.9"]){
        [alert beginSheetModalForWindow:self.window completionHandler:handler];
    }
}


-(void)showPanelWithTitle:(NSString *)title message:(NSString *)message otherButtons:(NSArray *)buttonTitles defaultButton:(NSString *)defaultButtonTitle completeHandler:(MessageAlertResponseBlock)handler{
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleInformational;
    alert.messageText = title;
    alert.informativeText = message;
    
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    [buttonArray addObject:defaultButtonTitle];
    [buttonArray addObjectsFromArray:buttonTitles];
    
    for(NSInteger i=0;i<[buttonArray count];i++){
        
        NSString *title = [buttonArray objectAtIndex:i];
        NSButton *button = [alert addButtonWithTitle:title];
        button.tag = i;
    }
    
    if([[SystemUtility sharedInstance] isSystemVersionGreaterOrEqualThan:@"10.9"]){
        [alert beginSheetModalForWindow:self.window completionHandler:^(NSInteger returnCode) {
            
            DBG(@"The return code is : %zd", returnCode);
            NSString *title = [buttonArray objectAtIndex:returnCode];
            
            if(handler != nil){
                handler(title);
            }
        }];
    }
}

@end
