//
//  TUIVelvetView.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 03.12.11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import "TUIVelvetView.h"
#import "TUIScrollView.h"
#import "TUIView+VELTUIViewAdditions.h"
#import "VELTUIView.h"
#import <Velvet/Velvet.h>

@interface VELView (WritableHostViewFixup)
// TODO: this property needs to be exposed as writable _somewhere_ in Velvet
@property (nonatomic, strong) NSVelvetView *hostView;
@end

// TODO: move this category elsewhere
@interface TUIView (AncestorScrollView)
// TODO: this needs to be part of a Velvet protocol
- (id)ancestorScrollView;
@end

@implementation VELView (AncestorScrollViewFixup)
// TODO: there needs to be a more generic implementation for this method, which
// will go into Velvet proper
- (id)ancestorScrollView; {
    VELView *superview = self.superview;
    if (superview)
        return superview.ancestorScrollView;

    // TODO: this should use some hostView-like property set by TUIVelvetView
    if ([superview.nextResponder isKindOfClass:[TUIVelvetView class]]) {
        return [(id)superview.nextResponder ancestorScrollView];
    }

    return [self.hostView ancestorScrollView];
}
@end

@implementation TUIVelvetView

#pragma mark Properties

@synthesize rootView = m_rootView;

- (void)setRootView:(VELView *)rootView {
    [m_rootView.layer removeFromSuperlayer];
    m_rootView.hostView = nil;

    m_rootView = rootView;

    if (m_rootView) {
        [self.layer addSublayer:m_rootView.layer];

        m_rootView.hostView = self.hostView.hostView;

        // TODO: this will interact poorly with view controllers
        m_rootView.nextResponder = self;
    }
}

#pragma mark Lifecycle

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (!self)
        return nil;

    self.rootView = [[VELView alloc] initWithFrame:self.bounds];
    return self;
}

#pragma mark View hierarchy

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point {
    return [self.rootView descendantViewAtPoint:point];
}

- (void)didMoveToWindow; {
    TUIView *view = self;

    while (view && !view.hostView) {
        view = view.superview;
    }

    VELTUIView *hostView = view.hostView;
    NSAssert(hostView, @"%@ must be ultimately rooted in a VELTUIView", self);
    
    // TODO: it'd be nice if we could split this across willMove/didMove
    self.rootView.hostView = hostView.hostView;
}

#pragma mark NSObject overrides

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> frame = %@, VELView = %@", [self class], self, NSStringFromRect(self.frame), self.rootView];
}

@end

@implementation TUIView (AncestorScrollView)
- (id)ancestorScrollView; {
    TUIView *view = self;

    do {
        if ([view isKindOfClass:[TUIScrollView class]])
            return view;

        view = view.superview;
    } while (view);

    return [view.hostView ancestorScrollView];
}

@end
