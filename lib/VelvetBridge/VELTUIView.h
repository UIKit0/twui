//
//  VELTUIView.h
//  Velvet
//
//  Created by Josh Vera on 11/21/11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import <Velvet/Velvet.h>
#import "TUIView+VELBridgedViewAdditions.h"

/**
 * A view that is responsible for displaying and handling a #TUIView within the
 * normal Velvet view hierarchy.
 */
@interface VELTUIView : VELView <VELHostView>

/**
 * @name Initialization
 */

/*
 * Initializes the receiver, setting its #guestView property to the given view.
 *
 * The \c frame of the receiver will automatically be set to that of \a view.
 *
 * The designated initializer for this class is \c init.
 *
 * @param view The view to display in the receiver.
 */
- (id)initWithTUIView:(TUIView *)view;

/**
 * @name Guest View
 */

/**
 * The #TUIView displayed by the reciever.
 *
 * You should not modify the geometry of this view. Modify the geometry of the
 * #VELTUIView instead.
 */
@property (nonatomic, strong) TUIView *guestView;
@end
