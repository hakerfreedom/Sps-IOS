//
//  ProfileViewController.m
//  Sps
//
//  Created by DDaima on 2/5/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "ProfileTableViewController.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController
@synthesize live;
@synthesize channel;
@synthesize vod;
@synthesize team;


- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.tableView setBackgroundView:boxBackView];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(60, 0, 0, 0)];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    long rnumber = indexPath.row;
    switch (rnumber) {
        case 1:
            NSLog(@"not off");
            break;
        case 2:
            NSLog(@"change sec");
            break;
        case 3:
            NSLog(@"choice bag");
            break;
        case 0:
            NSLog(@"facebook");
            break;
        default:
            break;
    }
}
-(IBAction)addVod:(id)sender{
    NSLog(@"asdasd");
}
-(IBAction)addChannel:(id)sender{
    NSLog(@"asdasd");
}
-(IBAction)addTeam:(id)sender{
    NSLog(@"asdasd");
}
-(IBAction)addLive:(id)sender{
    NSLog(@"asdasd");
}


@end
