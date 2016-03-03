//
//  LeagueListViewController.h
//  Sps
//
//  Created by DDaima on 2/9/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeagueListViewController : UIViewController

@property (nonatomic, retain) IBOutlet MGListView* list;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* saveItem;

-(IBAction)save:(id)sender;

@end
