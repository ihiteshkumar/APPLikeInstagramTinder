//
//  SwipeCardView.h
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowOverlayView.h"


@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface SwipeCardView : UIView

@property (weak) id <DraggableViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *imgView;

@end
