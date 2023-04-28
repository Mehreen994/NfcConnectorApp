//
//  StartViewController.m
//  NFC Connector
//
//  Created by Mumtaz, Atiq on 14.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "StartViewController.h"
#import "Cycle.h"
#import "ApiUtil.h"
#import <AVFoundation/AVFoundation.h>

// load models
#import <SwaggerClient/SWGCycle.h>
#import <SwaggerClient/SWGTag.h>
// load API classes for accessing endpoints
#import <SwaggerClient/SWGTagApi.h>

#import "ProgressHUD.h"
#import "ViewControllerHelper.h"

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cycleReceivedNotification:) name:@"cycleReceived" object:nil];
    [ViewControllerHelper setNavigationController:self.navigationController];

}

-(void) viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
}
- (IBAction)adminLoginClicked:(id)sender {
    [self performSegueWithIdentifier:@"showAdminStart" sender:nil];
}

#pragma mark - Notification

-(void) cycleReceivedNotification : (NSNotification*) note {

   NSDictionary* dict = note.object;
    [CycleShared parseDictionary:dict];
}

@end
