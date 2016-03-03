//
//  TeamCollectionViewController.m
//  Sps
//
//  Created by DDaima on 2/9/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "TeamCollectionViewController.h"
#import "TeamCollectionViewCell.h"

@interface TeamCollectionViewController (){

    NSMutableArray* array ;

}

@end

@implementation TeamCollectionViewController
@synthesize l_id;

static NSString * const reuseIdentifier = @"TeamCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"id = %@",l_id);
     
    NSDictionary* dict = [[MGParser getJSONAtURL:[NSString stringWithFormat:@"%@%@/%@",BASE_URL,LEAGUES,l_id]] valueForKey:@"teams"];
    
    array = [[NSMutableArray alloc] init];

    for (NSDictionary* dictTeam in dict){
        
        [array addObject:dictTeam];
        
    }
    
     
    [self.collectionView registerClass: [TeamCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier ];

    UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.collectionView setBackgroundView:boxBackView];
    [self.collectionView setContentInset:UIEdgeInsetsMake(20, 10, 20, 10)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count;
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TeamCollectionViewCell *cell = (TeamCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    
    [self setImage:[[array objectAtIndex:indexPath.row] valueForKey:@"logo"] imageView:cell.logo1];
    if ([TmpData find_id:[[array objectAtIndex:indexPath.row] valueForKey:@"id"]]){
        [cell.check setHidden:false];
    }
    return cell;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/
/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(70, 70);
//    retval.height += 15;
//    retval.width += 15;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TeamCollectionViewCell* cell = (TeamCollectionViewCell* )[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.check isHidden]) {
        NSMutableArray* tmpArray= [TmpData getFav_ids];
        int limit = [TmpData getLimit];
        if (tmpArray.count == limit ) {
            
            [MGUtilities showAlertTitle:@"Сонордуулга" message:[NSString stringWithFormat:@"Та хамгийн ихдээ %d баг сонгох боломжтой.",limit]];
            return;
        }
        [TmpData add_id:[[array objectAtIndex:indexPath.row] valueForKey:@"id"]];
        
        [cell.check setHidden:false];
        
    }
    else{
        [TmpData remove_id:[[array objectAtIndex:indexPath.row] valueForKey:@"id"]];
        [cell.check setHidden:true];
    }
    
}
@end
