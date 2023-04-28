//
//  NFCHelper.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 15.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "NFCHelper.h"

@interface NFCHelper() {
    BOOL nfc_session_started;
    NFCNDEFReaderSession *session;
    NSString *_results;
}
@end

@implementation NFCHelper

+(NFCHelper*) sharedObject {
    static NFCHelper* sharedObject;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
        [sharedObject setUpDefaultValues];
    });

    return sharedObject;
}

- (void) setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

-(void) setUpDefaultValues {
    nfc_session_started = NO;
    _results = @"";
    session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_get_main_queue() invalidateAfterFirstRead:NO];
}

-(BOOL) isSessionRunning {
    return nfc_session_started;
}

-(void) startSession {
    if (!nfc_session_started) {
        [self setUpDefaultValues];
        nfc_session_started = YES;
        _results = @"";
        if (delegate != nil) {
            [delegate nfcSessionStarted];
        }
        [session beginSession];
    } else if (delegate != nil) {
        [delegate nfcSessionStartFailed];
    }
}

-(void) stopSession {
    if (nfc_session_started && session != nil) {
        nfc_session_started = NO;
        _results = @"";
        if (delegate != nil) {
            [delegate nfcSessionStopped];
        }
        [session invalidateSession];
    } else if (delegate != nil) {
        [delegate nfcSessionStopFailed];
    }
}
- (void)readerSession:(nonnull NFCNDEFReaderSession *)session didInvalidateWithError:(nonnull NSError *)error {
    NSLog(@"NFCHelper didInvalidateWithError %@", error.description);

    if (error != nil && error.code == 200) {
        [self stopSession]; // user stopped the session
    } else if (error != nil && error.code == 201) {
        [self stopSession]; // timeout error
    } else {
        if (delegate != nil) {
            [delegate nfcReadError];
        }
    }
}

- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didDetectNDEFs:(nonnull NSArray<NFCNDEFMessage *> *)messages {

    BOOL readDone = NO;
    for (NFCNDEFMessage *message in messages) {
        for (NFCNDEFPayload *payload in message.records) {
            NSLog(@"NFCHelper identifier = %@",payload.identifier);
            id parsedPayload = [VYNFCNDEFPayloadParser parse:payload];
            if (parsedPayload) {
                NSString *text = @"";
                NSString *urlString = nil;
                if ([parsedPayload isKindOfClass:[VYNFCNDEFTextPayload class]]) {
                    text = ((VYNFCNDEFTextPayload *)parsedPayload).text;
                } else if ([parsedPayload isKindOfClass:[VYNFCNDEFURIPayload class]]) {
                    text = @"[URI payload]\n";
                    text = [NSString stringWithFormat:@"%@%@", text, ((VYNFCNDEFURIPayload *)parsedPayload).URIString];
                    urlString = ((VYNFCNDEFURIPayload *)parsedPayload).URIString;
                } else if ([parsedPayload isKindOfClass:[VYNFCNDEFTextXVCardPayload class]]) {
                    text = @"[TextXVCard payload]\n";
                    text = [NSString stringWithFormat:@"%@%@", text, ((VYNFCNDEFTextXVCardPayload *)parsedPayload).text];
                } else if ([parsedPayload isKindOfClass:[VYNFCNDEFSmartPosterPayload class]]) {
                    text = @"[SmartPoster payload]\n";
                    VYNFCNDEFSmartPosterPayload *sp = parsedPayload;
                    for (VYNFCNDEFTextPayload *textPayload in sp.payloadTexts) {
                        text = [NSString stringWithFormat:@"%@%@\n", text, textPayload.text];
                    }
                    text = [NSString stringWithFormat:@"%@%@", text, sp.payloadURI.URIString];
                    urlString = sp.payloadURI.URIString;
                } else if ([parsedPayload isKindOfClass:[VYNFCNDEFWifiSimpleConfigPayload class]]) {
                    text = @"[WifiSimpleConfig payload]\n";
                    VYNFCNDEFWifiSimpleConfigPayload *wifi = parsedPayload;
                    for (VYNFCNDEFWifiSimpleConfigCredential *credential in wifi.credentials) {
                        text = [NSString stringWithFormat:@"%@SSID: %@\nPassword: %@\nMac Address: %@\nAuth Type: %@\nEncrypt Type: %@",
                                text, credential.ssid, credential.networkKey, credential.macAddress,
                                [VYNFCNDEFWifiSimpleConfigCredential authTypeString:credential.authType],
                                [VYNFCNDEFWifiSimpleConfigCredential encryptTypeString:credential.encryptType]];
                    }
                    if (wifi.version2) {
                        text = [NSString stringWithFormat:@"%@\nVersion2: %@",
                                text, wifi.version2.version];
                    }
                } else {
                    text = @"Parsed but unhandled payload type";
                }
                NSLog(@"NFCHelper result text = %@", text);
                _results = [NSString stringWithFormat:@"%@", text];
                if (delegate != nil) {
                    readDone = YES;
                    [delegate nfcReadData:_results];
                }
                _results = @"";
            }
        }
    }

    if (delegate != nil && !readDone) {
        [delegate nfcReadData:@""];
    }
}
@end
