//
//  VELTUIViewTests.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 15.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "VELTUIViewTests.h"
#import <TwUI/TUIKit.h>
#import <Cocoa/Cocoa.h>

@interface VELTUIViewTests ()
@property (nonatomic, strong) VELWindow *window;
@end

@implementation VELTUIViewTests
@synthesize window = m_window;

- (void)setUp {
    self.window = [[VELWindow alloc] initWithContentRect:CGRectMake(100, 100, 500, 500)];
}

- (void)tearDown {
    self.window = nil;
}

- (void)testInitialization {
    VELTUIView *view = [[VELTUIView alloc] init];
    STAssertNotNil(view, @"");
}

- (void)testSettingAsRootView {
    self.window.rootView = [[VELTUIView alloc] init];
}

- (void)testConformsToVELBridgedView {
    STAssertTrue([VELTUIView conformsToProtocol:@protocol(VELBridgedView)], @"");

    VELTUIView *view = [[VELTUIView alloc] init];
    STAssertTrue([view conformsToProtocol:@protocol(VELBridgedView)], @"");
}

- (void)testConformsToVELHostView {
    STAssertTrue([VELTUIView conformsToProtocol:@protocol(VELHostView)], @"");

    VELTUIView *view = [[VELTUIView alloc] init];
    STAssertTrue([view conformsToProtocol:@protocol(VELHostView)], @"");
}

- (void)testAncestorNSVelvetView {
    VELTUIView *view = [[VELTUIView alloc] initWithFrame:CGRectZero];
    [self.window.rootView addSubview:view];

    STAssertEquals(view.ancestorNSVelvetView, self.window.contentView, @"");
}

- (void)testDescendantViewAtPoint {
    VELTUIView *hostView = [[VELTUIView alloc] init];
    self.window.rootView = hostView;

    hostView.guestView = [[TUIView alloc] initWithFrame:CGRectZero];

    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(50, 30, 100, 150)];
    [hostView.guestView addSubview:view];

    CGPoint guestSubviewPoint = CGPointMake(51, 31);
    STAssertEquals([hostView descendantViewAtPoint:guestSubviewPoint], view, @"");

    CGPoint guestViewPoint = CGPointMake(49, 29);
    STAssertEquals([hostView descendantViewAtPoint:guestViewPoint], hostView.guestView, @"");

    CGPoint outsidePoint = CGPointMake(49, 1000);
    STAssertNil([hostView descendantViewAtPoint:outsidePoint], @"");
}

- (void)testGuestView {
    VELTUIView *hostView = [[VELTUIView alloc] init];

    TUIScrollView *scrollView = [[TUIScrollView alloc] initWithFrame:CGRectZero];
    hostView.guestView = scrollView;

    STAssertEquals(hostView.guestView, scrollView, @"");
}

@end
