//
//  ProgressCell.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 25.10.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "ProgressCell.h"

@implementation ProgressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setUpCell:(CGFloat) from max_value:(CGFloat)total_val title:(NSString*) title emptyStorkeColor:(UIColor*)emptyColor {

   UIColor* theme =  [UIColor colorWithRed:54.0/255.0 green:124.0/255.0 blue:169.0/255.0 alpha:0.75f];
    if (from >= 100.0f) {
        self.progressView.progressColor = [UIColor redColor];
        self.progressView.progressStrokeColor = [UIColor redColor];
        self.progressView.fontColor = [UIColor redColor];
    } else if (from >= 80.0f && from < 100.0f) {
        self.progressView.progressColor = [UIColor orangeColor];
        self.progressView.progressStrokeColor = [UIColor orangeColor];
        self.progressView.fontColor = [UIColor orangeColor];
    } else {
        self.progressView.progressColor = theme;
        self.progressView.progressStrokeColor = theme;
        self.progressView.fontColor = theme;
    }
    self.title.text = title;
    self.progressView.maxValue = total_val;
    self.progressView.value = 0.0f;
    self.progressView.emptyLineStrokeColor = emptyColor;
    self.progressView.emptyLineColor = emptyColor;

    [UIView animateWithDuration:2.0 animations:^{
        self.progressView.value = from;
    }];
}

@end
