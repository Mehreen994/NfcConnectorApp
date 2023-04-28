

#import <UIKit/UIKit.h>

// FRAMEWORK CLASSES
#import <Accelerate/Accelerate.h>

#ifndef iOS7
#define iOS7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0)
#endif

#ifndef iOS8
#define iOS8 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0)
#endif


@interface VPProgressHUD : UIView

@property (strong, nonatomic) UIView * yellowPointView;
@property (strong, nonatomic) UIView * redPointView;
@property (nonatomic) BOOL instanceActive;
@property (nonatomic, strong) id backgroundView;
@property (nonatomic, strong) id parentViewController;  /* viewController the hud is presented on */

+ (VPProgressHUD *)sharedInstance;

- (instancetype) init;
- (void) performAnimation;


+ (void) show;
+ (void) dismiss;

- (void) prepareBlueForVisibleViewController: (UIViewController *) visibleViewController;

@end
