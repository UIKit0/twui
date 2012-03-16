//
//  TUIScrollView+VELScrollViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 29.02.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIScrollView+VELScrollViewAdditions.h"
#import "TUIView+VELBridgedViewAdditions.h"
#import <objc/runtime.h>

@implementation TUIScrollView (VELScrollViewAdditions)

#pragma mark VELBridgedView

// implemented by TUIView
@dynamic layer;
@dynamic hostView;
@dynamic focused;

#pragma mark VELScrollView

- (void)scrollToPoint:(CGPoint)point; {
    [self setContentOffset:point animated:YES];
}

- (void)scrollToIncludeRect:(CGRect)rect; {
    [self scrollRectToVisible:rect animated:YES];
}

@end
