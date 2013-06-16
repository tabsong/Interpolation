//
//  MainViewController.m
//  Interpolation
//
//  Created by songjian on 13-6-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "MainViewController.h"
#import "GraphicsView.h"
#import "MAMediaTimingFunction.h"
#import "FuncViewController.h"

#define AnimationDuration  3.f
#define AnimationInterval  1 / 30.f

@interface MainViewController ()<FuncViewControllerDelegate>

@property (nonatomic, strong) GraphicsView *graphicsView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) MAMediaTimingFunction *timingFunc;

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval pass;
@property (nonatomic, strong) NSMutableArray *points;

@end

@implementation MainViewController
@synthesize graphicsView    = _graphicsView;
@synthesize timer           = _timer;
@synthesize timingFunc      = _timingFunc;

@synthesize duration        = _duration;
@synthesize pass            = _pass;
@synthesize points          = _points;

#pragma mark - Utility

- (void)startTimer
{
    [self stopTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:AnimationInterval
                                                  target:self
                                                selector:@selector(fireTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)cancelAnimation
{
    [self stopTimer];
    
    self.graphicsView.points = nil;
    
    [self.points removeAllObjects];
    
    self.pass = 0.f;
}

- (void)performAnimation
{
    if (self.timingFunc == nil)
    {
        return;
    }
    
    [self cancelAnimation];
    
    [self.points addObject:[NSValue valueWithCGPoint:CGPointMake(0, [self.timingFunc interpolateBySlice:0 start:0.f end:10.f])]];
    
    self.duration = AnimationDuration;
    
    [self startTimer];
}

- (void)updateTitle
{
    self.navigationItem.title = [FuncViewController textForType:self.timingFunc.type];
}

- (void)updateTimingFunctionWithType:(MAMediaTimingFunctionType)type
{
    self.timingFunc = [MAMediaTimingFunction functionWithType:type];
}

#pragma mark - Handle Action

- (void)fireTimer:(NSTimer *)timer
{
    self.pass += timer.timeInterval;
    
    CGFloat slice = MIN(self.pass / self.duration, 1.f);

    CGFloat interpolation = [self.timingFunc interpolateBySlice:slice start:0.f end:10.f];
    
    [self.points addObject:[NSValue valueWithCGPoint:CGPointMake(slice, interpolation)]];
    
    self.graphicsView.points = self.points;
    
    if (self.pass > self.duration)
    {
        [self stopTimer];
    }
}

- (void)redoAction
{
    [self performAnimation];
}

- (void)categoryAction
{
    FuncViewController *funcViewController = [[FuncViewController alloc] init];
    funcViewController.delegate             = self;
    funcViewController.timingFunctionType   = self.timingFunc.type;
    funcViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:funcViewController]
                                            animated:YES
                                          completion:nil];
}

#pragma mark - FuncViewControllerDelegate

- (void)funcViewController:(FuncViewController *)funcViewController didChangeTimingFunctionType:(MAMediaTimingFunctionType)timingFunctionType
{
    [self updateTimingFunctionWithType:timingFunctionType];
    
    [self updateTitle];
}

#pragma mark - Initialization

- (void)initGraphicsView
{
    self.graphicsView = [[GraphicsView alloc] initWithFrame:self.view.bounds];
    self.graphicsView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.graphicsView];
}

- (void)initNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Redo"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(redoAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Category"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(categoryAction)];
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.points = [NSMutableArray array];
        
        [self updateTimingFunctionWithType:MAMediaTimingFunctionLinear];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateTitle];
    
    [self initGraphicsView];
    
    [self initNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self cancelAnimation];
}

@end
