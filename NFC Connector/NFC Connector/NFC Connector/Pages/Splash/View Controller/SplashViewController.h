//
//  SplashViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 13.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFC_Connector-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *scanSymbol;
@property (weak, nonatomic) IBOutlet UIView *maskContainer;
@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

NS_ASSUME_NONNULL_END
