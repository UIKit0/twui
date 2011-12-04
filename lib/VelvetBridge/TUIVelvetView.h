//
//  TUIVelvetView.h
//  TwUI
//
//  Created by Justin Spahr-Summers on 03.12.11.
//  Copyright (c) 2011 Emerald Lark. All rights reserved.
//

#import <TwUI/TUIView.h>
#import <Velvet/Velvet.h>

/**
 * A `TUIView` that is used to host a `VELView` hierarchy.
 */
@interface TUIVelvetView : TUIView

/**
 * @name View Hierarchy
 */

/**
 * The root view of a `VELView`-based hierarchy to display in the receiver.
 *
 * The value of this property is a plain `VELView` by default, but can be
 * replaced with another instance of `VELView` or any subclass.
 */
@property (nonatomic, strong) VELView *rootView;
@end
