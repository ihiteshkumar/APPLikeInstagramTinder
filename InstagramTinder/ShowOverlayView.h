//
//  ShowOverlayView.h
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewDirection) {
    GGOverlayViewDirectionLeft,
    GGOverlayViewDirectionRight
};

@interface ShowOverlayView : UIView
@property (nonatomic) GGOverlayViewDirection Direction;
@end
