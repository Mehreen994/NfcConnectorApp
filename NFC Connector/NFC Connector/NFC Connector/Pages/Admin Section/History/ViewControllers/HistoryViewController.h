//
//  HistoryViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *noRecordLabel;

@property (strong, nonatomic) NSString* tagString;
@end

NS_ASSUME_NONNULL_END
