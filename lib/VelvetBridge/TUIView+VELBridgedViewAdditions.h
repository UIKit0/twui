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

/*
 * Invoked any time an ancestor of the receiver has relaid itself out,
 * potentially moving or clipping the receiver relative to one of its ancestor
 * views.
 *
 * The default implementation forwards the message to all subviews.
 */
// TODO: should this be moved into VELBridgedView proper?
- (void)ancestorDidLayout;

@end
