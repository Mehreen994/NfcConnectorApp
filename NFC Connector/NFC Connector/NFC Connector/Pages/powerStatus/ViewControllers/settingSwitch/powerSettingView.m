//
//  powerSettingView.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 08.12.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "powerSettingView.h"

@implementation powerSettingView
@synthesize contentView, settingSwitch, label, delegate;

- (instancetype) init {
    if (self = [super init]) {
        self.clipsToBounds = true;
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [self xibSetup];
        self.clipsToBounds = false;
    }

    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder])
        [self xibSetup];

    return self;
}

- (void) xibSetup {
    contentView = [self loadViewFromNib];
    contentView.backgroundColor = UIColor.clearColor;
    contentView.frame = self.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview: contentView];
}

- (IBAction)switchValueChanged:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
            [self.delegate switchStateChanged:YES];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(switchStateChanged:)]) {
            [self.delegate switchStateChanged:NO];
        }
    }
}

- (void) setSwitchValue: (BOOL) switchON {
    self.settingSwitch.on = switchON;
}
- (UIView *) loadViewFromNib
{
    NSBundle * bundle = [NSBundle bundleForClass: self.class];
    UINib * nib = [UINib nibWithNibName: @"SwitchView" bundle: bundle];

    return [nib instantiateWithOwner: self options: nil].firstObject;
}

- (void) awakeFromNib {
    [super awakeFromNib];

    self.clipsToBounds = false;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
