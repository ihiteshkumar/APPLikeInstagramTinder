//
//  SwipeViewController.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "SwipeViewController.h"
#import "SwipeView.h"
#import "LikeViewController.h"
#import "DisLikeViewController.h"
#import "InstagramModel.h"

@interface SwipeViewController ()
@property(nonatomic, strong) LikeViewController *likeVC;
@property(nonatomic, strong) DisLikeViewController *disLikeVC;
@property(nonatomic, strong) SwipeView *swipeView;
@property(nonnull, strong)UILabel *label;
@property (nonatomic, strong) InstagramModel *instagramModel;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *token = @"1216075242.1fb234f.4af9798e6ae944a381fdd8d7e6d686c4";
    [self setupView];
    [self fetchDataWithToken:token];
    self.tabBarController.delegate = self;
}
-(void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.label.text = @"Please wait....\n\n Your Cards are loading......";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:self.label];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.likeVC = (LikeViewController *) [tabBarController.viewControllers objectAtIndex:2];
    self.likeVC.dataArray = self.swipeView.likedArray;
    [self.likeVC.tableView reloadData];
    self.disLikeVC = (DisLikeViewController *) [tabBarController.viewControllers objectAtIndex:0];
    self.disLikeVC.dataArray = self.swipeView.disLikedArray;
    [self.disLikeVC.tableView reloadData];
}
-(void)handleResponseWithJson:(id)json {
    self.dataArray = [InstagramModel getDataArray:json];    
    self.swipeView = [[SwipeView alloc] initWithFrame:self.view.frame];
    self.swipeView.cardImagesUrlsArray = self.dataArray;
    [self.swipeView setUpView];
    self.label.hidden = YES;
    [self.view addSubview:self.swipeView];
}
-(void)fetchDataWithToken:(NSString *)token {
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/iphone/media/recent?access_token=%@", token];
    NSURL * url = [NSURL URLWithString:urlStr];
    [[[NSURLSession sharedSession]
      dataTaskWithURL:url
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

          if(error)
          {
              NSLog(@"Netwrok Error");
              self.label.text =@"Netwrok Error \n\n Please try again";
              return ;
          }

          NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
          if(httpResponse.statusCode < 200 || httpResponse.statusCode >= 300)
          {
              NSLog(@"HTTP Error");
              self.label.text =@"HTTP Error \n\n Please try again";
              return ;
          }

          NSError * parseError;
          id pkg = [NSJSONSerialization JSONObjectWithData:data
                                                   options:0
                                                     error:&parseError];

          if(!pkg)
          {
              NSLog(@"JSON Error");
              self.label.text =@"JSON Error \n\n Please try again";
              return ;
          }
          [self handleResponseWithJson:pkg];
      }] resume];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
