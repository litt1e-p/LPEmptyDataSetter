//
//  ViewController.m
//  LPEmptyDataSetterSample
//
//  Created by litt1e-p on 16/4/11.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import "ViewController.h"
#import "LPEmptyDataSetter.h"
#import "Placeholder.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, weak) Placeholder *placeholder;
@property (nonatomic, assign, getter=hasLoaded) BOOL loaded;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self basicSetup];
    [self fetchData];
}

- (void)basicSetup
{
    self.title                             = @"LPEmptyDataSetterSample";
    self.loaded                            = YES;
    self.tableView.tableFooterView         = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(fetchData)];
    [LPEmptyDataSetter emptyDataSetWithTarget:self key:@"data" view:self.placeholder frame:[self frameForPlaceholder]];
}

#pragma mark - fetchData
- (void)fetchData
{
    [self reNewPlaceholderState:YES];
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    [self.data removeAllObjects];
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 2.f * NSEC_PER_SEC);
    dispatch_queue_t q = dispatch_get_main_queue();
    dispatch_after(t, q, ^{
        NSMutableArray *temp = [NSMutableArray array];
        if (!self.hasLoaded) {
            for (NSInteger i = 0; i < 25; i++) {
                [temp addObject:[NSString stringWithFormat:@"I am row:%zi", i]];
            }
        } else {
            [self reNewPlaceholderState:NO];
        }
//        [[self mutableArrayValueForKey:@"data"] addObjectsFromArray:temp];
        self.data             = temp;
        self.loaded           = !self.hasLoaded;
        self.indicator.hidden = YES;
        [self.indicator stopAnimating];
        [self.tableView reloadData];
    });
}

- (void)reNewPlaceholderState:(BOOL)loading
{
    UIImage *img   = nil;
    NSString *desc = nil;
    if (loading) {
        img  = [UIImage imageNamed:@"loadingCup"];
        desc = @"loading......";
    } else {
        img  = [UIImage imageNamed:@"emptyDataImg"];
        desc = @"tap to reload";
    }
    [self.placeholder setImage:img forState:UIControlStateNormal];
    [self.placeholder setTitle:desc forState:UIControlStateNormal];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ident       = [NSString stringWithFormat:@"row_num--%zi", indexPath.row + 1];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    if (self.data.count > 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row]];
    }
    return cell;
}

#pragma mark - lazy loads
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
    }
    return _data;
}

- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        UIActivityIndicatorView *indicator   = [[UIActivityIndicatorView alloc] init];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        indicator.center                     = CGPointMake(self.view.center.x, 20);
        indicator.hidden                     = YES;
        [self.tableView addSubview:indicator];
        _indicator                           = indicator;
    }
    return _indicator;
}

- (Placeholder *)placeholder
{
    if (!_placeholder) {
        Placeholder *placeholder = [Placeholder buttonWithType:UIButtonTypeCustom];
        [placeholder setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [placeholder addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventTouchUpInside];
        placeholder.frame = [self frameForPlaceholder];
        [self.view addSubview:placeholder];
        _placeholder = placeholder;
    }
    return _placeholder;
}

- (CGRect)frameForPlaceholder
{
    CGFloat x = [UIScreen mainScreen].bounds.size.width * 0.5 - 40;
    CGFloat y = [UIScreen mainScreen].bounds.size.height * 0.3;
    return CGRectMake(x, y, 80, 80);
}

@end
