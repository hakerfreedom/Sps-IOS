//
//  SetupTableViewController.m
//  Sps
//
//  Created by DDaima on 2/6/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "SetupTableViewController.h"

@interface SetupTableViewController ()

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.tableView setBackgroundView:boxBackView];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(120, 0, 0, 0)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchAction:(id)sender{
    NSLog(@"on/off");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
            
        case 3:{
            LeagueListViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"League"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }

            break;
            
        case 4:
                        NSLog(@"facebook");
            break;
            
        case 5:
                        NSLog(@"logout");
            break;
            
        default:
            break;
    }

}

@end
