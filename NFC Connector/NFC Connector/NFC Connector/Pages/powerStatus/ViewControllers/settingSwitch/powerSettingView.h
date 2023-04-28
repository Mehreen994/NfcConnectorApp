//
//  powerSettingView.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 08.12.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol powerSwitchDelegate <NSObject>
    - (void) switchStateChanged: (BOOL)state;
@end

@interface powerSettingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UISwitch *settingSwitch;
@property (weak) id delegate;

- (void) setSwitchValue: (BOOL) switchON;
@end

NS_ASSUME_NONNULL_END
