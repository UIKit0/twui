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
@end
