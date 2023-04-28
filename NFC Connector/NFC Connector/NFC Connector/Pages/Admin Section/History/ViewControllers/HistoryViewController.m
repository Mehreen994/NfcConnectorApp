//
//  HistoryViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "HistoryViewController.h"
#import "ApiUtil.h"
#import "AlertUtil.h"
#import "HistoryTableViewCell.h"
#import "HistoryDetailViewController.h"
#import "AdminStartViewController.h"

@interface HistoryViewController () {
    SWGHistory* history;
    SWGHistory* tableHistory;
}
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadHistory];
    _searchBar.delegate = self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarSearchButtonClicked");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_searchBar endEditing:YES];
    });
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString* temp = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([temp isEqualToString:@""]){
        NSLog(@"clear the search result");

        [self resetTableHistory];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpTable];
            [self->_searchBar endEditing:YES];
        });
    } else {
        [tableHistory.cycles removeAllObjects];
        for (SWGEvent* event in history.cycles) {
            NSString* eventStr = [Util getEventCode:event.event];
            if ([eventStr containsString:[searchText lowercaseString]]) {
                [tableHistory.cycles addObject:event];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpTable];
        });
    }
}

- (IBAction)backButtonPressed:(id)sender {
    for(UIViewController* controller in [self.navigationController viewControllers]) {
        if ([controller isKindOfClass:[AdminStartViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (void) resetTableHistory {
    [tableHistory.cycles removeAllObjects];
    for (SWGEvent* event in history.cycles) {
        [tableHistory.cycles addObject:event];
    }
}
- (void) loadHistory {
    tableHistory = [[SWGHistory alloc] init];
    [tableHistory setCycles:[[NSMutableArray alloc] init]];

    [ApiUtil getHistoryWithTag:_tagString completionHandler:^(SWGHistory * _Nonnull output, NSError * _Nonnull error) {
        if (error) {
            [AlertUtil showAlertWithTitle:@"Error" message:@"Failed to load the History." completionHandler:^{
                self -> _searchBar.userInteractionEnabled = NO;
            }];
        } else {
            
            if (output.cycles.count == 0) {
                [self.noRecordLabel setHidden:NO];
                [self.tableView setHidden:YES];
            } else {
                [self.noRecordLabel setHidden:YES];
                [self.tableView setHidden:NO];
            }

            self->history = output;
            [self resetTableHistory];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUpTable];
            });
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
       HistoryDetailViewController* detailViewController = (HistoryDetailViewController*) segue.destinationViewController;
        detailViewController.eventObject = (SWGEvent*) sender;
    }
}


-(void) setUpTable {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SWGEvent* rowEvent = [tableHistory.cycles objectAtIndex:indexPath.row];
    if (rowEvent) {
        cell.titleLabel.text = [Util getEventCode:rowEvent.event];
        cell.dateLabel.text = rowEvent.created_at;
        NSArray* parts = [rowEvent.deviceid componentsSeparatedByString:@"-OS"];
        cell.descriptionLabel.text = parts[0];
    }
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7f];
    } else {
        cell.backgroundColor = UIColor.whiteColor;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWGEvent* rowEvent = [tableHistory.cycles objectAtIndex:indexPath.row];
    if (rowEvent != nil) {
        [self performSegueWithIdentifier:@"showDetail" sender:rowEvent];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableHistory.cycles.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
@end
