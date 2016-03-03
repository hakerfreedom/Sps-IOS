//
//  ProgramViewController.h
//  Sps
//
//  Created by DDaima on 2/13/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramViewController : UIViewController{
    MGRawView* week;
    NSDictionary* data;
    NSMutableDictionary* name_index;
    NSMutableArray* program;
    NSInteger weekday;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollview;
@property (nonatomic, retain) IBOutlet MGListView* list;

-(IBAction)chanelsegmentBtnPressed:(UISegmentedControl*)sender;

@end
