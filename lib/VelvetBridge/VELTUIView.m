//
//  VELTUIView.m
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import "VELTUIView.h"
#import "TUIView.h"
#import "TUIView+VELBridgedViewAdditions.h"
#import <Velvet/VELViewProtected.h>

@implementation VELTUIView

#pragma mark Properties

@synthesize guestView = m_guestView;

- (void)setGuestView:(TUIView *)view {
    [m_guestView.layer removeFromSuperlayer];
    m_guestView.nsView = nil;
    m_guestView.hostView = nil;

    m_guestView = view;

    if (m_guestView) {
        m_guestView.frame = self.bounds;
        m_guestView.layer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;

        m_guestView.nsView = self.ancestorNSVelvetView;
        m_guestView.nextResponder = self;

        [self.layer addSublayer:m_guestView.layer];
        m_guestView.hostView = self;
    }
}

#pragma mark Lifecycle

- (id)initWithTUIView:(TUIView *)view {
    self = [super init];
    if (!self)
        return nil;

    // order here is important -- self.guestView will reset the frame, so we
    // need to update self.frame before that
    self.frame = view.frame;
    self.guestView = view;
    return self;
}

- (void)dealloc {
    self.guestView.hostView = nil;
}

#pragma mark View hierarchy

- (void)ancestorDidLayout; {
    [super ancestorDidLayout];
    [self.guestView ancestorDidLayout];
}

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point {
    CGPoint viewPoint = [self.guestView.layer convertPoint:point fromLayer:self.layer];
    return [self.guestView descendantViewAtPoint:viewPoint];
}

- (void)didMoveFromNSVelvetView:(NSVelvetView *)view; {
    [super didMoveFromNSVelvetView:view];

    [self.guestView didMoveFromNSVelvetView:view];
    self.guestView.nsView = self.ancestorNSVelvetView;
}

- (void)willMoveToNSVelvetView:(NSVelvetView *)view; {
    [super willMoveToNSVelvetView:view];
    [self.guestView willMoveToNSVelvetView:view];
}

#pragma mark NSObject overrides

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> frame = %@, TUIView = %@ %@", [self class], self, NSStringFromRect(self.frame), self.guestView, NSStringFromRect(self.guestView.frame)];
}

@end
