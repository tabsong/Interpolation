//
//  MAMediaTimingFunction.h
//  MapKit_static
//
//  Created by songjian on 13-2-4.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    /* Linear. */
    MAMediaTimingFunctionLinear = 0,
    
    /* Quadratic. */
    MAMediaTimingFunctionEaseInQuadratic,
    MAMediaTimingFunctionEaseOutQuadratic,
    MAMediaTimingFunctionEaseInEaseOutQuadratic,
    
    /* Cubic. */
    MAMediaTimingFunctionEaseInCubic,
    MAMediaTimingFunctionEaseOutCubic,
    MAMediaTimingFunctionEaseInEaseOutCubic,
    
    /* Quartic. */
    MAMediaTimingFunctionEaseInQuartic,
    MAMediaTimingFunctionEaseOutQuartic,
    MAMediaTimingFunctionEaseInEaseOutQuartic,
    
    /* Quintic. */
    MAMediaTimingFunctionEaseInQuintic,
    MAMediaTimingFunctionEaseOutQuintic,
    MAMediaTimingFunctionEaseInEaseOutQuintic,
    
    /* Sin. */
    MAMediaTimingFunctionEaseInSin,
    MAMediaTimingFunctionEaseOutSin,
    MAMediaTimingFunctionEaseInEaseOutSin,
    
    /* Exp. */
    MAMediaTimingFunctionEaseInExp,
    MAMediaTimingFunctionEaseOutExp,
    MAMediaTimingFunctionEaseInEaseOutExp,
    
    /* Circular. */
    MAMediaTimingFunctionEaseInCircular,
    MAMediaTimingFunctionEaseOutCircular,
    MAMediaTimingFunctionEaseInEaseOutCircular,
    
}MAMediaTimingFunctionType;

@interface MAMediaTimingFunction : NSObject

+ (id)functionWithType:(MAMediaTimingFunctionType)type;

@property (nonatomic, readonly, assign) MAMediaTimingFunctionType type;

- (float)interpolateBySlice:(float)slice start:(float)start end:(float)end;

@end
