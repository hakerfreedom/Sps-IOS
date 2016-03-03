//
//  LiveViewController.h
//  Sps
//
//  Created by DDaima on 2/14/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController

@property (nonatomic, retain) IBOutlet MGListView* list;
@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollview;

-(IBAction)changeSegment:(id)sender;


@end
