//
//  TUIVelvetView.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 03.12.11.
//  Copyright (c) 2011 Emerald Lark. All rights reserved.
//

#import <TwUI/TUIVelvetView.h>

@implementation TUIVelvetView

#pragma mark Properties

@synthesize rootView = m_rootView;

- (void)setRootView:(VELView *)rootView {
    [m_rootView.layer removeFromSuperlayer];
    m_rootView = rootView;

    if (m_rootView) {
        [self.layer addSublayer:m_rootView.layer];
    }
}

#pragma mark Lifecycle

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (!self)
        return nil;

    return self;
}

@end
