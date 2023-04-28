

#import <Foundation/Foundation.h>

@interface ProgressHUDTransitionController : NSObject

@property (nonatomic) int activeHUDCount;

+ (ProgressHUDTransitionController *)sharedInstance;

@end
