//
//  GraphicsView.h
//  Interpolation
//
//  Created by songjian on 13-6-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GraphicsView : UIView

/* NSArray-->NSValue-->CGPoint, 
 x will be clamp to [0.0, 1.f],
 y will be clamp to [0.f, 10.f]. */
@property (nonatomic, strong) NSArray *points;

@end
