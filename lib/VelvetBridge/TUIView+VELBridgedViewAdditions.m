//
//  TUIView+VELBridgedViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView+VELBridgedViewAdditions.h"
#import "TUIVelvetView.h"
#import <Proton/Proton.h>

@safecategory (TUIView, VELBridgedViewAdditions)
// TODO: the implementations of these conversion methods are not strictly
// correct -- they only take into account position, and do not include things
// like transforms (however, the implementation does match that of TwUI)

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
    CGPoint superviewPoint = [self convertPoint:point toView:self.superview];
    id hitView = [self hitTest:superviewPoint withEvent:nil];

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
