//
//  SwipeCardView.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#define ACTION_MARGIN 120 //distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //Higher = stronger rotation angle

#import "SwipeCardView.h"

@implementation SwipeCardView {
    CGFloat xValueFromCenter;
    CGFloat yValueFromCenter;
    UIPanGestureRecognizer *panGestureRecognizer;
    CGPoint originalPoint;
    ShowOverlayView *overlayView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self setupImageView];
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(cardMoving:)];
        [self addGestureRecognizer:panGestureRecognizer];
        [self addSubview:self.imgView];
        overlayView = [[ShowOverlayView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.backgroundColor = [UIColor clearColor];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
    }
    return self;
}

-(void)setupImageView
{
    self.backgroundColor = [UIColor clearColor];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 4;
    self.imgView.layer.shadowRadius = 3;
    self.imgView.layer.shadowOpacity = 0.2;
    self.imgView.layer.shadowOffset = CGSizeMake(1, 1);
}


-(void)cardMoving:(UIPanGestureRecognizer *)gestureRecognizer
{
    xValueFromCenter = [gestureRecognizer translationInView:self].x; // if right positive(+) value, negative for left
    yValueFromCenter = [gestureRecognizer translationInView:self].y; // if swipe up positive(+), negative for down
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xValueFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            self.center = CGPointMake(originalPoint.x + xValueFromCenter, originalPoint.y + yValueFromCenter);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            [self updateOverlay:xValueFromCenter];
            break;
        };
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//checks if distance is positive means moving right else left
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.Direction = GGOverlayViewDirectionRight;
    } else {
        overlayView.Direction = GGOverlayViewDirectionLeft;
    }
    overlayView.alpha = MIN(fabs(distance)/100, 0.4);
}

- (void)afterSwipeAction
{
    if (xValueFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xValueFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //for reseting the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

// this will be called when a swipe exceeds ACTION_MARGIN to the right
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2*yValueFromCenter +originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    [self.delegate cardSwipedRight:self];
}

-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2*yValueFromCenter +originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    [self.delegate cardSwipedLeft:self];
}


@end
