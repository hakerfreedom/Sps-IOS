//
//  SignupViewController.h
//  Sps
//
//  Created by DDaima on 2/4/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField* mail;
@property (nonatomic, retain) IBOutlet UITextField* pass;
@property (nonatomic, retain) IBOutlet UITextField* apass;
@property (nonatomic,retain) IBOutlet UIButton *btn;

-(IBAction)didClickSignup:(id)sender;
@end
