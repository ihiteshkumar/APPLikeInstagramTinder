//
//  LikeViewController.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 19/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "LikeViewController.h"
#import "LikeAndUnlikeTableViewCell.h"
#import "SwipeView.h"
#import "NSString+MD5.h"
#import "FTWCache.h"
#import "InstagramModel.h"

@interface LikeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LikeAndUnlikeTableViewCell" bundle:nil] forCellReuseIdentifier:@"LikeAndUnlikeTableViewCell"];    
    self.view.bounds = CGRectInset(self.view.frame, 0.0f, -15.0f);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.tabBarController.tabBar.frame)+15, 0);
}
-(void)setImage:(UIImageView*)imgView withImageUrl:(NSString *)imgUrl atIndex:(NSInteger)index {
    
    NSURL * imageUrl = [NSURL URLWithString:imgUrl];
    NSString *key = [imgUrl MD5Hash];
    NSData *data = [FTWCache objectForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        imgView.image = image;
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(error)
            {
                NSLog(@"Netwrok Error");
                return ;
            }
            
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            if(httpResponse.statusCode < 200 || httpResponse.statusCode >= 300)
            {
                NSLog(@"HTTP Error");
                return ;
            }
            [FTWCache setObject:data forKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                imgView.image = [UIImage imageWithData:data];
            });
            
        }] resume];
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;//[self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LikeAndUnlikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LikeAndUnlikeTableViewCell" forIndexPath:indexPath];
    InstagramModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [self setImage:cell.imgView withImageUrl:model.imgUrl atIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
