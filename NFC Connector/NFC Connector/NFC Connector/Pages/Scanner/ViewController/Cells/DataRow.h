//
//  DataRow.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataRow : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionDetailLabel;

@end

NS_ASSUME_NONNULL_END
