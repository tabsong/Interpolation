//
//  FuncViewController.h
//  Interpolation
//
//  Created by songjian on 13-6-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAMediaTimingFunction.h"

@protocol FuncViewControllerDelegate;

@interface FuncViewController : UIViewController

@property (nonatomic, assign) id<FuncViewControllerDelegate> delegate;

@property (nonatomic, assign) MAMediaTimingFunctionType timingFunctionType;

+ (NSString *)textForType:(MAMediaTimingFunctionType)type;

@end

@protocol FuncViewControllerDelegate <NSObject>

@optional
- (void)funcViewController:(FuncViewController *)funcViewController didChangeTimingFunctionType:(MAMediaTimingFunctionType)timingFunctionType;

@end
