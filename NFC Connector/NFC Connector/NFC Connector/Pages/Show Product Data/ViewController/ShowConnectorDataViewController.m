//
//  ShowConnectorDataViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 22.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "ShowConnectorDataViewController.h"
#import "DataRow.h"
#import "Cycle.h"
#import "ApiUtil.h"

#import "UseMeasurementProductViewController.h"
#import "UseMedicalProductViewController.h"
#import "UseMiltaryProductViewController.h"
#import "UseIndustryProductViewController.h"

@interface ShowConnectorDataViewController ()
{
    UIColor* evenColor;
    UIColor* oddColor;
    UIColor * darkGreen;
}
@end

@implementation ShowConnectorDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    evenColor = [UIColor whiteColor];
    oddColor = [UIColor lightGrayColor];
    darkGreen = [UIColor colorWithRed:20.0/255.0 green:98.0/255.0 blue:0.0/255.0 alpha:1.0f];
    if (self.productDataTag != nil) {
        self.connectorDescription.text = _productDataTag.productDesc;
    }

    [self performSelector:@selector(checkAlert) withObject:nil afterDelay:1.0];

    self.connectorTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.connectorTableView.rowHeight = UITableViewAutomaticDimension;
    self.connectorTableView.delegate = self;
    self.connectorTableView.dataSource = self;
    [self.connectorTableView reloadData];
}


-(void) checkAlert {
    if (self.productDataTag) {
        int alert = [self.productDataTag.alertStatus intValue];

        if (alert == 2 || alert == 3) {
            [ApiUtil createNotAllowedEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
            }];
        } else {
            [ApiUtil createConnectorDataEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
            }];
        }

        if (alert == 1) {
            NSLog(@"----- Alert 1 , no need to do anything -------");
        } else if (alert == 2) {
            NSLog(@"----- Alert 2  -------");
            [AlertUtil showAlert2WithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self backButtonPressed:nil];
                });
            }];
        } else if (alert == 3) {
            NSLog(@"----- Alert 3  -------");
            [AlertUtil showAlert3WithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self backButtonPressed:nil];
                });
            }];
        } else if (alert == 4 || alert == 5) {
            NSLog(@"----- Alert 45  -------");
            [AlertUtil showAlert45WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:YES];
        } else if (alert == 6) {
            NSLog(@"----- Alert 6  -------");
            [AlertUtil showAlert6WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:YES];
        } else if (alert == 7 || alert == 8) {
            NSLog(@"----- Alert 78  -------");
            [AlertUtil showAlert78WithCompletionHandler:^{
            } OrderReplacementBlock:^{
            } ContinueUsingBlock:^{
            } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:YES];
        } else if (alert == 9) {
            NSLog(@"----- Alert 9  -------");
            [AlertUtil showAlert9WithCompletionHandler:^{
            } SuccessBlock:^{
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:YES];
        }
    }
}

#pragma mark - TableView Delegate


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataRow* cell = [tableView dequeueReusableCellWithIdentifier:@"DataRowCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"DataRow" bundle:nil] forCellReuseIdentifier:@"DataRowCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"DataRowCell"];
    }

    cell.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:14];

    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = evenColor;
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.descriptionLabel.textColor = [UIColor blackColor];
    } else {
        cell.backgroundColor = oddColor;
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.descriptionLabel.textColor = [UIColor whiteColor];
    }

    NSString* title = @"";
    NSString* desc = @"";
    NSString* detail = @"";

    if (_productDataTag) {
        if (indexPath.row == 0) {
            title = @"Tag-ID (UID) :";
            desc = [NSString stringWithFormat:@"%@", _productDataTag.uid];
        } else if (indexPath.row == 1) {
            title = @"DB-ID (UID) :";
            desc = [NSString stringWithFormat:@"%@", _productDataTag._id];
        } else if (indexPath.row == 2) {
            title = @"ODU Product No :";
            desc = _productDataTag.confectionCode;
        } else if (indexPath.row == 3) {
            title = @"ODU Customer No :";
            desc = _productDataTag.customerNo;
        } else if (indexPath.row == 4) {
            title = @"Connector Production Date :";
            desc = [self getDate:_productDataTag.connectorproductionDate];
        }  else if (indexPath.row == 5) {
            title = @"Branche :";
            desc = [self getBusinessField:_productDataTag.businessCode];
        }
    }


    cell.titleLabel.text = title;
    cell.descriptionLabel.text = desc;
    cell.descriptionDetailLabel.text = detail;
    return cell;
}

-(NSString*) getDate: (NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    return newDate;
}

- (IBAction)backButtonPressed:(id)sender {
    for(UIViewController* controller in [self.navigationController viewControllers]) {
        if ([controller isKindOfClass:[UseMedicalProductViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[UseMeasurementProductViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[UseIndustryProductViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        } else if ([controller isKindOfClass:[UseMiltaryProductViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

-(NSString*) getBusinessField:(NSNumber*) code {
    if ([code intValue] == 1) {
        return @"Medical";
    } else if ([code intValue] == 2) {
        return @"Measurement";
    }
    else if ([code intValue] == 3) {
        return @"Miltary";
    }
    else if ([code intValue] == 4) {
        return @"Industry";
    }
    return @"Unknown";
}

-(NSMutableAttributedString*)colorString:(NSString*) string Label:(UILabel*)label originalString:(NSString*) original color:(UIColor*) color {

    NSRange range = [original rangeOfString:string];

    NSMutableAttributedString *attrsString =  [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
    [attrsString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrsString;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
