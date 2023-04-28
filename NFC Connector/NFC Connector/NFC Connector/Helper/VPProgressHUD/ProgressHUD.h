

#import <JGProgressHUD/JGProgressHUD.h>
#import "ProgressHUDCustomIndicatorView.h"

@interface ProgressHUD : JGProgressHUD

+ (ProgressHUD *)sharedInstance;
+ (void) show;
+ (void) showOnViewController: (UIViewController *) viewController;
+ (void) dismiss;

#pragma mark - super calls
- (void) callShowInView: (UIView *) view;
- (void) callDismiss;
@end
