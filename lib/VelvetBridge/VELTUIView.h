//
//  VELTUIView.h
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Emerald Lark. All rights reserved.
//

#import <Velvet/Velvet.h>

@class TUIView;

/**
 * A view that is responsible for displaying and handling a `TUIView` within the
 * normal Velvet view hierarchy.
 */
@interface VELTUIView : VELView

/**
 * @name Initialization
 */

/*
 * Initializes the receiver, setting its <TUIView> property to `view`.
 *
 * The designated initializer for this class is <[VELView init]>.
 */
- (id)initWithTUIView:(TUIView *)view;

/**
 * @name TUIView Hierarchy
 */

/**
 * The view displayed by the reciever.
 */
@property (nonatomic, strong) TUIView *TUIView;
@end
