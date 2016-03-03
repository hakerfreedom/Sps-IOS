//
//  LoginViewController.h
//  Sps
//
//  Created by DDaima on 2/2/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MaterialControls/MDButton.h>

@interface FirstViewController : UIViewController


@property (nonatomic,retain) IBOutlet MDButton *btn;
@property (nonatomic,retain) IBOutlet UIButton *btn1;

-(IBAction)didClickLogin:(id)sender;
-(IBAction)didClickSignup:(id)sender;

@end
