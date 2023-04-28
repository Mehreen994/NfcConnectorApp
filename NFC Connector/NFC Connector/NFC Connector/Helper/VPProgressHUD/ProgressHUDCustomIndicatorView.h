
#import <JGProgressHUD/JGProgressHUDIndicatorView.h>

@interface ProgressHUDCustomIndicatorView : JGProgressHUDIndicatorView

@property (strong, nonatomic) UIView * yellowPointView;
@property (strong, nonatomic) UIView * redPointView;
@property (nonatomic) BOOL instanceActive;
@property (nonatomic) id progressHUD; // reference to parent HUD
@property (nonatomic, strong) id parentViewController;  /* viewController the hud is presented on */
@property (nonatomic) BOOL progressHUDIsPresentedOnCustomViewController;

- (void) startAnimation;
- (void) stopAnimation;

@end
