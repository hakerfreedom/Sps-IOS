//
//  TmpData.m
//  Sps
//
//  Created by DDaima on 2/12/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import "TmpData.h"

static NSDictionary* str;
static int limit;
static NSMutableArray* ids ;//= [[NSMutableArray alloc] init];

@implementation TmpData

+ (NSDictionary*)get {
    return str;
}

+ (void)set:(NSDictionary*)newStr {
        str = newStr;
}


+(BOOL)find_id:(NSString*)str{
    return [ids containsObject:str];
}
+(void)remove_id:(NSString*)str{
    [ids removeObject:str];
}
+(void)add_id:(NSString*)str;{
    [ids addObject:str];
}


+(NSMutableArray* )getFav_ids{
    if (!ids){
        ids= [[NSMutableArray alloc] init];
    }
    return ids;
}

+(void)setFav_ids:(NSMutableArray* )arr{
    if (!ids){
        ids= [[NSMutableArray alloc] init];
    }
    ids= arr;
}


//limit


+(int)getLimit{
    
    return limit;
}

+(void)setLimit:(int)lim{
    
    limit=lim;
}


@end
