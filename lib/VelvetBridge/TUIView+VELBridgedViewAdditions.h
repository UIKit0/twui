//
//  TUIView+VELBridgedViewAdditions.h
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView.h"
#import <Velvet/Velvet.h>

/**
 * Implements support for the \c <VELBridgedView> protocol in #TUIView,
 * necessary to bridge with Velvet.
 */
@interface TUIView (VELBridgedViewAdditions) <VELBridgedView>

/**
 * @name Hit Testing
 */

/**
 * Hit tests the receiver's view hierarchy, returning the <VELBridgedView> which
 * is occupying the given point, or `nil` if there is no such view.
 *
 * This method only traverses views which are visible and allow user
 * interaction. Invoking this method ignores the default `hitTest:withEvent:`
 * logic as it is implemented in terms of itself.
 *
 * @param point A point, specified in the coordinate system of the receiver,
 * at which to look for a view.
 */
- (id<VELBridgedView>)descendantViewAtPoint:(NSPoint)point;

@end
