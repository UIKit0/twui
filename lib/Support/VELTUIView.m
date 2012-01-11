//
//  VELTUIView.m
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import "VELTUIView.h"
#import "TUIView.h"

@implementation VELTUIView
@synthesize TUIView = m_TUIView;

- (void)setTUIView:(TUIView *)view {
    [self.layer addSublayer:view.layer];
    m_TUIView = view;
}

- (id)initWithTUIView:(TUIView *)view {
	self = [super init];
	if (!self)
		return nil;

	self.TUIView = view;
	return self;

}

@end
