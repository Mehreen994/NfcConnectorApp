//
//  Util.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUtil.h"
@interface Util : NSObject
+ (SWGHistory*) parseDictionaryToHistory : (NSMutableArray*) inputArray;
+ (NSString*) getEventCode: (NSString*) event;
+ (NSString*) getStatusCode: (NSString*) status;
@end

