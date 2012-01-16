//
//  TUIVelvetViewTests.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 15.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIVelvetViewTests.h"
#import <TwUI/TUIKit.h>
#import <Cocoa/Cocoa.h>

@interface TUIVelvetViewTests ()
@property (nonatomic, strong) VELWindow *window;
@property (nonatomic, strong, readonly) VELTUIView *hostView;
@end

@implementation TUIVelvetViewTests
@synthesize window = m_window;

- (VELTUIView *)hostView {
    return (id)self.window.rootView;
}

- (void)setUp {
    self.window = [[VELWindow alloc] initWithContentRect:CGRectMake(100, 100, 500, 500)];
    self.window.rootView = [[VELTUIView alloc] init];
}

- (void)tearDown {
    self.window = nil;
}

- (void)testGuestView {
    TUIVelvetView *hostView = [[TUIVelvetView alloc] initWithFrame:CGRectZero];
    STAssertNotNil(hostView.guestView, @"");

    VELImageView *imageView = [[VELImageView alloc] init];
    hostView.guestView = imageView;

    STAssertEquals(hostView.guestView, imageView, @"");
}

- (void)testConformsToVELBridgedView {
    STAssertTrue([TUIVelvetView conformsToProtocol:@protocol(VELBridgedView)], @"");

    TUIVelvetView *view = [[TUIVelvetView alloc] initWithFrame:CGRectZero];
    STAssertTrue([view conformsToProtocol:@protocol(VELBridgedView)], @"");
}

- (void)testConformsToVELHostView {
    STAssertTrue([TUIVelvetView conformsToProtocol:@protocol(VELHostView)], @"");

    TUIVelvetView *view = [[TUIVelvetView alloc] initWithFrame:CGRectZero];
    STAssertTrue([view conformsToProtocol:@protocol(VELHostView)], @"");
}

- (void)testDescendantViewAtPoint {
    TUIVelvetView *velvetView = [[TUIVelvetView alloc] initWithFrame:CGRectZero];
    self.hostView.guestView = velvetView;

    VELView *view = [[VELView alloc] initWithFrame:CGRectMake(50, 30, 100, 150)];
    [velvetView.guestView addSubview:view];

    CGPoint guestSubviewPoint = CGPointMake(51, 31);
    STAssertEquals([velvetView descendantViewAtPoint:guestSubviewPoint], view, @"");

    CGPoint guestViewPoint = CGPointMake(49, 29);
    STAssertEquals([velvetView descendantViewAtPoint:guestViewPoint], velvetView.guestView, @"");

    CGPoint outsidePoint = CGPointMake(49, 1000);
    STAssertNil([velvetView descendantViewAtPoint:outsidePoint], @"");
}

@end
