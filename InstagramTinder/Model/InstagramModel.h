//
//  InstagramModel.h
//  InstagramTinder
//
//  Created by Hitesh Kumar on 19/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramModel : NSObject

@property (nonatomic, strong) NSString *imgUrl;

-(id) initWithData: (NSDictionary *) dict;
+(NSArray *) getDataArray: (NSDictionary *) data;

@end
