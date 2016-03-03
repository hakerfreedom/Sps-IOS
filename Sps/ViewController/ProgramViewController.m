//
//  ProgramViewController.m
//  Sps
//
//  Created by DDaima on 2/13/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "ProgramViewController.h"

@interface ProgramViewController ()<MGListViewDelegate>

@end

@implementation ProgramViewController
@synthesize list;
@synthesize scrollview;

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    [week removeFromSuperview];
    [scrollview addSubview:week];
    scrollview.contentSize = week.frame.size;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    weekday = [component weekday]-2;
    
    if (weekday == -1 )
        weekday = 6;
    NSLog(@"%d",(int)weekday);
    
    
    week = [[MGRawView alloc] initWithFrame:scrollview.frame nibName:@"ViewWeek"];
    

    [week.segmentAnimation addTarget:self
                         action:@selector(weeksegmentBtnPressed:)
               forControlEvents:UIControlEventValueChanged];
    [week.segmentAnimation setSelectedSegmentIndex:weekday];

    
    data = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@",BASE_URL,PROGRAM]] objectForKey:@"channel"];
//    name_index = [[NSMutableDictionary alloc] init];
//    for (NSDictionary* chanel in data){
//        
////          NSLog(@"%@",chanel);
//        
//        NSString* name = [[chanel objectForKey:@"name"]  uppercaseString];
//        NSString* ch_id = [chanel valueForKey:@"id"]  ;
//        NSLog(@"%@ %@",name,ch_id);
//        [name_index setObject: ch_id forKey:name];
//    }
    
    
    list.delegate = self;
    list.cellHeight = 35;
    [list registerNibName:@"Program_cell" cellIndentifier:@"Program_cell"];
    [list baseInit];
    
    for (NSDictionary* chanel in data) {
        if ([[[chanel valueForKey:@"name"] uppercaseString] isEqualToString:@"PRIME"]){
            program = [chanel objectForKey:@"programs"];
            NSMutableArray  *tmparray= [[NSMutableArray alloc] init];
            for (NSDictionary* one in program ) {
                NSLog(@"%@",[one valueForKey:@"day"]);
                if ([[one valueForKey:@"day"] integerValue] == weekday){
                    [tmparray addObject:one];
                }
            }
            [list setArrayData:tmparray];
            [list reloadData];
            break;
        }
    }
    
}


-(UITableViewCell*)MGListView:(MGListView *)listView1 didCreateCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(cell != nil) {
        NSDictionary* one = [list.arrayData objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *myDate = [df dateFromString: [one valueForKey:@"start"]];
        NSDateFormatter *showformat = [[NSDateFormatter alloc] init];
        [showformat setDateFormat:@"HH:mm"];
        
        [cell.label1 setText:[showformat stringFromDate:myDate]];
        [cell.label2 setText:[one valueForKey:@"name"]];
        cell.backgroundColor = [UIColor clearColor];
//        NSLog(@"%d",)[[one valueForKey:@"live"] ] );
        
        if ([[one valueForKey:@"live"] boolValue]) {
            cell.backgroundColor = THEME_RED;
            cell.label1.textColor =[UIColor whiteColor];
            cell.label2.textColor =[UIColor whiteColor];
            
        }

        
    }
    
    return cell;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}
-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

/*
 viewWillDisappear
 viewDidDisappear
 viewWillAppear
 viewDidAppear
 

 
 
 
 */
-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

-(void)MGListView:(MGListView *)listView scrollViewDidScroll:(UIScrollView *)scrollView {}
-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    //    News* news = [listViewNews.arrayData objectAtIndex:indexPath.row];
    //
    //    NewsDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNewsDetail"];
    //    vc.strUrl = news.news_url;
    //    [self.navigationController pushViewController:vc animated:YES];
}


-(IBAction)chanelsegmentBtnPressed:(UISegmentedControl*)sender{
    NSLog(@"chanelsegmentBtnPressed %ld",(long)[sender selectedSegmentIndex]);
    [week.segmentAnimation setSelectedSegmentIndex:weekday];
    NSInteger select_index = [sender selectedSegmentIndex];
    NSString* title = [sender titleForSegmentAtIndex:select_index];
    
//    NSString* ch_id = [name_index valueForKey:title];
//        NSLog(@"%@",ch_id);
    
    for (NSDictionary* chanel in data) {
        if ([[[chanel valueForKey:@"name"] uppercaseString] isEqualToString:title]){
            program = [chanel objectForKey:@"programs"];
            NSMutableArray  *tmparray= [[NSMutableArray alloc] init];
            for (NSDictionary* one in program ) {
                NSLog(@"%@",[one valueForKey:@"day"]);
                if ([[one valueForKey:@"day"] intValue] == weekday){
                    [tmparray addObject:one];
                }
            }
            [list setArrayData:tmparray];
            [list reloadData];
            break;
        }
    }

}
-(void)weeksegmentBtnPressed:(UISegmentedControl*)sender{

    int select_index = (int)[sender selectedSegmentIndex];
    NSMutableArray  *tmparray= [[NSMutableArray alloc] init];
    
//    [tmparray containsObject:];
    //[tmparray removeObject:<#(nonnull id)#>];
    
    for (NSDictionary* one in program ) {
        NSLog(@"%@",[one valueForKey:@"day"]);
        if ([[one valueForKey:@"day"] intValue] == select_index+1){
            [tmparray addObject:one];
        }
    }
    [list setArrayData:tmparray];
    [list reloadData];
}


@end
