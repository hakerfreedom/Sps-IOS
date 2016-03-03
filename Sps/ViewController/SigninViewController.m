//
//  ViewController.m
//  Sps
//
//  Created by DDaima on 2/2/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "SigninViewController.h"
#import "TabBarController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController
@synthesize mail;
@synthesize pass;
@synthesize btn;

- (void)viewDidLoad {
    [super viewDidLoad];
        btn.layer.cornerRadius = 8;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickLogin:(id)sender{
    
//    TabBarController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
//    [self presentViewController:vc animated:YES completion:nil];
//    
//    return;

    NSString* email = [mail text];
    NSString* password = [pass text];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Нэвтэрч байна ....";
    
    NSDictionary *comData = [NSDictionary dictionaryWithObjectsAndKeys:
                             email, @"email",
                             password, @"pass",
                             nil];
    NSDictionary *com = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"login", @"command",
                         comData, @"data",
                         nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* urlstr = [NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_URl];
//    NSURL *url = [NSURL URLWithString:BASE_URL];
    
    [manager POST:urlstr parameters:com
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError* error;
         NSString *responseString = [operation responseString];
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:kNilOptions
                                                                error:&error];
//         NSLog(@"POST_RATING_SYNC = %@", responseString);
         
         if([[json valueForKey:@"error"] boolValue] ) {
             [hud removeFromSuperview];
             NSString *msg = [json valueForKey:@"message"];
             [MGUtilities showAlertTitle:@"Алдаа"
                                 message:[NSString stringWithFormat:@"%@",msg]];
             
         }
         else{
             [hud removeFromSuperview];
             
             
             
             NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
             NSDictionary* data = [json objectForKey:@"data"];
             NSDictionary* user = [data objectForKey:@"user"];
             
             [preferences setObject:[user valueForKey:@"id"] forKey:USER_ID];
             [preferences setObject:[user valueForKey:@"email"] forKey:USER_EMAIL];
             [preferences setObject:[user valueForKey:@"pass"] forKey:USER_PASS];
             [preferences setBool:TRUE forKey:IS_LOGGED];
             
             NSLog(@"OK user id = %ld, user email = %@",(long)[preferences integerForKey:USER_ID],[preferences stringForKey:USER_EMAIL]);
             
             //            [DataParser fetchFavTeamData:[data objectForKey:@"teams"] ];
             [TmpData set:[data objectForKey:@"teams"]];
             [TmpData setLimit:[[user valueForKey:@"team_limit"] intValue]];
             TabBarController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
             [self presentViewController:vc animated:YES completion:nil];
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
