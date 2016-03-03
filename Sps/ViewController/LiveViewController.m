//
//  LiveViewController.m
//  Sps
//
//  Created by DDaima on 2/14/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "LiveViewController.h"
#import "PlayerViewController.h"
#import "SetupTableViewController.h"

@interface LiveViewController ()<MGListViewDelegate>{
    MGRawView* week;
    NSMutableArray* array;
    NSDictionary* live_channel;
    NSDictionary* live_vod;
    NSDictionary* live_play;
    NSString* inde ;
}

@end

@implementation LiveViewController
@synthesize list;
@synthesize scrollview;
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [week removeFromSuperview];
    [scrollview addSubview:week];
    scrollview.contentSize = week.frame.size;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    array =[[NSMutableArray alloc] init];
    week = [[MGRawView alloc] initWithFrame:scrollview.frame nibName:@"ViewWeek"];
    [week.segmentAnimation addTarget:self
                              action:@selector(weeksegmentBtnPressed:)
                    forControlEvents:UIControlEventValueChanged];
//    [week.segmentAnimation setSelectedSegmentIndex:weekday];
    
    live_channel = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@",BASE_URL,CHANNEL]] objectForKey:@"channel"];
    live_vod = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@",BASE_URL,VOD]] objectForKey:@"videos"];
    live_play = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@",BASE_URL,LIVE]] objectForKey:@"live_programs"];
    
    for (NSDictionary* dict  in live_channel) {
        [array addObject:dict];
    }
    
    list.delegate = self;
    UIView* header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, 320., 2.);
    header.backgroundColor = THEME_RED;
    list.tableView.tableHeaderView = header;
    list.cellHeight = 95;
    inde =@"Live_chanel";
    [list registerNibName:@"Live_chanel" cellIndentifier:inde];
    [list baseInit];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary* celldata = [array objectAtIndex:indexPath.row];
        
        if ([inde isEqualToString:@"Live_chanel"]){
            [cell setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.85]];
            
            cell.contentView.userInteractionEnabled = false;
            [cell.label3.layer setBorderColor: [UIColor whiteColor].CGColor]  ;
            cell.label3.layer.borderWidth=2.0f;
            cell.label3.backgroundColor=[UIColor clearColor];
            [cell.label1 setText:[NSString stringWithFormat:@"SPS %@",[[celldata valueForKey:@"name"] uppercaseString] ]];
            [cell.label2 setText:[celldata valueForKey:@"live_program"]];
            
            if (indexPath.row == 0) {
                [cell.buttonWatch setTitle:@"ҮНЭГҮЙ ҮЗЭХ" forState:UIControlStateNormal];
            }
            cell.buttonWatch.object =[celldata objectForKey:@"id"];
            [cell.buttonWatch addTarget:self action:@selector(didClickButtonWatch:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        if ([inde isEqualToString:@"Live_vod"]){
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,[celldata valueForKey:@"thumbnail"]]];
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_MEDIA_URL,[celldata valueForKey:@"thumbnail"]]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            
            [cell.imgViewThumb setImage:img];
            [cell.labelHeader1 setText:[celldata valueForKey:@"title"]];
            [cell.labelHeader2  setText:[celldata valueForKey:@"desc"]];
            [cell.labelInfo  setText:@"2 цагийн өмнө"];
            int priceInt = [[celldata valueForKey:@"price"] intValue];
            if ( priceInt == 0)
                [cell.labelStatus  setText:@"ҮНЭГҮЙ"];
            else
                [cell.labelStatus  setText:[NSString stringWithFormat:@"%d",priceInt]];
        }
        else
        if ([inde isEqualToString:@"Live_play"]){
            [cell setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.85]];
            
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *myDate = [df dateFromString: [celldata valueForKey:@"start"]];
            NSDateFormatter *showformat = [[NSDateFormatter alloc] init];
            [showformat setDateFormat:@"HH:mm"];
            
            [cell.label3 setText:[showformat stringFromDate:myDate]];
       
            if ( [[celldata valueForKey:@"channel"] isEqualToString:@"plus"])
                [cell.imgViewIcon setImage:[UIImage imageNamed:@"tv_plus.png"]];
            else
                if ( [[celldata valueForKey:@"channel"] isEqualToString:@"prime"])
                    [cell.imgViewIcon setImage:[UIImage imageNamed:@"tv_prime.png"]];
                else
                    if ( [[celldata valueForKey:@"channel"] isEqualToString:@"action"])
                        [cell.imgViewIcon setImage:[UIImage imageNamed:@"tv_action.png"]];
                    else
                        if ( [[celldata valueForKey:@"channel"] isEqualToString:@"world"])
                            [cell.imgViewIcon setImage:[UIImage imageNamed:@"tv_world.png"]];
                        else
                            if ( [[celldata valueForKey:@"channel"] isEqualToString:@"play"])
                                [cell.imgViewIcon setImage:[UIImage imageNamed:@"tv_play.png"]];
            
            
            [cell.label1 setText:[[[celldata objectForKey:@"teams"] objectAtIndex:0] valueForKey:@"name"]];
            [cell.label2 setText:[[[celldata objectForKey:@"teams"] objectAtIndex:1] valueForKey:@"name"]];
            
            /*
             "name": "UEFA ÐÐ’ÐÐ Ð“Ð£Ð£Ð”Ð«Ð Ð›Ð˜Ð“ Ð‘Ð•ÐÐ¤Ð˜ÐšÐ-Ð—Ð•ÐÐ˜Ð¢ (Ð¨Ð£Ð£Ð”)",
             "day": 2,
             "start": "2016-02-16 03:40:00",
             "duration": "2:00:00",
             "teams": [{
             "name": "Ð‘Ð•ÐÐ¤Ð˜ÐšÐ"
             }, {
             "name": "Ð—Ð•ÐÐ˜Ð¢"
             }],
             "id": 16094,
             "channel": "plus"
             */
            
        }
    }
    
    return cell;
}

