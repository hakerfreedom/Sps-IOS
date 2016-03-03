//
//  LoginViewController.m
//  Sps
//
//  Created by DDaima on 2/2/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "FirstViewController.h"
#import "SignupViewController.h"
#import "SigninViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize btn;
@synthesize btn1;

- (void)viewDidLoad {
    [super viewDidLoad];
    btn.layer.cornerRadius = 8;
    btn1.layer.cornerRadius = 8;
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
-(IBAction)didClickLogin:(id)sender{
    SigninViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Signin"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)didClickSignup:(id)sender{
    SignupViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Signup"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
