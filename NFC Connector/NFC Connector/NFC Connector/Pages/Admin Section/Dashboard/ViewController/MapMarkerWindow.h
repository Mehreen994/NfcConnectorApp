//
//  MapMarkerWindow.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 25.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MapMarkerWindowProtocol
@optional
- (void) infoWindowViewButtonClicked;
@end

@interface MapMarkerWindow : UIView
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subDescriptionLabel;
- (void) setDelegate:(id)newDelegate;

+(UIView*) instanceFromNib;
@end

