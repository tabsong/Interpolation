//
//  MAMediaTimingFunction.m
//  MapKit_static
//
//  Created by songjian on 13-2-4.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "MAMediaTimingFunction.h"

@interface MAMediaTimingFunction ()

@property (nonatomic, readwrite, assign) MAMediaTimingFunctionType type;

@end

@implementation MAMediaTimingFunction
@synthesize type = _type;

#pragma mark - Class Methods

+ (id)functionWithType:(MAMediaTimingFunctionType)type
{
    return [[MAMediaTimingFunction alloc] initWithType:type];
}

#pragma mark - Private Methods

- (float)normalizeValue:(float)value
{
#define kCAMAMediaTimingFunctionMax 1.f
#define kCAMAMediaTimingFunctionMin 0.f
    return MAX(kCAMAMediaTimingFunctionMin,
               MIN(kCAMAMediaTimingFunctionMax, value));
}

#pragma mark - Linear

- (float)linearInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return start + t * (end - start);
}

#pragma mark - Quadratic

- (float)easeInQuadraticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * t * t + start;
}

- (float)easeOutQuadraticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return -(end - start) * t * (t - 2) + start;
}

- (float)easeInEaseOutQuadraticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    float t = slice * 2.f;
    
    if (t < 1.f)
    {
        return (end - start) / 2.f * t * t + start;
    }
    
    t--;
    
    return -(end - start) / 2.f * (t * (t - 2) - 1) + start;
}

#pragma mark - Quadratic

- (float)easeInCubicInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * t * t * t + start;
}

- (float)easeOutCubicInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;

    t--;

    return (end - start)*(t*t*t + 1) + start;
}

- (float)easeInEaseOutCubicInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    float t = slice * 2.f;
    
    if (t < 1) return (end - start) / 2 * t * t * t + start;
    
    t -= 2;
    
    return (end - start) / 2 * (t * t * t + 2) + start;
}

#pragma mark - Quartic

- (float)easeInQuarticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * t * t * t * t + start;
}

- (float)easeOutQuarticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    t--;
    
    return -(end - start) * (t * t * t * t - 1) + start;
}

- (float)easeInEaseOutQuarticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice * 2.f;
    
    if (t < 1) return (end - start) / 2 * t * t * t * t + start;
    
    t -= 2;
    
    return -(end - start) / 2 * (t * t * t * t - 2) + start;
}

#pragma mark - Quintic

- (float)easeInQuinticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * t * t * t * t + start;
}

- (float)easeOutQuinticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    t--;
    
    return -(end - start) * (t * t * t * t - 1) + start;
}

- (float)easeInEaseOutQuinticInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice * 2.f;

    if (t < 1) return (end - start) / 2 * t * t * t * t + start;
    
    t -= 2;
    
    return -(end - start) / 2 * (t * t * t * t - 2) + start;
}

#pragma mark - Sin

- (float)easeInSinInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return -(end - start) * cos(t/1 * (M_PI/2)) + (end - start) + start;
}

- (float)easeOutSinInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * sin(t/1 * (M_PI/2)) + start;
}

- (float)easeInEaseOutSinInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice * 2.f;
    
    return -(end - start) / 2 * (cos(M_PI*t/1) - 1) + start;
}

#pragma mark - Exp

- (float)easeInExpInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * pow( 2, 10 * (t/1 - 1) ) + start;
}

- (float)easeOutExpInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return (end - start) * ( pow( 2, -10 * t/1 ) + 1 ) + start;
}

- (float)easeInEaseOutExpInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice * 2.f;
    
    if (t < 1) return (end - start)/2 * pow( 2, 10 * (t - 1) ) + start;
    
    t--;
    
    return (end - start)/2 * ( pow( 2, -10 * t) + 2 ) + start;
}

#pragma mark - Circular

- (float)easeInCircularInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    return -(end - start) * (sqrt(1 - t*t) - 1) + start;
}

- (float)easeOutCircularInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice;
    
    t--;
    
    return (end - start) * sqrt(1 - t*t) + start;
}

- (float)easeInEaseOutCircularInterpolateBySlice:(float)slice start:(float)start end:(float)end
{
    CGFloat t = slice * 2.f;
    
    if (t < 1) return -(end - start)/2 * (sqrt(1 - t*t) - 1) + start;
    
    t -= 2;
    
    return (end - start)/2 * (sqrt(1 - t*t) + 1) + start;
}

#pragma mark - Interfaces

- (float)interpolateBySlice:(float)slice start:(float)start end:(float)end
{
    /* clamp slice to [0.f, 1.f]. */
    slice = [self normalizeValue:slice];
    
    switch (self.type)
    {
        /* Quadratic */
        case MAMediaTimingFunctionEaseInQuadratic:
        {
            return [self easeInQuadraticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutQuadratic:
        {
            return [self easeOutQuadraticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutQuadratic:
        {
            return [self easeInEaseOutQuadraticInterpolateBySlice:slice start:start end:end];
        }
            
        /* Cubic */
        case MAMediaTimingFunctionEaseInCubic:
        {
            return [self easeInCubicInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutCubic:
        {
            return [self easeOutCubicInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutCubic:
        {
            return [self easeInEaseOutCubicInterpolateBySlice:slice start:start end:end];
        }
        
        /* Quartic */
        case MAMediaTimingFunctionEaseInQuartic:
        {
            return [self easeInQuarticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutQuartic:
        {
            return [self easeOutQuarticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutQuartic:
        {
            return [self easeInEaseOutQuarticInterpolateBySlice:slice start:start end:end];
        }
            
        /* Quintic */
        case MAMediaTimingFunctionEaseInQuintic:
        {
            return [self easeInQuinticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutQuintic:
        {
            return [self easeOutQuinticInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutQuintic:
        {
            return [self easeInEaseOutQuinticInterpolateBySlice:slice start:start end:end];
        }
            
        /* Sin */
        case MAMediaTimingFunctionEaseInSin:
        {
            return [self easeInSinInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutSin:
        {
            return [self easeOutSinInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutSin:
        {
            return [self easeInEaseOutSinInterpolateBySlice:slice start:start end:end];
        }
            
        /* Exp */
        case MAMediaTimingFunctionEaseInExp:
        {
            return [self easeInExpInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutExp:
        {
            return [self easeOutExpInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutExp:
        {
            return [self easeInEaseOutExpInterpolateBySlice:slice start:start end:end];
        }
            
        /* Circular */
        case MAMediaTimingFunctionEaseInCircular:
        {
            return [self easeInCircularInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseOutCircular:
        {
            return [self easeOutCircularInterpolateBySlice:slice start:start end:end];
        }
        case MAMediaTimingFunctionEaseInEaseOutCircular:
        {
            return [self easeInEaseOutCircularInterpolateBySlice:slice start:start end:end];
        }
            
        default:
        {
            return [self linearInterpolateBySlice:slice start:start end:end];
        }
    }
}

#pragma mark - Life Cycle

- (id)initWithType:(MAMediaTimingFunctionType)type
{
    if (self = [super init])
    {
        self.type = type;
    }
    
    return self;
}

@end
