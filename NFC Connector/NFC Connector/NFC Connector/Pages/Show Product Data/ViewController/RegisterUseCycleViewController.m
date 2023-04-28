//
//  RegisterUseCycleViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 29.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "RegisterUseCycleViewController.h"
#import "DataRow.h"
#import "ApiUtil.h"

#import "UseMeasurementProductViewController.h"
#import "UseMedicalProductViewController.h"
#import "UseMiltaryProductViewController.h"
#import "UseIndustryProductViewController.h"
#import "OrderWebViewController.h"

@interface RegisterUseCycleViewController () {
    UIColor* evenColor;
    UIColor* oddColor;
    UIColor * darkGreen;
    BOOL actionPerformed;
}
@end

@implementation RegisterUseCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    actionPerformed = NO;

    [self performSelector:@selector(checkAlert) withObject:nil afterDelay:1.0];

    evenColor = [UIColor whiteColor];
    oddColor = [UIColor lightGrayColor];
    darkGreen = [UIColor colorWithRed:20.0/255.0 green:98.0/255.0 blue:0.0/255.0 alpha:1.0f];
    if (self.productDataTag != nil) {
        self.productDescription.text = _productDataTag.productDesc;
    }

    if (self.scannerType == registerUseCycle) {
        self.title = @"Register Use Cycle";
    } else if (self.scannerType == registersterilizationCycle) {
        self.title = @"Register Sterilization Cycle";
    }
    
    self.dataTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.dataTableView reloadData];
}


-(void) secondCheck {
    // second check only for use cycle not for sterilization cycle
    if (self.scannerType == registerUseCycle && self.applicationType == medical) {
        NSString* status = [self getSterilizationStatus:_productDataTag.statusSterilization];
        NSLog(@"----- performing second Check ------- ster status = %@", status);
        if ([status isEqualToString:@"Sterilized"]) {
            [self performAction];
        } else if ([status isEqualToString:@"Contaiminated"]) {
            [AlertUtil showAlertWithTitle:@"Contaminated Product" message:@"This product is contaminated and not safe for use. Please sterilize before using." positiveBlock:^{
                // positive block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performAction];
                });
            } negativeBlock:^{
                //negative block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            }];
        } else {
            [AlertUtil showAlertWithTitle:@"Error" message:@"Wrong Sterilization status. Please contact with Admin." completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            }];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performAction];
        });
    }
}

-(void) callNotAllowedEvent {
    [ApiUtil createNotAllowedEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
    }];
}

-(void) checkAlert {
    if (self.productDataTag) {
        int alert = [self.productDataTag.alertStatus intValue];

        if (alert <= 1) {
            NSLog(@"----- Alert 1 , no need to do anything -------");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self secondCheck];
            });
        } else if (alert == 2) {
            NSLog(@"----- Alert 2  -------");
            [AlertUtil showAlert2WithCompletionHandler:^{
               dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            }];
        } else if (alert == 3) {
            NSLog(@"----- Alert 3  -------");
            [AlertUtil showAlert3WithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            }];
        } else if (alert == 4 || alert == 5) {
            NSLog(@"----- Alert 45  -------");
            if (alert == 4) {

                [AlertUtil showAlert45WithCompletionHandler:^{
                    // cancel block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self callNotAllowedEvent];
                        [self backButtonPressed:nil];
                    });
                } SuccessBlock:^{
                    // success block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self secondCheck];
                    });
                } WarningBlock:^{
                } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:NO];

            } else {

                [AlertUtil showAlert45WithCompletionHandler:^{
                    // cancel block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self callNotAllowedEvent];
                        [self backButtonPressed:nil];
                    });
                } SuccessBlock:^{
                    // success block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self secondCheck];
                    });
                } WarningBlock:^{
                } steriliCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useSterilization intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxSterilization intValue]] justWarning:NO];

            }

        } else if (alert == 6) {
            NSLog(@"----- Alert 6  -------");
            [AlertUtil showAlert6WithCompletionHandler:^{
                //cancel block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            } SuccessBlock:^{
                //success block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self secondCheck];
                });
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:NO];
        } else if (alert == 7 || alert == 8) {
            NSLog(@"----- Alert 78  -------");
            if (alert == 7) {
                [AlertUtil showAlert78WithCompletionHandler:^{
                } OrderReplacementBlock:^{
                    // order replacement block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self placeOrderAction];
                    });
                } ContinueUsingBlock:^{
                    // continue block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self secondCheck];
                    });
                } useCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]] totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:NO];
            } else {
                [AlertUtil showAlert78WithCompletionHandler:^{
                } OrderReplacementBlock:^{
                    // order replacement block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self placeOrderAction];
                    });
                } ContinueUsingBlock:^{
                    // continue block
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self secondCheck];
                    });
                } sterCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.useCycles intValue]]  totalCycles:[NSString stringWithFormat:@"%d", [self.productDataTag.maxUsecycles intValue]] justWarning:NO];
            }
        } else if (alert == 9) {
            NSLog(@"----- Alert 9  -------");
            [AlertUtil showAlert9WithCompletionHandler:^{
                // cancel Block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self callNotAllowedEvent];
                    [self backButtonPressed:nil];
                });
            } SuccessBlock:^{
                // success block
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self secondCheck];
                });
            } WarningBlock:^{
            } validityData:[self getDate:self.productDataTag.validTo] justWarning:YES];
        }
    }
}

