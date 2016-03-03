//
//  HomeViewController.m
//  Sps
//
//  Created by DDaima on 2/4/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()<MGListViewDelegate>{
    
    MGRawView* _raw;
}
@end

@implementation HomeViewController
@synthesize header;
@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _raw= [[MGRawView alloc] initWithFrame:header.frame nibName:@"header_tab"];
    [_raw.buttonNext addTarget:self action:@selector(didClickButtonSetup:) forControlEvents:UIControlEventTouchUpInside];
    [_raw.buttonFave addTarget:self action:@selector(didClickButtonProfile:) forControlEvents:UIControlEventTouchUpInside];

    
    BOOL screen = IS_IPHONE_6_PLUS_AND_ABOVE;
    if(screen) {
        CGRect frame = _raw.frame;
        frame.size.width = self.view.frame.size.width;
        _raw.frame = frame;
        
//        frame = list.frame;
//        frame.origin.y = slider.frame.origin.y + slider.frame.size.height;
//        frame.size.height = self.view.frame.size.height - slider.frame.size.height-64;
//        listViewNews.frame = frame;
/*
 odo yu ghiig chin bi helhuu ntr hehe yu hijn
 */
        
    }
    [header addSubview:_raw];
    
    NSDictionary* dict= [TmpData get];

//
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSMutableArray* tmpdata = [[NSMutableArray alloc] init];
    
    for(NSDictionary* dictTeam in dict){
        
        NSString* className = NSStringFromClass([Fav_team class]);
        NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
        Fav_team* tmp = (Fav_team*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        
        tmp.fteam_leg=[dictTeam valueForKey:@"league"];
        tmp.fteam_name=[dictTeam valueForKey:@"name"];
        tmp.fteam_logo=[dictTeam valueForKey:@"logo"];
        
        [tmpdata addObject:[dictTeam valueForKey:@"id"]];
        [array addObject:tmp];
    }
    [TmpData setFav_ids:tmpdata];
    
    /*
     
     AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
     NSManagedObjectContext* context = delegate.managedObjectContext;
     
     NSMutableArray* array = [[NSMutableArray alloc] init];
     
     for (int i=0;i<5; i++ ) {
     
     
     NSString* className = NSStringFromClass([Fav_team class]);
     NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
     Fav_team* tmp = (Fav_team*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
     
     tmp.fteam_leg=[NSString stringWithFormat:@"leg%d",i];
     tmp.fteam_name=[NSString stringWithFormat:@"name%d",i];
     tmp.fteam_logo=[NSString stringWithFormat:@"img%d",i];
     [array addObject:tmp];
     }
     */
    list.delegate = self;
    
    list.cellHeight = screen ? 150 : 125;
    [list registerNibName:@"Fav_team_cell" cellIndentifier:@"Fav_team_cell"];
    [list baseInit];
//    [list setArrayData:[NSMutableArray arrayWithArray:[CoreDataController getFTeam]]];
        [list setArrayData:array];
    [list reloadData];
    
    
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
-(UITableViewCell*)MGListView:(MGListView *)listView1 didCreateCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(cell != nil) {
        Fav_team* team = [list.arrayData objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.selectedColor = THEME_ORANGE_COLOR;
//        cell.unSelectedColor = THEME_ORANGE_COLOR;
        
        [cell.labelHeader1 setText:team.fteam_name];
        [cell.labelHeader2 setText:team.fteam_leg];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if(team.fteam_logo != nil)
            [self setImage:team.fteam_logo imageView:cell.imgViewThumb];
        else
            [self setImage:nil imageView:cell.imgViewThumb];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = cell.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
        [gradient setStartPoint:CGPointMake(1,0)];
        [gradient setEndPoint:CGPointMake(0,0)];
        [cell.layer insertSublayer:gradient atIndex:1];
    }
    
    return cell;
}

-(void)MGListView:(MGListView *)listView scrollViewDidScroll:(UIScrollView *)scrollView {}
-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
//    News* news = [listViewNews.arrayData objectAtIndex:indexPath.row];
//    
//    NewsDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNewsDetail"];
//    vc.strUrl = news.news_url;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView {
    
    
    NSString* img_url =[NSString stringWithFormat:@"%@%@",BASE_URL,imageUrl];
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

-(void)didClickButtonSetup:(id)sender {
    SetupTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Setup"];
    
    vc.simpleBlock =^{
        NSLog(@"sadad");
    };
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickButtonProfile:(id)sender {
    ProfileTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
