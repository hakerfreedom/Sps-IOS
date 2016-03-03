//
//  TmpData.h
//  Sps
//
//  Created by DDaima on 2/12/16.
//  Copyright © 2016 DDaima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TmpData : NSObject

+(NSDictionary* )get;
+(void)set:(NSDictionary*)str;

+(int)getLimit;
+(void)setLimit:(int)limit;


+(NSMutableArray* )getFav_ids;
+(void)setFav_ids:(NSMutableArray* )arr;
+(void)remove_id:(NSString*)str;
+(void)add_id:(NSString*)str;
+(BOOL)find_id:(NSString*)str;



@end
