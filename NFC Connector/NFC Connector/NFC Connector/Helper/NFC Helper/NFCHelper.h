//
//  NFCHelper.h
//  NFC Connector
//
//  Created by Mehreen Kanwal on 15.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreNFC/CoreNFC.h>
#import "VYNFCKit.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NFCHelperProtocol

-(void) nfcSessionStarted;
-(void) nfcSessionStartFailed;
-(void) nfcSessionStopped;
-(void) nfcSessionStopFailed;
-(void) nfcReadError;
-(void) nfcReadData:(NSString*) data;

@end
@interface NFCHelper : NSObject <NFCNDEFReaderSessionDelegate> {
    id delegate;
}
    +(NFCHelper*) sharedObject;
    - (void) setDelegate:(id)newDelegate;

-(void) startSession;
-(void) stopSession;
-(BOOL) isSessionRunning;

@end

#define NFCHELPER NFCHelper.sharedObject

NS_ASSUME_NONNULL_END