-(void) performAction {
    if (self.scannerType == registerUseCycle) {
        NSLog(@"*** doPostRegisterUseCycle ***");
        [self doPostRegisterUseCycle:self.productDataTag.uid];
    } else {
        NSLog(@"*** doPostRegisterSterilizedCycle ***");
        [self doPostRegisterSterilizedCycle:self.productDataTag.uid];
    }
}

-(void) placeOrderAction {
    if (![self.productDataTag.linkReplacement isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"placeOrder" sender:nil];
    } else {
        [AlertUtil showAlertWithTitle:@"Error" message:@"Product Order Link is not set. Please contact Admin." completionHandler:^{
        }];
    }
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


#pragma mark - TableView Delegate


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (actionPerformed && indexPath.row == 6) {
       return [tableView dequeueReusableCellWithIdentifier:@"successCell"];
    }

    CGFloat usedSterilization_gl = ([_productDataTag.useSterilization floatValue] / [_productDataTag.maxSterilization floatValue] ) * 100.0f;
    CGFloat maxSterilization_gl = 100.0f;
    CGFloat usedCycle_gl = ([_productDataTag.useCycles floatValue] / [_productDataTag.maxUsecycles floatValue] ) * 100.0f;
    CGFloat maxUsedCycle_gl = 100.0f;

    if (actionPerformed) {
        if (indexPath.row == 4 || indexPath.row == 5 ) {
            ProgressCell* prCell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];

            if(indexPath.row == 4) {
                [prCell setUpCell:usedSterilization_gl max_value:maxSterilization_gl title:@"Sterilization Cycle" emptyStorkeColor:oddColor];
            } else {
                [prCell setUpCell:usedCycle_gl max_value:maxUsedCycle_gl title:@"Use Cycle" emptyStorkeColor:[UIColor whiteColor]];
            }

            if (indexPath.row % 2 != 0) {
                prCell.backgroundColor = evenColor;
                prCell.title.textColor = [UIColor blackColor];
            } else {
                prCell.backgroundColor = oddColor;
                prCell.title.textColor = [UIColor whiteColor];
            }

            return prCell;
        }
    } else {
        if (indexPath.row == 4 || indexPath.row == 5 ) {
            ProgressCell* prCell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];

            if(indexPath.row == 4) {
                [prCell setUpCell:usedSterilization_gl max_value:maxSterilization_gl title:@"Sterilization Cycle" emptyStorkeColor:oddColor];
            } else {
                [prCell setUpCell:usedCycle_gl max_value:maxUsedCycle_gl title:@"Use Cycle" emptyStorkeColor:[UIColor whiteColor]];
            }


            if (indexPath.row % 2 != 0) {
                prCell.backgroundColor = evenColor;
                prCell.title.textColor = [UIColor blackColor];
            } else {
                prCell.backgroundColor = oddColor;
                prCell.title.textColor = [UIColor whiteColor];
            }
            return prCell;
        }
    }

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
            title = @"Sterilization Cycle";
            int usedSterilization = [_productDataTag.useSterilization intValue];
            int maxSterilization = [_productDataTag.maxSterilization intValue];


            if (usedSterilization < (maxSterilization * 80 / 100)) {
                desc = [NSString stringWithFormat:@"%@ / %@ OK", _productDataTag.useSterilization, _productDataTag.maxSterilization];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Left", maxSterilization - usedSterilization];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useSterilization] Label:cell.descriptionLabel originalString:desc color:darkGreen];
                cell.descriptionLabel.attributedText = [self colorString: @"OK" Label:cell.descriptionLabel originalString:desc color:darkGreen];
                return cell;

            } else if (usedSterilization >= (maxSterilization * 80 / 100) && usedSterilization < maxSterilization) {
                desc = [NSString stringWithFormat:@"%@ / %@ Warning", _productDataTag.useSterilization, _productDataTag.maxSterilization];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Left", maxSterilization - usedSterilization];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useSterilization] Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Warning" Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                return cell;

            } else {
                desc = [NSString stringWithFormat:@"%@ / %@ Alert", _productDataTag.useSterilization, _productDataTag.maxSterilization];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                if (maxSterilization == usedSterilization) {
                    detail = [NSString stringWithFormat:@"%d Sterilization left",  usedSterilization - maxSterilization];
                } else {
                    detail = [NSString stringWithFormat:@"%d Sterilization are overused",  usedSterilization - maxSterilization];
                }

                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useSterilization] Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Alert" Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];

                return cell;
            }


        } else if (indexPath.row == 3) {
            title = @"Use Cycle";
            int usedCycle = [_productDataTag.useCycles intValue];
            int maxCycle = [_productDataTag.maxUsecycles intValue];

            if (usedCycle < (maxCycle * 80 / 100)) {
                desc = [NSString stringWithFormat:@"%@ / %@ OK", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Left", maxCycle - usedCycle];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:darkGreen];
                cell.descriptionLabel.attributedText = [self colorString: @"OK" Label:cell.descriptionLabel originalString:desc color:darkGreen];
                return cell;

            } else if (usedCycle >= (maxCycle * 80 / 100) && usedCycle < maxCycle) {

                desc = [NSString stringWithFormat:@"%@ / %@ Warning", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Left", maxCycle - usedCycle];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Warning" Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                return cell;
            } else {
                desc = [NSString stringWithFormat:@"%@ / %@ Alert", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                if (usedCycle == maxCycle) {
                    detail = [NSString stringWithFormat:@"%d Cycle left",  usedCycle - maxCycle];
                } else {
                    detail = [NSString stringWithFormat:@"%d Cycle are overused",  usedCycle - maxCycle];
                }

                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Alert" Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];

                return cell;
            }


        }
    }


    cell.titleLabel.text = title;
    cell.descriptionLabel.text = desc;
    cell.descriptionDetailLabel.text = detail;
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (actionPerformed) {
        return 7;
    } else {
        return 6;
    }

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (actionPerformed) {
        if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
            return 100.0;
        }
    } else {
        if (indexPath.row == 4 || indexPath.row == 5) {
            return 100.0;
        }
    }

    return UITableViewAutomaticDimension;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString*) getSterilizationStatus:(NSNumber*) code {
    if ([code intValue] == 1) {
        return @"Contaiminated";
    } else if ([code intValue] == 2) {
        return @"Sterilized";
    }

    return @"Unknown";
}

