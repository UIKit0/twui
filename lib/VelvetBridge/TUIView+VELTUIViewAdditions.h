//
//  TUIView+VELTUIViewAdditions.h
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView.h"

@class VELTUIView;

/*
 * Private extensions to #TUIView to support hosting by #VELTUIView.
 */
@interface TUIView (VELTUIViewAdditions)

/*
 * The #VELTUIView that is hosting this view, or `nil` if it exists
 * independently of a Velvet hierarchy.
 */
@property (unsafe_unretained) VELTUIView *hostView;

@end
