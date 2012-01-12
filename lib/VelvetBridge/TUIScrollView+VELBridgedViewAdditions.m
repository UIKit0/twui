//
//  TUIScrollView+VELBridgedViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 12.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIScrollView+VELBridgedViewAdditions.h"

@implementation TUIScrollView (VELBridgedViewAdditions)

- (id<VELBridgedView>)ancestorScrollView; {
    return self;
}

@end
