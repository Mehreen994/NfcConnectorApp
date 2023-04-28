
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerHelper : NSObject
+ (UIViewController *) visibleViewController;
+ (UIViewController *) getStartMenuViewController;
+ (UIViewController *) getStartScreenViewController;
+(void) setNavigationController: (UINavigationController*) controller ;
+(UINavigationController*) getNavigationController;
@end

NS_ASSUME_NONNULL_END
