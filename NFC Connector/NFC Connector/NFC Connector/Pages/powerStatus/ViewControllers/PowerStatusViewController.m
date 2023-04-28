//
//  PowerStatusViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 08.12.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "PowerStatusViewController.h"
#import "ApiUtil.h"
#import "UseMeasurementProductViewController.h"
#import "UseMedicalProductViewController.h"
#import "UseMiltaryProductViewController.h"
#import "UseIndustryProductViewController.h"

@interface PowerStatusViewController () {
    NSTimer* myTimer;
    powerSettingView* powerView;
    NSMutableArray* xAxisValues;
    NSMutableArray* yAxisValues;
    int counter;
}
@end

@implementation PowerStatusViewController
@synthesize productDataTag;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    xAxisValues = [[NSMutableArray alloc] init];
    yAxisValues = [[NSMutableArray alloc] init];
    counter = 1;
    [xAxisValues addObject:@(0)];
    [yAxisValues addObject:@(0)];
    //[self.chartView drawChart];

    self.chartView.chartSubTitle = self.tagId;
    [self.yaxisLabel setTransform: CGAffineTransformMakeRotation(-M_PI / 2)];


    [self startTimer];
    [self updateStatus];


    powerView = [[powerSettingView alloc] initWithFrame:CGRectMake(0, 0, 170, 50)];
    powerView.delegate = self;
    UIBarButtonItem *myItem = [[UIBarButtonItem alloc] initWithCustomView:powerView];
    
    self.navigationItem.rightBarButtonItems=@[myItem];


}

- (void) updateStatus {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self->productDataTag != nil && self->productDataTag.power_status != nil) {
            if ([self->productDataTag.power_status isEqualToString:@"1"]) {
                [self->powerView setSwitchValue: YES];
            } else {
                [self->powerView setSwitchValue:NO];
            }
        } else {
            [self->powerView setSwitchValue:NO];
        }
    });
}

- (IBAction)backButtonPressed:(id)sender {
    if (myTimer) {
        [myTimer invalidate];
    }

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

- (void) switchStateChanged: (BOOL)state {
    NSLog(@"switchStateChanged = %d", state);
    NSString* onVal = @"0";
    if (state) {
        onVal = @"1";
    }
    [ApiUtil updateTagPowerStatus:productDataTag powerStatus:onVal completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        if (output != nil) {
            self->productDataTag = output;
            [self updateStatus];
        } else {
            [AlertUtil showAlertWithTitle:@"Error" message:@"could not update the power status." completionHandler:^{
                [self updateStatus];
            }];
        }
    }];
}


-(void) startTimer {
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                               target:self
                                             selector:@selector(getPowerState:)
                                             userInfo:nil
                                              repeats:NO];
}
- (void) getPowerState:(NSTimer *)timer {
    [myTimer invalidate];
        [[ApiUtil getApiInstance] tagGetPowerConsumptionWithTagId:_tagId completionHandler:^(SWGPowerConsumption *output, NSError *error) {
            if (output != nil) {

                [self clearGraphIfPossible];
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                [formatter setMaximumFractionDigits:4];
                [formatter setRoundingMode: NSNumberFormatterRoundUp];
                NSString *numberString = [formatter stringFromNumber:output.powerConsumption];
                numberString = [numberString stringByReplacingOccurrencesOfString:@"," withString:@"."];
                double val = [numberString doubleValue];
                [self->xAxisValues addObject:@(2 * self->counter)];
                if (val > 0) {
                    val = (val / 1 ) * 100;
                }
                [self->yAxisValues addObject:@(val)];
                [self updateGraph];
                self->counter += 1;
                NSLog(@"power = %f", val);
            } else {
                NSLog(@"failed to get power status");
            }
            [self startTimer];
        }];
}

-(void) clearGraphIfPossible {
    if (xAxisValues.count > 13) {
        [xAxisValues removeObjectAtIndex:0];
        [yAxisValues removeObjectAtIndex:1];
    }
}
-(void) updateGraph {
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.chartView updateChartWithXElements:self->xAxisValues yElements:self->yAxisValues];
        self.chartView.xElements = self->xAxisValues;
        self.chartView.yElements = self->yAxisValues;
        [self.chartView drawChart];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
