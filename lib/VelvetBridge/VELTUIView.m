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

@interface VELTUIView () {
    #ifdef DEBUG
    /**
     * An observer for \c VELHostViewDebugModeChangedNotification.
     */
    id m_hostViewDebugModeObserver;
    #endif
}

@end

@implementation VELTUIView

#pragma mark Properties

@synthesize guestView = m_guestView;

- (void)setGuestView:(TUIView *)view {
    [CATransaction performWithDisabledActions:^{
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
    }];
}

#pragma mark Lifecycle

- (id)init {
    self = [super init];
    if (!self)
        return nil;

    #ifdef DEBUG
    CALayer *debugModeLayer = [CALayer layer];
    debugModeLayer.backgroundColor = [NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.1].CGColor;
    debugModeLayer.borderColor = [NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.75].CGColor;
    debugModeLayer.borderWidth = 3;
    debugModeLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    debugModeLayer.zPosition = 100000;

    m_hostViewDebugModeObserver = [[NSNotificationCenter defaultCenter]
        addObserverForName:VELHostViewDebugModeChangedNotification
        object:nil
        queue:[NSOperationQueue mainQueue]
        usingBlock:^(NSNotification *notification){
            BOOL enabled = [[notification.userInfo objectForKey:VELHostViewDebugModeIsEnabledKey] boolValue];

            if (enabled) {
                debugModeLayer.frame = self.bounds;
                [self.layer addSublayer:debugModeLayer];
            } else {
                [debugModeLayer removeFromSuperlayer];
            }
        }
    ];
    #endif

    return self;
}

- (id)initWithTUIView:(TUIView *)view {
    self = [self init];
    if (!self)
        return nil;

    // order here is important -- self.guestView will reset the frame, so we
    // need to update self.frame before that
    self.frame = view.frame;
    self.guestView = view;
    return self;
}

- (void)dealloc {
    #ifdef DEBUG
    if (m_hostViewDebugModeObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:m_hostViewDebugModeObserver];
        m_hostViewDebugModeObserver = nil;
    }
    #endif

    self.guestView.hostView = nil;
}

#pragma mark View hierarchy

- (void)ancestorDidLayout; {
    [super ancestorDidLayout];
    [self.guestView ancestorDidLayout];
}

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point {
    CGPoint viewPoint = [self.guestView.layer convertPoint:point fromLayer:self.layer];

    // never return 'self', since we don't want to catch clicks that didn't
    // directly hit the TUIView
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

- (void)viewHierarchyDidChange; {
    [super viewHierarchyDidChange];
    [self.guestView viewHierarchyDidChange];
}

#pragma mark NSObject overrides

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> frame = %@, TUIView = %@ %@", [self class], self, NSStringFromRect(self.frame), self.guestView, NSStringFromRect(self.guestView.frame)];
}

@end
