//
//  TUIVelvetView.h
//  TwUI
//
//  Created by Justin Spahr-Summers on 03.12.11.
//  Copyright (c) 2011 Bitswift. All rights reserved.
//

#import "TUIView.h"
#import <Velvet/Velvet.h>

/**
 * A #TUIView that is used to host a \c VELView hierarchy.
 *
 * @warning **Important:** This class can only be used in view hierarchies that
 * are ultimately rooted at an \c NSVelvetView. Velvet views cannot be displayed
 * on screen in a pure TwUI hierarchy.
 */
@interface TUIVelvetView : TUIView <VELHostView>

/**
 * @name View Hierarchy
 */

/**
 * The root view of a Velvet hierarchy to display in the receiver.
 *
 * The value of this property is a plain \c VELView by default, but can be
 * replaced with another instance of \c VELView or any subclass.
 */
@property (nonatomic, strong) VELView *guestView;
@end
