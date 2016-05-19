//
//  InstagramModel.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 19/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "InstagramModel.h"

@implementation InstagramModel

-(id)initWithData:(NSDictionary *)dict {
    
    self.imgUrl = dict[@"images"][@"standard_resolution"][@"url"];
    return self;
}


+(NSArray*)getDataArray:(NSDictionary *)data {
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    NSArray *dataArray = [data objectForKey:@"data"];
    
    for (NSDictionary *dict in dataArray) {
        InstagramModel *model = [[InstagramModel alloc] initWithData:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
