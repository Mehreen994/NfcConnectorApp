//
//  ShowProductDataViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwaggerClient/SWGTag.h>
#import "ScannerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowProductDataViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (nonatomic, strong) SWGTag* productDataTag;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (nonatomic) ApplicationType applicationType;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
