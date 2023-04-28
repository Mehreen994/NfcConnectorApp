//
//  ShowProductDataViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "ShowProductDataViewController.h"
#import "DataRow.h"
#import "ProgressCell.h"
#import "UseMeasurementProductViewController.h"
#import "UseMedicalProductViewController.h"
#import "UseMiltaryProductViewController.h"
#import "UseIndustryProductViewController.h"
#import "ApiUtil.h"

@interface ShowProductDataViewController ()
{
    UIColor* evenColor;
    UIColor* oddColor;
    UIColor * darkGreen;
}
@end

@implementation ShowProductDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   [self performSelector:@selector(checkAlert) withObject:nil afterDelay:1.0];
    evenColor = [UIColor whiteColor]; //colorWithRed:54.0/255.0 green:124.0/255.0 blue:169.0/255.0 alpha:0.75f
    oddColor = [UIColor lightGrayColor];
    darkGreen = [UIColor colorWithRed:20.0/255.0 green:98.0/255.0 blue:0.0/255.0 alpha:1.0f];
    if (self.productDataTag != nil) {
        self.productDescription.text = _productDataTag.productDesc;
    }

    NSLog(@"alert = %@", self.productDataTag.alertStatus);
   
    self.dataTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.dataTableView.rowHeight = UITableViewAutomaticDimension;
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.dataTableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) checkAlert {
    if (self.productDataTag) {
        int alert = [self.productDataTag.alertStatus intValue];

        if (alert == 2 || alert == 3) {
            [ApiUtil createNotAllowedEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
            }];
        } else {
            [ApiUtil createProductDataEvent:self.productDataTag.uid lat:[NSNumber numberWithFloat:_coordinate.latitude] _long:[NSNumber numberWithFloat:_coordinate.longitude] completionHandler:^(SWGTag * _Nonnull output1, NSError * _Nonnull error1) {
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

-(NSString*) getSterilizationStatus:(NSNumber*) code {
    if ([code intValue] == 1) {
        return @"Contaiminated";
    } else if ([code intValue] == 2) {
        return @"Sterilized";
    }

    return @"Unknown";
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

-(void) showOrderButton: (BOOL) visible {
    if (visible) {
        self.buttonHeight.constant = 75.0f;
        [self.buttonView setHidden:NO];
    } else {
        self.buttonHeight.constant = 0.01f;
        [self.buttonView setHidden:YES];
    }

    [self.view layoutIfNeeded];
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

#pragma mark TableView Delegate


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
            title = @"Customer Nr:";
            desc = [NSString stringWithFormat:@"%@", _productDataTag.customerNo];
        } else if (indexPath.row == 1) {
            title = @"Customer Name:";
            desc = [NSString stringWithFormat:@"%@", _productDataTag.customer_name];
        } else if (indexPath.row == 2) {
            title = @"Business Field";
            desc = [NSString stringWithFormat:@"%@", [self getBusinessField:_productDataTag.businessCode]];
        } else if (indexPath.row == 3) {
            title = @"Validity";
            desc = [self getDate:_productDataTag.validTo];
        } else if (indexPath.row == 4) {
            title = @"Prod. Date";
            desc = [self getDate:_productDataTag.productionDate];
        } else if (indexPath.row == 5) {
            title = @"Sterilization Status";
            NSString* status = [self getSterilizationStatus:_productDataTag.statusSterilization];
            if ([status isEqualToString:@"Contaiminated"]){
                cell.descriptionLabel.textColor = [UIColor redColor];
                cell.descriptionLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
            } else if ([status isEqualToString:@"Sterilized"]){
                cell.descriptionLabel.textColor = darkGreen;
                cell.descriptionLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14];
            }
            desc = [NSString stringWithFormat:@"%@", status];
        } else if (indexPath.row == 6) {
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

            } else if (usedSterilization > (maxSterilization * 80 / 100) && usedSterilization < maxSterilization) {
                desc = [NSString stringWithFormat:@"%@ / %@ Warning", _productDataTag.useSterilization, _productDataTag.maxSterilization];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Left", maxSterilization - usedSterilization];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useSterilization] Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Warning" Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                [self showOrderButton: YES];
                return cell;

            } else {
                desc = [NSString stringWithFormat:@"%@ / %@ Alert", _productDataTag.useSterilization, _productDataTag.maxSterilization];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;
                detail = [NSString stringWithFormat:@"%d Sterilization are overused",  usedSterilization - maxSterilization];
                cell.descriptionDetailLabel.text = detail;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useSterilization] Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Alert" Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];

                return cell;
            }


        } else if (indexPath.row == 7) {
            title = @"Use Cycle";
            int usedCycle = [_productDataTag.useCycles intValue];
            int maxCycle = [_productDataTag.maxUsecycles intValue];

            if (usedCycle < (maxCycle * 80 / 100)) {
                desc = [NSString stringWithFormat:@"%@ / %@ OK", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:darkGreen];
                cell.descriptionLabel.attributedText = [self colorString: @"OK" Label:cell.descriptionLabel originalString:desc color:darkGreen];
                return cell;

            } else if (usedCycle > (maxCycle * 80 / 100) && usedCycle < maxCycle) {

                desc = [NSString stringWithFormat:@"%@ / %@ Warning", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Warning" Label:cell.descriptionLabel originalString:desc color:[UIColor orangeColor]];
                 [self showOrderButton: YES];
                return cell;
            } else {
                desc = [NSString stringWithFormat:@"%@ / %@ Alert", _productDataTag.useCycles, _productDataTag.maxUsecycles];
                cell.descriptionLabel.text = desc;
                cell.titleLabel.text = title;

                cell.descriptionLabel.attributedText = [self colorString: [NSString stringWithFormat:@"%@", _productDataTag.useCycles] Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];
                cell.descriptionLabel.attributedText = [self colorString: @"Alert" Label:cell.descriptionLabel originalString:desc color:[UIColor redColor]];

                return cell;
            }
        } else if (indexPath.row == 8 || indexPath.row == 9 ) {
            CGFloat usedSterilization_gl = ([_productDataTag.useSterilization floatValue] / [_productDataTag.maxSterilization floatValue] ) * 100.0f;
            CGFloat maxSterilization_gl = 100.0f;
            CGFloat usedCycle_gl = ([_productDataTag.useCycles floatValue] / [_productDataTag.maxUsecycles floatValue] ) * 100.0f;
            CGFloat maxUsedCycle_gl = 100.0f;

            ProgressCell* prCell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];

            if(indexPath.row == 8) {
                [prCell setUpCell:usedSterilization_gl max_value:maxSterilization_gl title:@"Sterilization Cycle" emptyStorkeColor:[UIColor whiteColor]];
            } else {
                [prCell setUpCell:usedCycle_gl max_value:maxUsedCycle_gl title:@"Use Cycle" emptyStorkeColor: oddColor];
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


    cell.titleLabel.text = title;
    cell.descriptionLabel.text = desc;
    cell.descriptionDetailLabel.text = detail;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 8 || indexPath.row == 9) {
        return 100.0;
    }

    return UITableViewAutomaticDimension;
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
