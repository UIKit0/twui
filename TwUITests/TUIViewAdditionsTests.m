//
//  TUIViewAdditionsTests.m
//  TwUI
//
//  Created by Justin Spahr-Summers on 15.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "TUIViewAdditionsTests.h"
#import <TwUI/TUIKit.h>
#import <Cocoa/Cocoa.h>

@interface TUIViewAdditionsTests ()
@property (nonatomic, strong) VELWindow *window;
@property (nonatomic, strong, readonly) VELTUIView *hostView;
@end

@implementation TUIViewAdditionsTests
@synthesize window = m_window;

- (VELTUIView *)hostView {
    return (id)self.window.rootView;
}

- (void)setUp {
    self.window = [[VELWindow alloc] initWithContentRect:CGRectMake(100, 100, 500, 500)];
    self.window.rootView = [[VELTUIView alloc] init];
    self.hostView.guestView = [[TUIView alloc] init];
}

- (void)tearDown {
    self.window = nil;
}

- (void)testConformsToVELBridgedView {
    STAssertTrue([TUIView conformsToProtocol:@protocol(VELBridgedView)], @"");

    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    STAssertTrue([view conformsToProtocol:@protocol(VELBridgedView)], @"");
}

- (void)testConvertFromWindowPoint {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(20, 50, 100, 200)];
    [self.hostView.guestView addSubview:view];

    CGPoint point = CGPointMake(125, 255);
    STAssertTrue(CGPointEqualToPoint([view convertFromWindowPoint:point], [view convertPoint:point fromView:nil]), @"");
}

- (void)testConvertToWindowPoint {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(20, 50, 100, 200)];
    [self.hostView.guestView addSubview:view];

    CGPoint point = CGPointMake(125, 255);
    STAssertTrue(CGPointEqualToPoint([view convertToWindowPoint:point], [view convertPoint:point toView:nil]), @"");
}

- (void)testConvertFromWindowRect {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(20, 50, 100, 200)];
    [self.hostView.guestView addSubview:view];

    CGRect rect = CGRectMake(30, 60, 145, 275);
    STAssertTrue(CGRectEqualToRect([view convertToWindowRect:rect], [view convertRect:rect toView:nil]), @"");
}

- (void)testConvertToWindowRect {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(20, 50, 100, 200)];
    [self.hostView.guestView addSubview:view];

    CGRect rect = CGRectMake(30, 60, 145, 275);
    STAssertTrue(CGRectEqualToRect([view convertFromWindowRect:rect], [view convertRect:rect fromView:nil]), @"");
}

- (void)testLayer {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    STAssertNotNil(view.layer, @"");
}

- (void)testHostView {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];

    STAssertNil(view.hostView, @"");

    VELTUIView *hostView = [[VELTUIView alloc] init];
    view.hostView = hostView;

    STAssertEquals(view.hostView, hostView, @"");
}

- (void)testAncestorDidLayout {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    STAssertNoThrow([view ancestorDidLayout], @"");
}

- (void)testAncestorNSVelvetView {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    [self.hostView.guestView addSubview:view];

    STAssertEquals(view.ancestorNSVelvetView, self.window.contentView, @"");
}

- (void)testAncestorScrollView {
    TUIScrollView *scrollView = [[TUIScrollView alloc] initWithFrame:CGRectZero];
    STAssertEquals(scrollView.ancestorScrollView, scrollView, @"");

    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    [scrollView addSubview:view];

    STAssertEquals(view.ancestorScrollView, scrollView, @"");
}

- (void)testWillMoveToNSVelvetView {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    STAssertNoThrow([view willMoveToNSVelvetView:nil], @"");
}

- (void)testDidMoveFromNSVelvetView {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectZero];
    STAssertNoThrow([view didMoveFromNSVelvetView:nil], @"");
}

- (void)testDescendantViewAtPoint {
    TUIView *superview = [[TUIView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];

    TUIView *subview = [[TUIView alloc] initWithFrame:CGRectMake(50, 30, 100, 150)];
    [superview addSubview:subview];

    CGPoint subviewPoint = CGPointMake(51, 31);
    STAssertEquals([superview descendantViewAtPoint:subviewPoint], subview, @"");

    CGPoint superviewPoint = CGPointMake(49, 29);
    STAssertEquals([superview descendantViewAtPoint:superviewPoint], superview, @"");

    CGPoint outsidePoint = CGPointMake(49, 200);
    STAssertNil([superview descendantViewAtPoint:outsidePoint], @"");
}

- (void)testPointInside {
    TUIView *view = [[TUIView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];

    CGPoint insidePoint = CGPointMake(51, 31);
    STAssertTrue([view pointInside:insidePoint], @"");

    CGPoint outsidePoint = CGPointMake(49, 200);
    STAssertFalse([view pointInside:outsidePoint], @"");
}

@end
