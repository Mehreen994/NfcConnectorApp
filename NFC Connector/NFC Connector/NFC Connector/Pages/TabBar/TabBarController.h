//
//  TabBarController.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 06.02.20.
//  Copyright © 2020 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController : UITabBarController
- (void) switchToTab:(NSInteger) toTab from:(NSInteger) fromTab;
@end

NS_ASSUME_NONNULL_END
