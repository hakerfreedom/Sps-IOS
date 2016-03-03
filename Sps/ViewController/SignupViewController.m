//
//  SignupViewController.m
//  Sps
//
//  Created by DDaima on 2/4/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize mail;
@synthesize pass;
@synthesize apass;
@synthesize btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    btn.layer.cornerRadius = 8;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickSignup:(id)sender{

    NSString* email = [mail text];
    NSString* password = [pass text];
    NSString* apassword = [apass text];
    
    if (![password isEqualToString:apassword])
    {
        [MGUtilities showAlertTitle:@"Алдаа"
                            message:@"Нууц үг баталгаагүй байна."];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Бүртгүүлж байна ....";
    
    NSURL *url = [NSURL URLWithString:BASE_URL];
    
    
    
    NSDictionary *comData = [NSDictionary dictionaryWithObjectsAndKeys:
                             email, @"email",
                             password, @"pass",
                             nil];
    NSDictionary *com = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"register", @"command",
                         comData, @"data",
                         nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* urlstr = [NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_URl];
    [manager POST:urlstr parameters:com
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSError* error;
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                              options:kNilOptions
                                                                error:&error];
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"POST_RATING_SYNC = %@", responseStr);
         NSString *msg = [json valueForKey:@"message"];
         if([[json valueForKey:@"error"] boolValue] ) {
             [hud removeFromSuperview];
             [MGUtilities showAlertTitle:@"Алдаа"
                                 message:[NSString stringWithFormat:@"%@",msg]];
         }
         else{
             [hud removeFromSuperview];
             [MGUtilities showAlertTitle:@"Мэдээлэл"
                                 message:[NSString stringWithFormat:@"%@",msg]];
             [self.navigationController popViewControllerAnimated:YES];
         }
         
         
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
         [hud removeFromSuperview];
         [MGUtilities showAlertTitle:@"Алдаа"
                             message:@"Холболтын алдаа!!!!!"];
         
     }];
    
}
@end
