//
//  TUIView+VELTUIViewAdditions.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIView+VELTUIViewAdditions.h"
#import "VELTUIView.h"
#import <Proton/Proton.h>

@safecategory (TUIView, VELTUIViewAdditions)

#pragma mark Properties

- (VELTUIView *)hostView {
    return objc_getAssociatedObject(self, @selector(hostView));
}

- (void)setHostView:(VELTUIView *)hostView {
    objc_setAssociatedObject(self, @selector(hostView), hostView, OBJC_ASSOCIATION_ASSIGN);
}

@end
