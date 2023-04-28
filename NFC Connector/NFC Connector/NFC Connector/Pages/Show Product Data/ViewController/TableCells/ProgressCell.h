//
//  ProgressCell.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 25.10.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBCircularProgressBar/MBCircularProgressBarView.h>


@interface ProgressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *progressView;

-(void) setUpCell:(CGFloat) from max_value:(CGFloat)total_val title:(NSString*) title emptyStorkeColor:(UIColor*)emptyColor;
@end

