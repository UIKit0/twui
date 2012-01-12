//
//  TUIView+VELBridgedViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView+VELBridgedViewAdditions.h"
#import "TUIView+VELTUIViewAdditions.h"
#import "TUIVelvetView.h"
#import "VELTUIView.h"
#import <Proton/Proton.h>

@safecategory (TUIView, VELBridgedViewAdditions)
// TODO: the implementations of these conversion methods are not strictly
// correct -- they only take into account position, and do not include things
// like transforms (however, the implementation does match that of TwUI)

// TODO 2: these geometry conversion methods should use the hostView if no
// superview is available

- (CGPoint)convertFromWindowPoint:(CGPoint)point; {
	CGRect hostViewFrame = self.frameInNSView;

	CGPoint pointInHostView = [self.nsView convertPoint:point fromView:nil];
	return CGPointMake(pointInHostView.x - hostViewFrame.origin.x, pointInHostView.y - hostViewFrame.origin.y);
}

- (CGPoint)convertToWindowPoint:(CGPoint)point; {
	CGRect hostViewFrame = self.frameInNSView;

    CGPoint pointInHostView = CGPointMake(point.x + hostViewFrame.origin.x, point.y + hostViewFrame.origin.y);
    return [self.nsView convertPoint:pointInHostView toView:nil];
}

- (CGRect)convertFromWindowRect:(CGRect)rect; {
	CGRect hostViewFrame = self.frameInNSView;

	CGRect rectInHostView = [self.nsView convertRect:rect fromView:nil];
	return CGRectOffset(rectInHostView, -hostViewFrame.origin.x, -hostViewFrame.origin.y);
}

- (CGRect)convertToWindowRect:(CGRect)rect; {
	CGRect hostViewFrame = self.frameInNSView;

    CGRect rectInHostView = CGRectOffset(rect, hostViewFrame.origin.x, hostViewFrame.origin.y);
    return [self.nsView convertRect:rectInHostView toView:nil];
}

- (id<VELBridgedView>)descendantViewAtPoint:(CGPoint)point; {
    CGPoint framePoint;

    if (self.superview)
        framePoint = [self convertPoint:point toView:self.superview];
    else if (self.hostView)
        framePoint = point;
    else
        return nil;

    id hitView = [self hitTest:framePoint withEvent:nil];

    if ([hitView isKindOfClass:[TUIVelvetView class]]) {
        CGPoint descendantPoint = [self convertPoint:point toView:hitView];
        return [hitView descendantViewAtPoint:descendantPoint];
    }

    return hitView;
}

- (BOOL)pointInside:(CGPoint)point; {
    return [self pointInside:point withEvent:nil];
}

@end