-(void)MGListView:(MGListView *)listView scrollViewDidScroll:(UIScrollView *)scrollView {}
-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if ([inde isEqualToString:@"Live_chanel"]){
        NSLog(@"Live_chanel");
        PlayerViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Player"];
        vc.url = [[array objectAtIndex:indexPath.row] objectForKey:@"source"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
        if ([inde isEqualToString:@"Live_vod"]){
            NSLog(@"Live_vod");
            PlayerViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Player"];
//            vc.url = [[array objectAtIndex:indexPath.row] objectForKey:@"source"];
            vc.url = [NSString stringWithFormat:@"%@%@",BASE_W_URL,[[array objectAtIndex:indexPath.row] objectForKey:@"source"]];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
            if ([inde isEqualToString:@"Live_play"]){
                NSLog(@"Live_play");
            }
}

-(IBAction)changeSegment:(UISegmentedControl*)sender{
    
    
    switch ([sender selectedSegmentIndex]) {
        case 0:{
            if (![scrollview isHidden]) {
                scrollview.hidden = true;
                CGRect frame = list.tableView.frame;
                frame.size.height+=35;
                frame.origin.y-=35;
                list.tableView.frame= frame;
            }
            
            list.cellHeight = 95;
            inde =@"Live_chanel";
            [list registerNibName:@"Live_chanel" cellIndentifier:inde];
            [list baseInit];
            [array removeAllObjects];
            for (NSDictionary* dict  in live_channel) {
                [array addObject:dict];
            }
            [list setArrayData:array];
            [list reloadData];
            
        }
            
            break;
        case 2:{
            
            if (![scrollview isHidden]) {
                scrollview.hidden = true;
                CGRect frame = list.tableView.frame;
                frame.size.height+=35;
                frame.origin.y-=35;
                list.tableView.frame= frame;
            }

            list.cellHeight = 120;
            inde =@"Live_vod";
            
            [list registerNibName:@"Live_vod" cellIndentifier:inde];
            [list baseInit];
            [array removeAllObjects];
            for (NSDictionary* dict  in live_vod) {
                [array addObject:dict];
            }
            [list setArrayData:array];
            [list reloadData];

            
        }
            
            break;
        case 1:{
            scrollview.hidden = false;
            CGRect frame = list.tableView.frame;
            frame.size.height-=35;
            frame.origin.y+=35;
            list.tableView.frame= frame;
            
            list.cellHeight = 90;
            inde =@"Live_play";
            [list registerNibName:@"Live_play" cellIndentifier:inde];
            [list baseInit];
            [self getArrayofDay:1];
            [list setArrayData:array];
            [list reloadData];
        }
            
            break;
            
        default:
            break;
    }
}

-(void)getArrayofDay:(NSInteger) dayNum{
    [array removeAllObjects];
    
    for (NSDictionary* dict  in live_play) {
        if ([[dict valueForKey:@"day"] integerValue] == dayNum && [[dict allKeys] containsObject:@"teams"])
            [array addObject:dict];
    }
    
}

-(void)weeksegmentBtnPressed:(UISegmentedControl*)sender{
    NSLog(@"change week %d",(int)([sender selectedSegmentIndex]+1));
    
    [self getArrayofDay:[sender selectedSegmentIndex]+1];
    [list setArrayData:array];
    [list reloadData];
    
}

-(void)didClickButtonWatch:(MGButton*)sender{
    NSLog(@"click %@", [[sender object] stringValue]);
}


@end
