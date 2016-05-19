//
//  LikeViewController.h
//  InstagramTinder
//
//  Created by Hitesh Kumar on 19/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSArray *dataArray;

@end
