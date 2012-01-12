//
//  TUIVelvetView.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 03.12.11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import "TUIVelvetView.h"
#import "TUIScrollView.h"
#import "TUIView+VELBridgedViewAdditions.h"
#import "VELTUIView.h"

@implementation TUIVelvetView

#pragma mark Properties

// implemented by TUIView
@dynamic layer;

@synthesize hostView = m_hostView;
@synthesize guestView = m_guestView;

- (id<VELHostView>)hostView {
    if (m_hostView)
        return m_hostView;
    else
        return self.superview.hostView;
}

- (void)setGuestView:(VELView *)guestView {
    [m_guestView.layer removeFromSuperlayer];
    m_guestView.hostView = nil;

    m_guestView = guestView;

    if (m_guestView) {
        [self.layer addSublayer:m_guestView.layer];

        // only notify the guest view of a new host view once it has a window
        //
        // TODO: this check should not be necessary
        if (self.nsWindow)
            m_guestView.hostView = self;

        // TODO: this will interact poorly with view controllers
        m_guestView.nextResponder = self;
    }
}

#pragma mark Lifecycle

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (!self)
        return nil;

    self.guestView = [[VELView alloc] initWithFrame:self.bounds];
    return self;
}

- (void)dealloc {
    self.guestView.hostView = nil;
}

#pragma mark View hierarchy

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point {
    CGPoint viewPoint = [self.guestView.layer convertPoint:point fromLayer:self.layer];
    return [self.guestView descendantViewAtPoint:viewPoint];
}

- (void)didMoveToWindow {
    // only notify the guest view of a new host view once it has a window
    //
    // TODO: we should call some notification method instead of setting this
    // property
    self.guestView.hostView = self;
}

#pragma mark NSObject overrides

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> frame = %@, VELView = %@", [self class], self, NSStringFromRect(self.frame), self.guestView];
}

@end
