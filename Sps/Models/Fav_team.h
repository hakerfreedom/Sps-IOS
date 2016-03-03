//
//  Fav_team.h
//  Sps
//
//  Created by DDaima on 2/4/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Fav_team : NSManagedObject

@property (nonatomic, retain) NSString * fteam_id;
@property (nonatomic, retain) NSString * fteam_name;
@property (nonatomic, retain) NSString * fteam_leg;
@property (nonatomic, retain) NSString * fteam_logo;

@end
