//
//  Placeholder.m
//  LPEmptyDataSetterSample
//
//  Created by litt1e-p on 16/4/12.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import "Placeholder.h"

@implementation Placeholder

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint center                            = self.imageView.center;
    center.x                                  = self.frame.size.width / 2;
    center.y                                  = self.imageView.frame.size.height / 2 + 5;
    self.imageView.center                     = center;
    CGRect newFrame                           = [self titleLabel].frame;
    newFrame.origin.x                         = 0;
    newFrame.origin.y                         = self.imageView.frame.size.height + 5;
    newFrame.size.width                       = self.frame.size.width;
    newFrame.size.height = self.frame.size.height - CGRectGetMaxY(self.imageView.frame) - 5;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.frame                     = newFrame;
    self.titleLabel.textAlignment             = NSTextAlignmentCenter;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
//    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
//    [self sizeToFit];
}

@end
