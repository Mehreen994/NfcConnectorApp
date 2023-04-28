//
//  ShowConnectorDataViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 22.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwaggerClient/SWGTag.h>
#import "ScannerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowConnectorDataViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *connectorTableView;
@property (nonatomic, strong) SWGTag* productDataTag;
@property (weak, nonatomic) IBOutlet UILabel *connectorDescription;
@property (nonatomic) ApplicationType applicationType;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
