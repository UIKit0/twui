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

// TODO: we shouldn't have to import this for -ancestorDidLayout, which means
// that it should probably be part of <VELBridgedView>
#import <Velvet/VELViewProtected.h>

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
        m_guestView.frame = self.bounds;
        m_guestView.layer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;

        // TODO: this will interact poorly with view controllers
        m_guestView.nextResponder = self;

        [self.layer addSublayer:m_guestView.layer];
        m_guestView.hostView = self;
    }
}

#pragma mark Lifecycle

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (!self)
        return nil;

    self.guestView = [[VELView alloc] init];
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

- (void)didMoveFromNSVelvetView:(NSVelvetView *)view; {
    [super didMoveFromNSVelvetView:view];
    [self.guestView didMoveFromNSVelvetView:view];
}

- (void)willMoveToNSVelvetView:(NSVelvetView *)view; {
    [super willMoveToNSVelvetView:view];
    [self.guestView willMoveToNSVelvetView:view];
}

#pragma mark Event handling

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point {
    CGPoint viewPoint = [self.guestView.layer convertPoint:point fromLayer:self.layer];
    
    // never return 'self', since we don't want to catch clicks that didn't
    // directly hit the VELView
    return [self.guestView descendantViewAtPoint:viewPoint];
}

- (TUIView *)hitTest:(CGPoint)point withEvent:(id)event {
    // don't catch TwUI events on this view
    return nil;
}

#pragma mark NSObject overrides

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> frame = %@, VELView = %@", [self class], self, NSStringFromRect(self.frame), self.guestView];
}

@end
