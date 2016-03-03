//
//  ProfileViewController.h
//  Sps
//
//  Created by DDaima on 2/5/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewController : UITableViewController

@property (nonatomic,retain) IBOutlet UILabel * vod;
@property (nonatomic,retain) IBOutlet UILabel * channel;
@property (nonatomic,retain) IBOutlet UILabel * live;
@property (nonatomic,retain) IBOutlet UILabel * team;

-(IBAction)addVod:(id)sender;
-(IBAction)addChannel:(id)sender;
-(IBAction)addTeam:(id)sender;
-(IBAction)addLive:(id)sender;

@end
