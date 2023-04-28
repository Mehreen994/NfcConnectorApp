
#import "ProgressHUDTransitionController.h"

@implementation ProgressHUDTransitionController

@synthesize activeHUDCount;

+ (ProgressHUDTransitionController *)sharedInstance
{
    static ProgressHUDTransitionController * mySingleton = nil;
    
    if (!mySingleton)
    {
        mySingleton = [[self.class alloc] init];
        mySingleton.activeHUDCount = 0;
    }
    
    return mySingleton;
}

@end
