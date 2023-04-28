
#import "VPProgressHUD.h"
#import "ViewControllerHelper.h"

@implementation VPProgressHUD

@synthesize yellowPointView, redPointView, instanceActive, backgroundView, parentViewController;

+ (VPProgressHUD *)sharedInstance
{
    static VPProgressHUD * myInstance = nil;
    if (!myInstance)
        myInstance = [[self.class alloc] init];
    return myInstance;
}

- (instancetype) init
{
    if (self = [super init])
    {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        CGFloat hudWidth = screenBounds.size.width/5;
        self.frame = CGRectMake((screenBounds.size.width/2) - (hudWidth/2),
                                (screenBounds.size.height/2) - (hudWidth/2),
                                hudWidth,
                                hudWidth);
        yellowPointView = [[UIView alloc] initWithFrame: CGRectMake(-10, self.frame.size.height/2 - 15/2, 15, 15)];
        yellowPointView.backgroundColor = UIColor.yellowColor;
        yellowPointView.layer.cornerRadius = yellowPointView.frame.size.width/2;
        yellowPointView.layer.masksToBounds = true;
        [self addSubview: yellowPointView];
        
        redPointView = [[UIView alloc] initWithFrame: CGRectMake(self.frame.size.width - 5, self.frame.size.height/2 - 15/2, 15, 15)];
        redPointView.backgroundColor = UIColor.redColor;
        redPointView.layer.cornerRadius = redPointView.frame.size.width/2;
        redPointView.layer.masksToBounds = true;
        [self addSubview: redPointView];
    }
    return self;
}

- (void) performAnimation
{
    /* Check if active view controller has changed - hide HUD when it has */
    
    if ([ViewControllerHelper visibleViewController] != [VPProgressHUD sharedInstance].parentViewController)
        [VPProgressHUD sharedInstance].instanceActive = false;
    
    [UIView animateWithDuration: 0.50
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^(void){
                         
                         CGRect rect = self.yellowPointView.frame;
                         rect.origin.x = self.frame.size.width - 5;
                         self.yellowPointView.frame = rect;
                         rect.origin.x = -10;
                         self.redPointView.frame = rect;
                         [self exchangeSubviewAtIndex: 0 withSubviewAtIndex: 1];
                     }
                     completion: ^(BOOL finished){
                         
                         [UIView animateWithDuration: 0.50
                                               delay: 0
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations: ^(void){
                                              
                                              CGRect rect = self.yellowPointView.frame;
                                              rect.origin.x = -10;
                                              self.yellowPointView.frame = rect;
                                              rect.origin.x = self.frame.size.width - 5;
                                              self.redPointView.frame = rect;
                                              [self exchangeSubviewAtIndex: 1 withSubviewAtIndex: 0];
                                          }
                                          completion: ^(BOOL finished){
                                              /* Continue when instance is still active */
                                              if ([VPProgressHUD sharedInstance].instanceActive)
                                                  [self performAnimation];
                                          }];
                     }];
    
}

+ (void) show
{
    /* Check if instance is already active */
    if ([VPProgressHUD sharedInstance].instanceActive)
        return;
    
    /* Show HUD on visible view controller */
    UIViewController *visibleViewController = [ViewControllerHelper visibleViewController];
    if (visibleViewController)
    {
        [visibleViewController.view addSubview: [VPProgressHUD sharedInstance] ];
        [VPProgressHUD sharedInstance].instanceActive = true;
        [VPProgressHUD sharedInstance].parentViewController = visibleViewController;
        [[VPProgressHUD sharedInstance] prepareBlueForVisibleViewController: visibleViewController];
        [[VPProgressHUD sharedInstance] performAnimation];
    }

    return;
}

+ (void) dismiss
{
    /* stop, dismiss and release current instance */
    [VPProgressHUD sharedInstance].instanceActive = false;
}


- (void) prepareBlueForVisibleViewController: (UIViewController *) visibleViewController
{
    if (iOS8) 
    {
        UIBlurEffectStyle effect = UIBlurEffectStyleLight;
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effect];
        
        backgroundView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    }
    else 
    {
        UIView *bView = [[UIView alloc] init];
        bView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.75f];
        backgroundView = bView;
    }
    
    if (iOS7) 
    {
        UIInterpolatingMotionEffect *x = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        
        CGFloat maxMovement = 20.0f;
        
        x.minimumRelativeValue = @(-maxMovement);
        x.maximumRelativeValue = @(maxMovement);
        
        UIInterpolatingMotionEffect *y = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        
        y.minimumRelativeValue = @(-maxMovement);
        y.maximumRelativeValue = @(maxMovement);
        
        UIView *bView = (UIView *)backgroundView;
        bView.motionEffects = @[x, y];
    }
    
    [self addSubview: backgroundView];
}


@end
