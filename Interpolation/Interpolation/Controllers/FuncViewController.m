//
//  FuncViewController.m
//  Interpolation
//
//  Created by songjian on 13-6-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "FuncViewController.h"

@interface FuncViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FuncViewController
@synthesize tableView           = _tableView;
@synthesize timingFunctionType  = _timingFunctionType;
@synthesize delegate            = _delegate;

#pragma mark - Utility

- (MAMediaTimingFunctionType)typeAtIndexPath:(NSIndexPath *)indexPath
{
    MAMediaTimingFunctionType type = MAMediaTimingFunctionLinear;
    if (indexPath.section != 0)
    {
        type = (indexPath.section - 1) * 3 + 1 + indexPath.row;
    }
    
    return type;
}

- (NSIndexPath *)indexPathForType:(MAMediaTimingFunctionType)type
{
    NSIndexPath *indexPath = nil;
    
    if (type == MAMediaTimingFunctionLinear)
    {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else
    {
        indexPath = [NSIndexPath indexPathForRow:(type - 1) % 3 inSection:(type - 1) / 3 + 1];
    }
    
    return indexPath;
}

- (NSString *)titleForSection:(NSInteger)section
{
    static NSArray *titleArray = nil;
    if (titleArray == nil)
    {
        titleArray = [NSArray arrayWithObjects:
                      @"Linear",
                      @"Quadratic",
                      @"Cubic",
                      @"Quartic",
                      @"Quintic",
                      @"Sin",
                      @"Exp",
                      @"Circular",
                      nil];
    }
    
    return [titleArray objectAtIndex:section];
}

+ (NSString *)textForType:(MAMediaTimingFunctionType)type
{
    static NSArray *typeArray = nil;
    if (typeArray == nil)
    {
        typeArray = [NSArray arrayWithObjects:
                     @"Linear",
                     @"EaseInQuadratic",    @"EaseOutQuadratic",    @"EaseInEaseoutQuadratic",
                     @"EaseInCubic",        @"EaseOutCubic",        @"EaseInEaseOutCubic",
                     @"EaseInQuartic",      @"EaseOutQuartic",      @"EaseInEaseOutQuartic",
                     @"EaseInQuintic",      @"EaseOutQuintic",      @"EaseInEaseOutQuintic",
                     @"EaseInSin",          @"EaseOutSin",          @"EaseInEaseOutSin",
                     @"EaseInExp",          @"EaseOutExp",          @"EaseInEaseOutExp",
                     @"EaseInCircular",     @"EaseOutCircular",     @"EaseInEaseOutCircular",
                     nil];
    }
    
    return [typeArray objectAtIndex:type];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MAMediaTimingFunctionType type = [self typeAtIndexPath:indexPath];
        
    cell.accessoryType = (type == self.timingFunctionType) ?
                            UITableViewCellAccessoryCheckmark :
                            UITableViewCellAccessoryNone;
    
    cell.textLabel.text = [FuncViewController textForType:type];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.timingFunctionType = [self typeAtIndexPath:indexPath];

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(funcViewController:didChangeTimingFunctionType:)])
    {
        [self.delegate funcViewController:self didChangeTimingFunctionType:self.timingFunctionType];
    }
    
    [self doneAction];
}

#pragma mark - Handle Action

- (void)doneAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Initialization

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(doneAction)];
}

#pragma mark - Life Cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"Interpolation algorithm";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.tableView scrollToRowAtIndexPath:[self indexPathForType:self.timingFunctionType]
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];
}

@end
