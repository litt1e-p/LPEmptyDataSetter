//
//  LPEmptyDataSetter.h
//
//  Created by litt1e-p on 16/4/5.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LPEmptyDataSetter : NSObject

/**
 *  LPEmptyDataSetter factory method to bind target & observe key
 *
 *  @param viewController viewController or viewController's subClass instance
 *  @param key            key for observing only NSKeyValueObservingOptionNew
 *  @param view           view for show when data set is empty
 *  @param frame          view's frame above
 */
+ (void)emptyDataSetWithTarget:(UIViewController *)viewController key:(NSString *)key view:(UIView *)view frame:(CGRect)frame;

@end

@interface UIViewController (EmptySetter)

@property (nonatomic, strong) LPEmptyDataSetter *emptySetter;

@end