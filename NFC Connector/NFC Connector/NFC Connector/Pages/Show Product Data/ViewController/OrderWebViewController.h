//
//  OrderWebViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 22.10.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwaggerClient/SWGTag.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface OrderWebViewController : UIViewController <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *webviewContainer;
@property (nonatomic, strong) NSString* webUrl;
@property (nonatomic, strong) SWGTag* productDataTag;
@end

NS_ASSUME_NONNULL_END
