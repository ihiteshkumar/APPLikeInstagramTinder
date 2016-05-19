//
//  SwipeVC.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "SwipeView.h"
#import "SwipeCardView.h"
#import "InstagramModel.h"
#import "NSString+MD5.h"
#import "FTWCache.h"

static const int MAX_BUFFER_SIZE = 2; //We change max_buffer_size to increase or decrease the number of cards this holds


@implementation SwipeView {
    NSInteger cardsLoadedIndex; // index of the loaded card, last time loded into lodedCards array
    NSInteger indexCheck; //for check index to add in like or dislike array
    NSMutableArray *loadedCardsArray; //card loaded array, have the loded cards, here it loads according to buffer size
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.cardImagesUrlsArray = [[NSArray alloc]init];
    return  self;
}
-(void)setUpView{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1];
    loadedCardsArray = [[NSMutableArray alloc] init];
    self.allSwipeCardsArray = [[NSMutableArray alloc] init];
    self.likedArray = [[NSMutableArray alloc] init];
    self.disLikedArray = [[NSMutableArray alloc] init];
    cardsLoadedIndex = 0;
    [self loadCards];
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

-(void)loadCards
{
    if([self.cardImagesUrlsArray count] > 0) {
        NSInteger totalloadedCardsArray =(([self.cardImagesUrlsArray count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[self.cardImagesUrlsArray count]);
        for (int i = 0; i < [self.cardImagesUrlsArray count]; i++) {
            SwipeCardView *newCard = [self cardSwipeViewAtIndexWithImage:i];
            [self.allSwipeCardsArray addObject:newCard];
            
            if (i < totalloadedCardsArray) {
                [loadedCardsArray addObject:newCard];  // add first 2 cards
            }
        }
        for (int i = 0; i<[loadedCardsArray count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCardsArray objectAtIndex:i] belowSubview:[loadedCardsArray objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCardsArray objectAtIndex:i]];
            }
            cardsLoadedIndex++;
        }
    }
}
-(SwipeCardView *)cardSwipeViewAtIndexWithImage:(NSInteger)index
{
    float CARD_HEIGHT = [UIScreen mainScreen].bounds.size.height-120;
    float CARD_WIDTH = [UIScreen mainScreen].bounds.size.width-20;
    SwipeCardView *swipeCardView = [[SwipeCardView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    InstagramModel *model = [self.cardImagesUrlsArray objectAtIndex:index];
    [self setImage:swipeCardView.imgView withImageUrl:model.imgUrl atIndex:index];
    swipeCardView.delegate = self;
    return swipeCardView;
}

-(void)cardSwipedLeft:(UIView *)card;
{
    [loadedCardsArray removeObjectAtIndex:0]; // card was swiped, so it's no longer a "loaded card"
    if (cardsLoadedIndex != indexCheck) {
        indexCheck = cardsLoadedIndex;
        [self.disLikedArray addObject:[self.cardImagesUrlsArray objectAtIndex:cardsLoadedIndex-2]];
    } else {
        [self.disLikedArray addObject:[self.cardImagesUrlsArray objectAtIndex:cardsLoadedIndex-1]];
        [self addLabel];
    }
    if (cardsLoadedIndex < [self.allSwipeCardsArray count]) { // if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCardsArray addObject:[self.allSwipeCardsArray objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCardsArray objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCardsArray objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}
-(void)addLabel {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    label.text = @"Come Again\n\n Your All Cards are Finished....:)";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:label];
}

-(void)cardSwipedRight:(UIView *)card
{
    [loadedCardsArray removeObjectAtIndex:0];
    if (cardsLoadedIndex != indexCheck) {
        indexCheck = cardsLoadedIndex;
        [self.likedArray addObject:[self.cardImagesUrlsArray objectAtIndex:cardsLoadedIndex-2]];
    } else {
        [self.likedArray addObject:[self.cardImagesUrlsArray objectAtIndex:cardsLoadedIndex-1]];
        [self addLabel];
    }
    if (cardsLoadedIndex < [self.allSwipeCardsArray count]) {
        [loadedCardsArray addObject:[_allSwipeCardsArray objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCardsArray objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCardsArray objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}


@end
