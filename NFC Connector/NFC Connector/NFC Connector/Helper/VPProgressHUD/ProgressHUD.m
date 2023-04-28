

#import "ProgressHUD.h"
#import "ProgressHUDTransitionController.h"
#import "ViewControllerHelper.h"

@implementation ProgressHUD

+ (ProgressHUD *)sharedInstance
{
    static ProgressHUD * myInstance = nil;
    if (!myInstance)
    {
        myInstance = [[self.class alloc] init];
        myInstance = [ProgressHUD progressHUDWithStyle: JGProgressHUDStyleLight];
        myInstance.indicatorView = ProgressHUDCustomIndicatorView.new;
        ProgressHUDCustomIndicatorView *indicatorSubClassView = (ProgressHUDCustomIndicatorView *)myInstance.indicatorView;
        indicatorSubClassView.progressHUD = myInstance;
    }
    return myInstance;
}

+ (void) show
{
    /* Check if instance is already active */
    ProgressHUDCustomIndicatorView *indicatorView = (ProgressHUDCustomIndicatorView *)[ProgressHUD sharedInstance].indicatorView;
    if (indicatorView.instanceActive)
        return;
    
    /* Show HUD on visible view controller */
    UIViewController *visibleViewController = [ViewControllerHelper visibleViewController];
    if (visibleViewController) {
        indicatorView.instanceActive = true;
        indicatorView.parentViewController = visibleViewController;
        indicatorView.progressHUDIsPresentedOnCustomViewController = false;
        [[ProgressHUD sharedInstance] callShowInView: visibleViewController.view];
        [indicatorView startAnimation];
    }
}

+ (void) showOnViewController: (UIViewController *) viewController
{
    /* Check if instance is already active */
    ProgressHUDCustomIndicatorView *indicatorView = (ProgressHUDCustomIndicatorView *)[ProgressHUD sharedInstance].indicatorView;
    if (indicatorView.instanceActive)
        return;
    
    /* Show HUD on visible view controller */
    UIViewController *visibleViewController = viewController;
    if (visibleViewController) {
        indicatorView.instanceActive = true;
        indicatorView.parentViewController = visibleViewController;
        indicatorView.progressHUDIsPresentedOnCustomViewController = true;
        [[ProgressHUD sharedInstance] callShowInView: visibleViewController.view];
        [indicatorView startAnimation];
    }
}


+ (void) dismiss
{
    /* stop, dismiss and release current instance */
    ProgressHUDCustomIndicatorView *indicatorView = (ProgressHUDCustomIndicatorView *)[ProgressHUD sharedInstance].indicatorView;
    [indicatorView stopAnimation];
    [[ProgressHUD sharedInstance] callDismiss];
}

#pragma mark - super calls
- (void) callShowInView: (UIView *) view
{
    [super showInView: view
             animated: true];
}

- (void) callDismiss
{
    [super dismiss];
}

@end
