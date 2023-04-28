//
//  HistoryDetailViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()

@end

@implementation HistoryDetailViewController
@synthesize eventObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.idLabel.text = [eventObject._id stringValue];
    self.tagIdLabel.text = eventObject.tag_id;
    self.uIdLabel.text = eventObject.uid;
    self.cycleTsLabel.text = eventObject.cycle_ts;
    self.eventLabel.text = [Util getEventCode:eventObject.event];
    self.LatitudeLabel.text = eventObject.lat;
    self.longitudeLabel.text = eventObject.longitude;
    self.deviceIdLabel.text = eventObject.deviceid;
    self.statusLabel.text = [Util getStatusCode:eventObject.status];
    self.createdAtLabel.text = eventObject.created_at;
    self.updatedAtLabel.text = eventObject.updated_at;
}

- (void)viewDidAppear:(BOOL)animated {
    self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width,590);
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
