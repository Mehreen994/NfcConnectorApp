//
//  TabBarController.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 06.02.20.
//  Copyright © 2020 Auguris. All rights reserved.
//

#import "TabBarController.h"
#import "TabBarView.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSArray * arr =[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:nil options:nil];
    TabBarView * tabbarView = [arr firstObject];
    CGFloat tabBarHeight = self.tabBar.frame.size.height;

    tabbarView.frame = CGRectMake(0, self.view.frame.size.height - tabBarHeight - 24.0f, self.view.frame.size.width, tabBarHeight);

    [self.view addSubview:tabbarView];
}

- (void) switchToTab:(NSInteger) toTab from:(NSInteger) fromTab {
    NSLog(@"To %d From %d", toTab, fromTab);
    if (toTab == fromTab)
        return;

    self.selectedIndex = toTab;
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
