//
//  PlayerViewController.m
//  Sps
//
//  Created by DDaima on 2/17/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property AVPlayerViewController *avPlayerViewcontroller;

@end

@implementation PlayerViewController
@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = self.view;
    
    
    NSURL *fileURL = [NSURL URLWithString:url];
    
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    
    playerViewController.player = [AVPlayer playerWithURL:fileURL];
    
    self.avPlayerViewcontroller = playerViewController;
    
    [self resizePlayerToViewSize];
    
    [view addSubview:playerViewController.view];
    
    view.autoresizesSubviews = TRUE;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) resizePlayerToViewSize
{
    CGRect frame = self.view.frame;
    
    NSLog(@"frame size %d, %d", (int)frame.size.width, (int)frame.size.height);
    
    self.avPlayerViewcontroller.view.frame = frame;
}

@end
