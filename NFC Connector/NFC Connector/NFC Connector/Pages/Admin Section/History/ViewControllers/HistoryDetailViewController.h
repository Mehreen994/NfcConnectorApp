//
//  HistoryDetailViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentContainer;
@property (strong, nonatomic) SWGEvent* eventObject;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *uIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleTsLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *LatitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedAtLabel;

@end

NS_ASSUME_NONNULL_END
