//
//  ViewController.h
//  Sps
//
//  Created by DDaima on 2/2/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigninViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField* mail;
@property (nonatomic, retain) IBOutlet UITextField* pass;
@property (nonatomic,retain) IBOutlet UIButton *btn;

-(IBAction)didClickLogin:(id)sender;
@end

