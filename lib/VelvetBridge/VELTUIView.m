//
//  VELTUIView.m
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import <TwUI/VELTUIView.h>
#import <TwUI/TUIView.h>

@implementation VELTUIView

#pragma mark Properties

@synthesize TUIView = m_TUIView;

- (void)setTUIView:(TUIView *)view {
    [m_TUIView.layer removeFromSuperlayer];
    m_TUIView.nsView = nil;

    m_TUIView = view;

    if (m_TUIView) {
        m_TUIView.nsView = self.hostView;
        [self.layer addSublayer:m_TUIView.layer];
    }
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
