#import <Cocoa/Cocoa.h>

@interface BaseWindowController : NSWindowController

-(NSString *)defaultWindowTitleString;
- (void)setWindowTitle;

-(void)showErrorMessage:(NSString *)errorMessage completeHandler:(void (^)(NSModalResponse returnCode))handler;
-(void)showWarningMessage:(NSString *)warningMessage completeHandler:(void (^)(NSModalResponse returnCode))handler;

-(void)showPanelWithTitle:(NSString *)title message:(NSString *)message otherButtons:(NSArray *)buttonTitles defaultButton:(NSString *)defaultButtonTitle completeHandler:(void (^)(NSString * buttonTitle))handler;

@end
