//
//  AlertUtil.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^WarningBlock_t)(void);
typedef void (^CancelBlock_t)(void);
typedef void (^SuccessBlock_t)(void);
typedef void (^OrderReplacementBlock_t)(void);
typedef void (^ContinueUsing_t)(void);

typedef void (^PositiveBlock_t)(void);
typedef void (^NegativeBlock_t)(void);

@interface AlertUtil : NSObject
    + (void) showAlertWithTitle:(NSString*) title message:(NSString*) msg completionHandler:(void (^)(void)) handler ;
+ (void) showAlertWithTitle:(NSString*) title message:(NSString*) msg positiveBlock:(PositiveBlock_t) positiveBlock negativeBlock:(NegativeBlock_t) negativeBlock;

+ (void) showAlert2WithCompletionHandler:(void (^)(void)) handler;
+ (void) showAlert3WithCompletionHandler:(void (^)(void)) handler;

+ (void) showAlert45WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock steriliCycles:(NSString*) sterilizationCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning;
+ (void) showAlert45WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock useCycles:(NSString*) useCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning;

+ (void) showAlert6WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock validityData:(NSString*) validDate justWarning:(BOOL) isJustWarning;

+ (void) showAlert78WithCompletionHandler:(WarningBlock_t)warningHandler OrderReplacementBlock:(OrderReplacementBlock_t) orderBlock ContinueUsingBlock:(ContinueUsing_t) continueUsingBlock useCycles:(NSString*) useCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning;
+ (void) showAlert78WithCompletionHandler:(WarningBlock_t)warningHandler OrderReplacementBlock:(OrderReplacementBlock_t) orderBlock ContinueUsingBlock:(ContinueUsing_t) continueUsingBlock sterCycles:(NSString*) sterCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning;

+ (void) showAlert9WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock validityData:(NSString*) validDate justWarning:(BOOL) isJustWarning;
@end

NS_ASSUME_NONNULL_END
