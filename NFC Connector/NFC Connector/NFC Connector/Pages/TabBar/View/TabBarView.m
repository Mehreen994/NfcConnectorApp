//
//  TabBarView.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 06.02.20.
//  Copyright © 2020 Auguris. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarController.h"
@implementation TabBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)home_button_clicked:(id)sender {
   UINavigationController* navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
   TabBarController* tabBarController = [[navController viewControllers] objectAtIndex:1];
    [tabBarController switchToTab:0 from:[tabBarController selectedIndex]];
}

- (IBAction)test_measurement_button_clicked:(id)sender {
    UINavigationController* navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    TabBarController* tabBarController = [[navController viewControllers] objectAtIndex:1];
    [tabBarController switchToTab:2 from:[tabBarController selectedIndex]];
}
- (IBAction)medical_button_clicked:(id)sender {
    UINavigationController* navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    TabBarController* tabBarController = [[navController viewControllers] objectAtIndex:1];
    [tabBarController switchToTab:1 from:[tabBarController selectedIndex]];
}
- (IBAction)miltary_button_clicked:(id)sender {
    UINavigationController* navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    TabBarController* tabBarController = [[navController viewControllers] objectAtIndex:1];
    [tabBarController switchToTab:3 from:[tabBarController selectedIndex]];
}

- (IBAction)industry_button_clicked:(id)sender {
    UINavigationController* navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    TabBarController* tabBarController = [[navController viewControllers] objectAtIndex:1];
    [tabBarController switchToTab:4 from:[tabBarController selectedIndex]];
}


@end
