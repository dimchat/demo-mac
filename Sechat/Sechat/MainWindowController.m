#import "MainWindowController.h"
#import "ChatListViewController.h"
#import "ChatDetailViewController.h"
#import "ContactListViewController.h"
#import "ContactDetailViewController.h"
#import "LoginWindowController.h"
#import "Client.h"
#import "ContactListViewCell.h"

@interface MainWindowController ()<NSSplitViewDelegate, ListViewControllerDelegate>

@property (strong) IBOutlet NSSplitView *splitView;
@property (strong) ChatListViewController *chatListViewController;
@property (nonatomic, strong) ChatDetailViewController *chatDetailViewController;
@property (nonatomic, strong) ContactListViewController *contactListViewController;
@property (nonatomic, strong) ContactDetailViewController *contactDetailViewController;

@property (nonatomic, strong) LoginWindowController *loginController;
@property (strong) IBOutlet NSView *tabView;

@property (strong) IBOutlet NSView *listView;
@property (strong) IBOutlet NSView *detailView;

@property (assign) NSView *currentDetailView;
@property (assign) NSView *currentListView;

@end

@implementation MainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    Client *client = [Client sharedInstance];
    DIMUser *user = client.currentUser;
    
    if(!user){
        self.loginController = [[LoginWindowController alloc] initWithWindowNibName:@"LoginWindowController"];
        [self.window beginSheet:self.loginController.window completionHandler:^(NSModalResponse returnCode) {
            
        }];
    }
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex{
    
    if(dividerIndex == 0){
        return 200.0;
    }
    
    return proposedMinimumPosition;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex{
    
    if(dividerIndex == 0){
        return 300.0;
    }
    
    return proposedMaximumPosition;
}

- (IBAction)didPressChatButton:(id)sender {
    
    if(self.chatListViewController == nil){
        self.chatListViewController = [[ChatListViewController alloc] initWithNibName:@"ChatListViewController" bundle:nil];
        self.chatListViewController.delegate = self;
    }
    
    [self addViewToListView:self.chatListViewController.view];
}

- (IBAction)didPressContactButton:(id)sender {
    
    if(self.contactListViewController == nil){
        self.contactListViewController = [[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
        self.contactListViewController.delegate = self;
    }
    
    [self addViewToListView:self.contactListViewController.view];
}

- (IBAction)didPressSettingButton:(id)sender {
}

-(void)listViewController:(NSViewController *)controller didSelectObject:(NSObject *)selectedObject{
    
    if(controller == self.chatListViewController){
    
        if(self.chatDetailViewController == nil){
            self.chatDetailViewController = [[ChatDetailViewController alloc] initWithNibName:@"ChatDetailViewController" bundle:nil];
        }
        
        [self addViewToDetailView:self.chatDetailViewController.view];
        
    } else if (controller == self.contactListViewController){
        
        if(self.contactDetailViewController == nil){
            self.contactDetailViewController = [[ContactDetailViewController alloc] initWithNibName:@"ContactDetailViewController" bundle:nil];
        }
        
        self.contactDetailViewController.account = (DIMAccount *)selectedObject;
        [self addViewToDetailView:self.contactDetailViewController.view];
    }
}

-(void)addViewToListView:(NSView *)v{
    
    if(self.currentListView == v){
        return;
    }
    
    if(self.currentListView != nil){
        [self.currentListView removeFromSuperview];
    }
    
    v.frame = self.listView.bounds;
    [self.listView addSubview:v];
    
    [v setTranslatesAutoresizingMaskIntoConstraints:NO];

    //set contrain
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.listView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.listView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.listView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.listView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];

    [self.listView addConstraints:[NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4, nil]];
    self.currentListView = v;
}

-(void)addViewToDetailView:(NSView *)v{
    
    if(self.currentDetailView == v){
        return;
    }
    
    if(self.currentDetailView != nil){
        [self.currentDetailView removeFromSuperview];
    }
    
    v.frame = self.detailView.bounds;
    [self.detailView addSubview:v];
    
    [v setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //set contrain
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.detailView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.detailView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.detailView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.detailView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    [self.detailView addConstraints:[NSArray arrayWithObjects:constraint1, constraint2, constraint3, constraint4, nil]];
    self.currentDetailView = v;
}

@end
