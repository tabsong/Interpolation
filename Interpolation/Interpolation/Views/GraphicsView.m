//
//  GraphicsView.m
//  Interpolation
//
//  Created by songjian on 13-6-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "GraphicsView.h"

#define HorizontalMargin    20.f
#define VerticalMargin      20.f
#define OutlineWidth        1.f
#define PathWidth           2.f

@interface GraphicsView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation GraphicsView
@synthesize shapeLayer = _shapeLayer;
@synthesize points = _points;

#pragma mark - Utility

- (void)drawTips
{
    [@"v/t" drawInRect:CGRectMake(0,
                                CGRectGetMaxY(self.bounds) - VerticalMargin,
                                HorizontalMargin,
                                HorizontalMargin)
            withFont:[UIFont systemFontOfSize:14]
       lineBreakMode:NSLineBreakByWordWrapping
           alignment:NSTextAlignmentCenter];
    
    [@"10" drawInRect:CGRectMake(0,
                                 0,
                                 HorizontalMargin,
                                 HorizontalMargin)
             withFont:[UIFont systemFontOfSize:14]
        lineBreakMode:NSLineBreakByWordWrapping
            alignment:NSTextAlignmentCenter];
    
    [@"1" drawInRect:CGRectMake(CGRectGetMaxX(self.bounds) - HorizontalMargin,
                                CGRectGetMaxY(self.bounds) - VerticalMargin,
                                HorizontalMargin,
                                HorizontalMargin)
            withFont:[UIFont systemFontOfSize:14]
       lineBreakMode:NSLineBreakByWordWrapping
           alignment:NSTextAlignmentCenter];
}

- (void)resizeShapeLayer
{
    CGRect insetRect = CGRectInset(self.bounds, HorizontalMargin, VerticalMargin);
    self.shapeLayer.bounds      = CGRectMake(0, 0, CGRectGetWidth(insetRect), CGRectGetHeight(insetRect));
    self.shapeLayer.position    = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)updateShapePath
{
    CGFloat xRatio = CGRectGetWidth(self.shapeLayer.bounds)  / 1.f;
    CGFloat yRatio = CGRectGetHeight(self.shapeLayer.bounds) / 10.f;
    
    CGPoint *pathPoints = (CGPoint *)malloc(self.points.count * sizeof(CGPoint));
    
    [self.points enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        
        CGPoint point = [obj CGPointValue];
        point.x *= xRatio;
        point.y *= yRatio;
        
        point.y = -point.y + CGRectGetHeight(self.shapeLayer.bounds);
        
        pathPoints[idx] = point;
    }];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddLines(path, NULL, pathPoints, self.points.count);
    
    self.shapeLayer.path = path;
    
    CGPathRelease(path), path = NULL;
    free(pathPoints), pathPoints = NULL;
}

#pragma mark - Interfaces

- (void)setPoints:(NSArray *)points
{
    _points = points;
    
    [self updateShapePath];
}

#pragma mark - Initialization

- (void)initShapeLayer
{
    self.shapeLayer = [CAShapeLayer layer];
    [self resizeShapeLayer];
    self.shapeLayer.lineWidth   = PathWidth;
    self.shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:self.shapeLayer];
}

#pragma mark - Override

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, OutlineWidth);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGPoint outlinePoints[3];
    outlinePoints[0] = CGPointMake(CGRectGetMinX(self.bounds) + HorizontalMargin, CGRectGetMinY(self.bounds) + VerticalMargin);
    outlinePoints[1] = CGPointMake(CGRectGetMinX(self.bounds) + HorizontalMargin, CGRectGetMaxY(self.bounds) - VerticalMargin);
    outlinePoints[2] = CGPointMake(CGRectGetMaxX(self.bounds) - HorizontalMargin, CGRectGetMaxY(self.bounds) - VerticalMargin);
    
    CGContextAddLines(context, outlinePoints, sizeof(outlinePoints) / sizeof(CGPoint));
    
    CGContextStrokePath(context);
    
    [self drawTips];
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initShapeLayer];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
    
    [self resizeShapeLayer];
    
    [self updateShapePath];
}

@end
