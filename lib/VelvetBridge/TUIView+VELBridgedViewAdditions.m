//
//  TUIView+VELBridgedViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView+VELBridgedViewAdditions.h"
#import "TUIVelvetView.h"
#import "VELTUIView.h"
#import <objc/runtime.h>

@implementation TUIView (VELBridgedViewAdditions)

#pragma mark Properties

// implemented by TUIView proper
@dynamic layer;

#pragma mark Category loading

+ (void)load {
    class_addProtocol([TUIView class], @protocol(VELBridgedView));
}

#pragma mark Geometry

// TODO: the implementations of these conversion methods are not strictly
// correct -- they only take into account position, and do not include things
// like transforms (however, the implementation does match that of TwUI)

- (CGPoint)convertFromWindowPoint:(CGPoint)point; {
    if (self.hostView) {
        CGPoint pointInHostView = [self.hostView convertFromWindowPoint:point];
        return [self.layer convertPoint:pointInHostView fromLayer:self.hostView.layer];
    }

    CGRect hostViewFrame = self.frameInNSView;

    CGPoint pointInHostView = [self.nsView convertPoint:point fromView:nil];
    return CGPointMake(pointInHostView.x - hostViewFrame.origin.x, pointInHostView.y - hostViewFrame.origin.y);
}

- (CGPoint)convertToWindowPoint:(CGPoint)point; {
    if (self.hostView) {
        CGPoint pointInHostView = [self.layer convertPoint:point toLayer:self.hostView.layer];
        return [self.hostView convertToWindowPoint:pointInHostView];
    }

    CGRect hostViewFrame = self.frameInNSView;

    CGPoint pointInHostView = CGPointMake(point.x + hostViewFrame.origin.x, point.y + hostViewFrame.origin.y);
    return [self.nsView convertPoint:pointInHostView toView:nil];
}

- (CGRect)convertFromWindowRect:(CGRect)rect; {
    if (self.hostView) {
        CGRect rectInHostView = [self.hostView convertFromWindowRect:rect];
        return [self.layer convertRect:rectInHostView fromLayer:self.hostView.layer];
    }

    CGRect hostViewFrame = self.frameInNSView;

    CGRect rectInHostView = [self.nsView convertRect:rect fromView:nil];
    return CGRectOffset(rectInHostView, -hostViewFrame.origin.x, -hostViewFrame.origin.y);
}

- (CGRect)convertToWindowRect:(CGRect)rect; {
    if (self.hostView) {
        CGRect rectInHostView = [self.layer convertRect:rect toLayer:self.hostView.layer];
        return [self.hostView convertToWindowRect:rectInHostView];
    }

    CGRect hostViewFrame = self.frameInNSView;

    CGRect rectInHostView = CGRectOffset(rect, hostViewFrame.origin.x, hostViewFrame.origin.y);
    return [self.nsView convertRect:rectInHostView toView:nil];
}

#pragma mark Hit testing

- (id<VELBridgedView>)descendantViewAtPoint:(NSPoint)point {
    // Clip to self
    if (!self.userInteractionEnabled || self.hidden || ![self pointInside:point] || self.alpha <= 0.0f)
        return nil;

    __block id<VELBridgedView> result = self;

    [self.subviews
        enumerateObjectsUsingBlock:^(TUIView *view, NSUInteger index, BOOL *stop){
            CGPoint subviewPoint = [view convertPoint:point fromView:self];

            id<VELBridgedView> hitTestedView = [view descendantViewAtPoint:subviewPoint];
            if (hitTestedView) {
                result = hitTestedView;
                *stop = YES;
            }
    }];

    return result;
}

- (BOOL)pointInside:(CGPoint)point; {
    return [self pointInside:point withEvent:nil];
}

#pragma mark View hierarchy

- (id<VELHostView>)hostView {
    id<VELHostView> hostView = objc_getAssociatedObject(self, @selector(hostView));
    if (hostView)
        return hostView;
    else
        return self.superview.hostView;
}

- (id<VELBridgedView>)immediateParentView {
    id<VELHostView> hostView = objc_getAssociatedObject(self, @selector(hostView));
    if (hostView)
        return hostView;
    else
        return self.superview;
}

- (void)setHostView:(id<VELHostView>)hostView {
    objc_setAssociatedObject(self, @selector(hostView), hostView, OBJC_ASSOCIATION_ASSIGN);

    [self viewHierarchyDidChange];
}

- (void)ancestorDidLayout; {
    [self.subviews makeObjectsPerformSelector:_cmd];
}

- (NSVelvetView *)ancestorNSVelvetView; {
    id<VELHostView> hostView = self.hostView;
    if (!hostView)
        return nil;

    return hostView.ancestorNSVelvetView;
}

- (id<VELScrollView>)ancestorScrollView; {
    if ([self conformsToProtocol:@protocol(VELScrollView)])
        return (id)self;

    TUIView *superview = self.superview;
    if (superview)
        return superview.ancestorScrollView;

    return self.hostView.ancestorScrollView;
}

- (void)didMoveFromNSVelvetView:(NSVelvetView *)view; {
    [self.subviews makeObjectsPerformSelector:_cmd withObject:view];
}

- (void)willMoveToNSVelvetView:(NSVelvetView *)view; {
    [self.subviews makeObjectsPerformSelector:_cmd withObject:view];
}

- (void)viewHierarchyDidChange; {
    [self.subviews makeObjectsPerformSelector:_cmd];
}

- (BOOL)isFocused {
    return [objc_getAssociatedObject(self, @selector(isFocused)) boolValue];
}

- (void)setFocused:(BOOL)focused {
    objc_setAssociatedObject(self, @selector(isFocused), [NSNumber numberWithBool:focused], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    for (TUIView *view in self.subviews) {
        view.focused = focused;
    }
}

@end

