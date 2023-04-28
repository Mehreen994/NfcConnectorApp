

#import "ViewControllerHelper.h"
#import "StartViewController.h"

@implementation ViewControllerHelper

static UINavigationController* naviController;

+(void) setNavigationController: (UINavigationController*) controller {
    naviController = controller;
}

+(UINavigationController*) getNavigationController {
    return naviController;
}

+ (UIViewController *) visibleViewController {
    UIViewController * visibleViewController;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate window].rootViewController)
    {
        if (naviController != nil)
        {
            if (naviController.viewControllers.count > 0)
            {
                if ([[naviController.viewControllers.lastObject class] isSubclassOfClass: [UIViewController class]])
                {
                    visibleViewController = naviController.viewControllers.lastObject;
                    if (visibleViewController.presentedViewController)
                    {
                        if ([[visibleViewController.presentedViewController class] isSubclassOfClass: [UINavigationController class]])
                        {
                            UINavigationController *visibleNavigationController = (UINavigationController *) visibleViewController.presentedViewController;
                            if (visibleNavigationController.viewControllers.count > 0)
                            {
                                if ([[visibleNavigationController.viewControllers.lastObject class] isSubclassOfClass: [UIViewController class]])
                                {
                                    visibleViewController = visibleNavigationController.viewControllers.lastObject;
                                }
                            }
                        }
                        else
                        {
                            UIViewController *currentViewController = visibleViewController.presentedViewController;
                            visibleViewController = currentViewController;
                            while (currentViewController.presentedViewController) {
                                visibleViewController = currentViewController.presentedViewController;
                                currentViewController = visibleViewController;
                            }
                        }
                    }
                }
            }
        }
    }
    
    /* Disable Crashlytics for GDPR compliance */
    //    if (visibleViewController) {
    //        [CrashlyticsKit setObjectValue:NSStringFromClass([visibleViewController class]) forKey:@"visibleViewController"];
    //    }
    //    else{
    //        [CrashlyticsKit setObjectValue:@"nil" forKey:@"visibleViewController"];
    //    }
    
    return visibleViewController;
}

+ (UIViewController *) getStartMenuViewController {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if ([appDelegate window].rootViewController)
    {
        UIViewController * rootViewController = [appDelegate window].rootViewController;
        if ([[rootViewController class] isSubclassOfClass: [StartViewController class]])
        {
            StartViewController * menuViewController = (StartViewController *)rootViewController;
            return menuViewController;
        }
    }
    return nil;
}

+ (UIViewController *) getStartScreenViewController {
    UIViewController * viewController = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate window].rootViewController)
    {
        UIViewController * rootViewController = [appDelegate window].rootViewController;
        
        if ([[rootViewController class] isSubclassOfClass: [StartViewController class]])
        {
            if (naviController.viewControllers.count > 0)
                viewController = naviController.viewControllers[0];
        }
    }
    
    return viewController;
}

@end
