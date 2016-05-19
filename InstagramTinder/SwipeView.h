//
//  SwipeView.h
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeCardView.h"

@interface SwipeView : UIView <DraggableViewDelegate>

@property (strong,nonatomic)NSArray* cardImagesUrlsArray;
@property (strong,nonatomic)NSMutableArray* allSwipeCardsArray;
@property (nonatomic, strong)NSMutableArray *likedArray;
@property (nonatomic, strong)NSMutableArray *disLikedArray;
-(void)setUpView;

@end
