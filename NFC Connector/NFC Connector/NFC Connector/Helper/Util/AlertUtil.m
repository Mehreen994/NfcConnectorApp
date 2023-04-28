//
//  AlertUtil.m
//  NFC Connector
//
//  Created by Mehreen Kanwal on 19.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "AlertUtil.h"
#import "ViewControllerHelper.h"

@implementation AlertUtil




+ (void) showAlertWithTitle:(NSString*) title message:(NSString*) msg completionHandler:(void (^)(void)) handler {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {handler();}];

        [alert addAction:defaultAction];
        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlertWithTitle:(NSString*) title message:(NSString*) msg positiveBlock:(PositiveBlock_t) positiveBlock negativeBlock:(NegativeBlock_t) negativeBlock {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {negativeBlock();}];

        [alert addAction:defaultAction];

        UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"I'm aware of the risks, use anyway" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {positiveBlock();}];

        [alert addAction:defaultAction1];
        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark Alert Types

+ (void) showAlert2WithCompletionHandler:(void (^)(void)) handler {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"OUTSIDE APPROVED REGION"
                                                                       message:@"This product is outside its approved region, please use approved product or contact your dealer for further instructions"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {handler();}];

        [alert addAction:defaultAction];
        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

// In any case goback on completion
+ (void) showAlert3WithCompletionHandler:(void (^)(void)) handler {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"PRODUCT CALLBACK"
                                                                       message:@"The use of this product might not be safe, please contact your local dealer for replacement"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {handler();}];

        [alert addAction:defaultAction];
        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert45WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock steriliCycles:(NSString*) sterilizationCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"MAXIMUM NUMBER OF STERILIZATION CYCLES"
                                                                       message:[NSString stringWithFormat:@"This product has %@ recorded sterilization cycles of %@ approved sterilization cycles. Please order replacement, product use not safe", sterilizationCycles, totalCycles]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningBlock();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {cancelHandler();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"I'm aware of the risks, use anyway" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {successBlock();}];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert45WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock useCycles:(NSString*) useCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"MAXIMUM NUMBER OF USE CYCLES"
                                                                       message:[NSString stringWithFormat:@"This product has %@ recorded use cycles of %@ approved use cycles. Please order replacement, product use not safe", useCycles, totalCycles]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningBlock();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {cancelHandler();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"I'm aware of the risks, use anyway" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {successBlock();}];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert6WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock validityData:(NSString*) validDate justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"PRODUCT EXPIRED"
                                                                       message:[NSString stringWithFormat:@"This product has expired - latest approved used date %@ ! Please Order Replacement, product use not safe", validDate]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningBlock();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {cancelHandler();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"I'm aware of the risks, use anyway" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {successBlock();}];

            [defaultAction1 setValue:UIColor.redColor forKey:@"titleTextColor"];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert78WithCompletionHandler:(WarningBlock_t)warningHandler OrderReplacementBlock:(OrderReplacementBlock_t) orderBlock ContinueUsingBlock:(ContinueUsing_t) continueUsingBlock useCycles:(NSString*) useCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ORDER REPLACEMENT"
                                                                       message:[NSString stringWithFormat:@"This product has %@ recorded use cycles of %@ approved use cycles. Want to order replacement?", useCycles, totalCycles]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningHandler();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Order Replacement" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {orderBlock();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"Continue Using" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {continueUsingBlock();}];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert78WithCompletionHandler:(WarningBlock_t)warningHandler OrderReplacementBlock:(OrderReplacementBlock_t) orderBlock ContinueUsingBlock:(ContinueUsing_t) continueUsingBlock sterCycles:(NSString*) sterCycles totalCycles:(NSString*) totalCycles justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ORDER REPLACEMENT"
                                                                       message:[NSString stringWithFormat:@"This product has %@ recorded sterilization cycles of %@ approved sterilization cycles. Want to order replacement?", sterCycles, totalCycles]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningHandler();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Order Replacement" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {orderBlock();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"Continue Using" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {continueUsingBlock();}];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}

+ (void) showAlert9WithCompletionHandler:(CancelBlock_t)cancelHandler SuccessBlock:(SuccessBlock_t) successBlock WarningBlock:(WarningBlock_t) warningBlock validityData:(NSString*) validDate justWarning:(BOOL) isJustWarning {
    UINavigationController* navigation = [ViewControllerHelper getNavigationController];
    if (navigation != nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"PRODUCT EXPIRED"
                                                                       message:[NSString stringWithFormat:@"This product has expired - latest approved used date %@ ! Please Order Replacement, product use not safe!", validDate]
                                                                preferredStyle:UIAlertControllerStyleAlert];

        if (isJustWarning) {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {warningBlock();}];

            [alert addAction:defaultAction];
        } else {
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {cancelHandler();}];

            [alert addAction:defaultAction];

            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"I'm aware of the risks, use anyway" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {successBlock();}];

            [defaultAction1 setValue:UIColor.redColor forKey:@"titleTextColor"];

            [alert addAction:defaultAction1];
        }

        [navigation presentViewController:alert animated:YES completion:nil];
    }
}
@end
