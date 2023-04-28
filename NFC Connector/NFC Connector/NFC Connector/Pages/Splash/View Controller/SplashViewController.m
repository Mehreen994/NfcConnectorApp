//
//  SplashViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 13.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "SplashViewController.h"
#import "CBZSplashView.h"
#import <AVFoundation/AVFoundation.h>

@interface SplashViewController () {
    AnimationView *loader;
    AVPlayer *_avPlayer;
    AVPlayerLayer* playerLayer;
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.appVersionLabel.text = [NSString stringWithFormat:@"App Version %@", appVersionString];

    [self playFile];
    
}

- (void) loadAnimation {
   CGRect device = [UIScreen mainScreen].bounds;
    loader = [[AnimationView alloc] initWithFrame:CGRectMake(0, 200, device.size.width, device.size.height)];
    [loader loadAnimationWithName:@"data"];
    [loader setLoop:YES];
    [loader playWithCompletion:nil];
    [self.animationView addSubview:loader];
}

- (void) gotoStartViewController {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->loader stop];
        [self performSegueWithIdentifier:@"gotoStart" sender:nil];
    });


}

-(void) playFile {
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource:@"test" withExtension:@"m4v"];

    // Create the player and add it to the playerView
    _avPlayer = [AVPlayer playerWithURL:videoURL];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_avPlayer currentItem]];
    playerLayer.frame = self.view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.needsDisplayOnBoundsChange = YES;
    [self.view.layer addSublayer:playerLayer];
    [_avPlayer play];
}

- (IBAction)playerItemDidReachEnd:(id)sender {
    NSLog(@"---- playerItemDidReachEnd ----");
    [playerLayer removeFromSuperlayer];
    [self performSelector:@selector(gotoStartViewController) withObject:nil afterDelay:3.5f];
    [UIView animateWithDuration:2.0 animations:^{
        self.animationView.alpha = 0.0f;
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
