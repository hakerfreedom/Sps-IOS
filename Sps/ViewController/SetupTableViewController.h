//
//  SetupTableViewController.h
//  Sps
//
//  Created by DDaima on 2/6/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupTableViewController : UITableViewController

@property (nonatomic,copy) void (^simpleBlock)(void);
- (IBAction)switchAction:(id)sender;

@end