-(NSString*) getDate: (NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // Convert to new Date Format
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    return newDate;
}

-(NSMutableAttributedString*)colorString:(NSString*) string Label:(UILabel*)label originalString:(NSString*) original color:(UIColor*) color {

    NSRange range = [original rangeOfString:string];

    NSMutableAttributedString *attrsString =  [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
    [attrsString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrsString;
}



- (IBAction)orderReplacementClicked:(id)sender {
    if (![self.productDataTag.linkReplacement isEqualToString:@""]) {
        [sender setUserInteractionEnabled:NO];
        [self placeOrderAction];
    } else {
        [AlertUtil showAlertWithTitle:@"Error" message:@"Product Order Link is not set. Please contact Admin." completionHandler:^{
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"placeOrder"]) {
        OrderWebViewController* destination = segue.destinationViewController;
        destination.productDataTag = self.productDataTag;
        destination.webUrl = self.productDataTag.linkReplacement;
    }
}
#pragma mark - Web Methods

-(void) doPostRegisterUseCycle: (NSString*) tagData {
    [ApiUtil useCycle:tagData lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
        if (error1 != nil) {
            [AlertUtil showAlertWithTitle:NSLocalizedString(@"errorReadingTagInfoTitle", "Error") message:NSLocalizedString(@"errorReadingTagInfo", "NFC-Tag identified - product not registered !") completionHandler:^{
                [self backButtonPressed:nil];
            }];
            return;
        } else {
            self-> actionPerformed = YES;
            self.productDataTag = output1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataTableView reloadData];
            });
        }
    }];
}

-(void) doPostRegisterSterilizedCycle: (NSString*) tagData {
    [ApiUtil registerSterilizationCycle:tagData lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
        if (error1 != nil) {
            [AlertUtil showAlertWithTitle:NSLocalizedString(@"errorReadingTagInfoTitle", "Error") message:NSLocalizedString(@"errorReadingTagInfo", "NFC-Tag identified - product not registered !") completionHandler:^{
                [self backButtonPressed:nil];
            }];
            return;
        } else {
            self-> actionPerformed = YES;
            self.productDataTag = output1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataTableView reloadData];
            });
        }
    }];
}
@end
