//
//  HomeViewController.m
//  NFC Connector
//
//  Created by Mumtaz, Atiq on 14.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) backButtonPressed {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)backTabButtonPressed:(id)sender {
    [self backButtonPressed];
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
