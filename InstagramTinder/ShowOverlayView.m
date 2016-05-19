//
//  ShowOverlayView.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "ShowOverlayView.h"

@implementation ShowOverlayView {
    UIImageView *imageView;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dislike"]];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setDirection:(GGOverlayViewDirection)Direction
{
    if (_Direction == Direction) {
        return;
    }
    _Direction = Direction;
    if(Direction == GGOverlayViewDirectionLeft) {
        imageView.image = [UIImage imageNamed:@"dislike"];
    } else {
        imageView.image = [UIImage imageNamed:@"like"];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(50, 50, 100, 100);
}

@end
