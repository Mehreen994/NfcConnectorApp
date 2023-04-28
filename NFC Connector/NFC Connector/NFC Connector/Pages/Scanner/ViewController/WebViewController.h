//
//  WebViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <SwaggerClient/SWGTag.h>
@import WebKit;

typedef enum {
    webViewConnectorInfo,
    webViewProductInfo,
} WebViewType;

@interface WebViewController : UIViewController <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *webviewContainer;
@property (nonatomic, strong) NSString* webUrl;
@property (nonatomic) WebViewType webViewType;
@property (nonatomic, strong) SWGTag* productDataTag;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

