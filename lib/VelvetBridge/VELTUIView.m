//
//  VELTUIView.m
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Emerald Lark. All rights reserved.
//

#import <TwUI/VELTUIView.h>
#import <TwUI/TUIView.h>

@implementation VELTUIView

#pragma mark Properties

@synthesize TUIView = m_TUIView;

- (void)setTUIView:(TUIView *)view {
    [self.layer addSublayer:view.layer];
    m_TUIView = view;
}

#pragma mark Lifecycle

- (id)initWithTUIView:(TUIView *)view {
	self = [super init];
	if (!self)
		return nil;

	self.TUIView = view;
	return self;
}

@end
