//
//  Util.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 23.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "Util.h"
@implementation Util
+ (SWGHistory*) parseDictionaryToHistory : (NSMutableArray*) inputArray {
    SWGHistory* output = [[SWGHistory alloc] init];
    output.cycles = [[NSMutableArray alloc] init];
    BOOL sortedRequired = NO;
    for (NSDictionary* dict in inputArray) {
        SWGEvent* eventObj = [[SWGEvent alloc] init];
        sortedRequired = YES;
        NSNumber* _id = [dict objectForKey:@"id"];
        NSString* tag_id = [dict objectForKey:@"tag_id"];
        NSString* uid = [dict objectForKey:@"uid"];
        NSString* cycle_ts = [dict objectForKey:@"cycle_ts"];
        NSString* event = [dict objectForKey:@"event"];
        NSString* lat = [dict objectForKey:@"lat"];
        NSString* _long = [dict objectForKey:@"long"];
        NSString* deviceid = [dict objectForKey:@"deviceid"];
        NSString* status = [dict objectForKey:@"status"];
        NSString* created_at = [dict objectForKey:@"created_at"];
        NSString* updated_at = [dict objectForKey:@"updated_at"];

        [eventObj set_id:_id];
        [eventObj setTag_id:tag_id];
        [eventObj setUid:uid];
        [eventObj setCycle_ts:cycle_ts];
        [eventObj setEvent:event];
        [eventObj setLat:lat];
        [eventObj setLongitude:_long];
        [eventObj setDeviceid:deviceid];
        [eventObj setStatus:status];
        [eventObj setCreated_at:created_at];
        [eventObj setUpdated_at:updated_at];

        [output.cycles addObject:eventObj];

    }

    if (sortedRequired) {
        NSArray *sortedArray;
        sortedArray = [output.cycles sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *first = [(SWGEvent*)a created_at];
            NSString *second = [(SWGEvent*)b created_at];
            if (first != nil && second != nil) {
                NSDate *date1 = [dateFormatter dateFromString:first];
                NSDate *date2 = [dateFormatter dateFromString:second];
                if (date1 != nil && date2 != nil) {
                    return [date2 compare:date1];
                }
            }

            return NSOrderedSame;
        }];
        output.cycles = sortedArray;
    }

    return output;
}

+ (NSString*) getEventCode: (NSString*) event {
    if ([event isEqualToString:@"1"]) {
        return @"1/ prod. created";
    } else if ([event isEqualToString:@"2"]) {
        return @"2/ use cycle";
    } else if ([event isEqualToString:@"3"]) {
        return @"3/ ster. cycle";
    } else if ([event isEqualToString:@"4"]) {
        return @"4/ prod. webpage";
    } else if ([event isEqualToString:@"5"]) {
        return @"5/ conn. webpage";
    } else if ([event isEqualToString:@"6"]) {
        return @"6/ order webpage";
    } else if ([event isEqualToString:@"7"]) {
        return @"7/ delete tag";
    }
    return event;
}

+ (NSString*) getStatusCode: (NSString*) status {
    if ([status isEqualToString:@"1"]) {
        return @"1/ ok";
    } else if ([status isEqualToString:@"2"]) {
        return @"2/ outside region";
    } else if ([status isEqualToString:@"3"]) {
        return @"3/ callback";
    } else if ([status isEqualToString:@"4"]) {
        return @"4/ max. use cycles";
    } else if ([status isEqualToString:@"5"]) {
        return @"5/ max. ster. cycles";
    } else if ([status isEqualToString:@"6"]) {
        return @"6/ expired";
    } else if ([status isEqualToString:@"7"]) {
        return @"7/ high use cycles";
    } else if ([status isEqualToString:@"8"]) {
        return @"8/ high ster. cycles";
    } else if ([status isEqualToString:@"9"]) {
        return @"9/ expiration close";
    }
    return status;
}
@end
