//
//  LPEmptySetter.m
//
//  Created by litt1e-p on 16/4/5.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import <objc/runtime.h>
#import "LPEmptyDataSetter.h"

#define IsVoidStr(_ref) (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref)isEqualToString:@""]))
#define IsVoidArr(_ref) (((_ref) == nil) || ([(_ref) isKindOfClass:[NSNull class]]) || ((_ref).count == 0))
#define IsVoidDict(_ref) ([(_ref) allKeys].count == 0)

@interface LPEmptyDataSetter ()

@property (nonatomic, copy) NSString *observeKey;
@property (nonatomic, strong) UIView *emptySetView;
@property (nonatomic, assign) CGRect emptySetViewFrame;
@property (nonatomic, strong) UIViewController *target;

@end

@implementation LPEmptyDataSetter

+ (void)emptyDataSetWithTarget:(UIViewController *)viewController key:(NSString *)key view:(UIView *)view frame:(CGRect)frame
{
    if (viewController && view) {
        LPEmptyDataSetter *setter  = [[self alloc] init];
        setter.target              = viewController;
        setter.observeKey          = key;
        setter.emptySetView        = view;
        setter.emptySetViewFrame   = frame;
        viewController.emptySetter = setter;
    }
}

- (void)setEmptySetViewFrame:(CGRect)emptySetViewFrame
{
    _emptySetViewFrame = emptySetViewFrame;
    if (self.emptySetView && ![self.target.view.subviews containsObject:self.emptySetView]) {
        [self.target.view addSubview:self.emptySetView];
        self.emptySetView.frame = emptySetViewFrame;
    }
}

- (void)renderEmptySetView:(BOOL)display
{
    if (display) {
        [self.target.view bringSubviewToFront:self.emptySetView];
    } else {
        [self.target.view sendSubviewToBack:self.emptySetView];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:self.observeKey]) {
        return;
    }
    BOOL display = NO;
    id set       = [self.target valueForKey:self.observeKey];
    if ([set isKindOfClass:[NSArray class]] || [set isKindOfClass:[NSMutableArray class]]) {
        NSArray *setArr = set;
        display         = IsVoidArr(setArr);
    } else if ([set isKindOfClass:[NSDictionary class]] || [set isKindOfClass:[NSMutableDictionary class]]) {
        NSDictionary *setDict = set;
        display               = IsVoidDict(setDict);
    } else {
        display = set;
    }
    [self renderEmptySetView:display];
}

- (void)setObserveKey:(NSString *)observeKey
{
    if (!IsVoidStr(_observeKey)) {
        [self removeObserveKey:_observeKey];
    }
    _observeKey = observeKey;
    if (!IsVoidStr(observeKey)) {
        [self.target addObserver:self forKeyPath:observeKey options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)removeObserveKey:(NSString *)key
{
    [self.target removeObserver:self forKeyPath:key];
}

- (void)dealloc
{
    [self removeObserveKey:self.observeKey];
}

@end

@implementation UIViewController (EmptySetter)

- (LPEmptyDataSetter *)emptySetter
{
    return objc_getAssociatedObject(self, @selector(emptySetter));
}

- (void)setEmptySetter:(LPEmptyDataSetter *)emptySetter
{
    objc_setAssociatedObject(self, @selector(emptySetter), emptySetter, OBJC_ASSOCIATION_RETAIN);
}

@end
