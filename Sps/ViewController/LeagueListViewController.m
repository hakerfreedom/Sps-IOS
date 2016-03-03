//
//  LeagueListViewController.m
//  Sps
//
//  Created by DDaima on 2/9/16.
//  Copyright © 2016 DDaima. All rights reserved.
//


#import "LeagueListViewController.h"
#import "League.h"
#import "TeamCollectionViewController.h"
//#import "AFHTTPClient.h"
//#import "AFJSONRequestOperation.h"
//#import "UIImageView+AFNetworking.h"


@interface LeagueListViewController ()<MGListViewDelegate>

@end

@implementation LeagueListViewController
@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSDictionary* dict = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@",BASE_URL,LEAGUES]] valueForKey:@"leagues"];
    
    for(NSDictionary* dictleg in dict){

        League* tmp = [[League alloc] init];
        
        tmp.l_id = [dictleg valueForKey:@"id"];
        tmp.name = [dictleg valueForKey:@"name"];
        tmp.logo = [dictleg valueForKey:@"logo"];
        [array addObject:tmp];
    }
    list.delegate = self;
    list.cellHeight = 125;
    [list registerNibName:@"Leg_cell" cellIndentifier:@"Leg_cell"];
    [list baseInit];
    [list setArrayData:array];
    [list reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UITableViewCell*)MGListView:(MGListView *)listView1 didCreateCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(cell != nil) {
        League* leg = [list.arrayData objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.label1 setText:leg.name];
        [cell setBackgroundColor:[UIColor blackColor]];
        [cell setAlpha:0.7];
        
        [self setImage:leg.logo imageView:cell.imgViewThumb];
        
    }
    
    return cell;
}

-(void)MGListView:(MGListView *)listView scrollViewDidScroll:(UIScrollView *)scrollView {}
-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
        League* leg = [list.arrayData objectAtIndex:indexPath.row];
        TeamCollectionViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"teams"];
        vc.l_id = leg.l_id;
    
        [self.navigationController pushViewController:vc animated:YES];
}

-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView {
    
    
    NSString* img_url =[NSString stringWithFormat:@"%@%@",BASE_URL,imageUrl];
//    NSLog(@"    img_url - %@",img_url);
    __weak typeof(imgView ) weakImgRef = imgView;
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,NSURL* url) {
        if (image && cacheType == SDImageCacheTypeNone)
        {
            
            CGSize size = weakImgRef.frame.size;
            if([MGUtilities isRetinaDisplay]) {
                size.height *= 2;
                size.width *= 2;
            }
            
            if(IS_IPHONE_6_PLUS_AND_ABOVE) {
                size.height *= 3;
                size.width *= 3;
            }
            
            UIImage* croppedImage = [image imageByScalingAndCroppingForSize:size];
            weakImgRef.image = croppedImage;
            
            
            imgView.alpha = 0.0;
            [UIView animateWithDuration:.2
                             animations:^{
                                 imgView.alpha = 1.0;
                             }];
        }
    }];
}

-(IBAction)save:(id)sender{
    NSMutableArray* saveTeam = [TmpData getFav_ids];
    
    NSMutableArray* teams=[[NSMutableArray alloc ] init];
    NSMutableDictionary * team =[[NSMutableDictionary alloc] init];
    for (int i=0; i<saveTeam.count; i++) {
        [team setValue:[[saveTeam objectAtIndex:i] stringValue] forKey:@"id"];
        [teams addObject:[team copy]];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Хадгалж байна ....";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SAVE_TEAM]];
    NSString* urlstr = [NSString stringWithFormat:@"%@%@",BASE_URL,SAVE_TEAM];
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDictionary *comData = [NSDictionary dictionaryWithObjectsAndKeys:
                             [preferences stringForKey:USER_ID], @"user_id",
                             teams, @"teams",
                             nil];
    NSDictionary *com = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"select_teams", @"command",
                         comData
                         , @"data",
                         nil];
//    NSLog(@"%@",com);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlstr parameters:com
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError* error;
         
         NSString *responseString = [operation responseString];
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:kNilOptions
                                                                error:&error];
//         NSLog(@"POST_RATING_SYNC = %@", responseString);
         [hud removeFromSuperview];
         NSString *msg = [json valueForKey:@"message"];
         [TmpData set:[json objectForKey:@"teams"]];
         [MGUtilities showAlertTitle:@"Сонордуулга"
                             message:[NSString stringWithFormat:@"%@",msg]];

         
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
