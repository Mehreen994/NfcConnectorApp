

#import "ProgressHUDCustomIndicatorView.h"
#import "ViewControllerHelper.h"

@implementation ProgressHUDCustomIndicatorView

@synthesize yellowPointView, redPointView, instanceActive, progressHUD, parentViewController, progressHUDIsPresentedOnCustomViewController;

- (instancetype) init
{
    if (self = [super init])
    {
        yellowPointView = [[UIView alloc] initWithFrame: CGRectMake(-10, self.frame.size.height/2 - 15/2, 15, 15)];
        yellowPointView.backgroundColor = [UIColor colorWithRed:54/255 green:124/255 blue:169/255 alpha:1.0f];
        yellowPointView.layer.cornerRadius = yellowPointView.frame.size.width/2;
        yellowPointView.layer.masksToBounds = true;
        [self addSubview: yellowPointView];

        redPointView = [[UIView alloc] initWithFrame: CGRectMake(self.frame.size.width - 5, self.frame.size.height/2 - 15/2, 15, 15)];
        redPointView.backgroundColor = UIColor.whiteColor;
        redPointView.layer.cornerRadius = redPointView.frame.size.width/2;
        redPointView.layer.masksToBounds = true;
        [self addSubview: redPointView];
    }
    return self;
}


- (void) startAnimation
{
    /* 
     Check if visible viewController has changed - in this case, hide ProgressHUD
     Condition: Progress HUD is presented@VisibleViewController
     */
    if (!progressHUDIsPresentedOnCustomViewController && parentViewController != [ViewControllerHelper visibleViewController])
    {
        instanceActive = false;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([progressHUD respondsToSelector: @selector(callDismiss)])
        {
            [progressHUD performSelector: @selector(callDismiss)
                                   withObject: nil];
        }
#pragma clang diagnostic pop
        return;
    }
    
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
                                              if (self.instanceActive)
                                                  [self startAnimation];
                                          }];
                     }];
}

- (void) stopAnimation
{
    instanceActive = false;
}

@end
