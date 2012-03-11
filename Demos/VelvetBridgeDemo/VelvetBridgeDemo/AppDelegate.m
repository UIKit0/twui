//
//  AppDelegate.m
//  VelvetBridgeDemo
//
//  Created by Justin Spahr-Summers on 11.01.12.
//  Copyright (c) 2012 Bitswift. All rights reserved.
//

#import "AppDelegate.h"
#import <TwUI/TUIKit.h>

@implementation AppDelegate
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    VELTUIView *twuiHostView = [[VELTUIView alloc] init];
    self.window.rootView = twuiHostView;

    TUIScrollView *scrollView = [[TUIScrollView alloc] initWithFrame:twuiHostView.bounds];
    scrollView.backgroundColor = [TUIColor colorWithWhite:0.9 alpha:1.0];
    scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDark;

    twuiHostView.guestView = scrollView;

    TUIImageView *imageView = [[TUIImageView alloc] initWithImage:[TUIImage imageNamed:@"large-image.jpeg"]];
    [scrollView addSubview:imageView];
    [scrollView setContentSize:imageView.frame.size];

    TUITextView *textView = [[TUITextView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    textView.placeholder = @"Type some text?";
    textView.font = [TUIFont boldSystemFontOfSize:17];
    textView.textColor = [TUIColor whiteColor];
    [scrollView addSubview:textView];

    VELClickEventRecognizer *clickRecognizer = [[VELClickEventRecognizer alloc] init];
    clickRecognizer.numberOfClicksRequired = 2;
    clickRecognizer.delaysEventDelivery = NO;
    clickRecognizer.view = scrollView;

    [clickRecognizer addActionUsingBlock:^(id clickRecognizer){
        if ([clickRecognizer isActive])
            NSLog(@"Event recognizer double-click at %@ in text view", NSStringFromPoint([clickRecognizer locationInView:textView]));
    }];

    TUIVelvetView *velvetHostView = [[TUIVelvetView alloc] initWithFrame:twuiHostView.guestView.bounds];
    velvetHostView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
    [twuiHostView.guestView addSubview:velvetHostView];

    for (CGFloat offset = 0; offset < 200; offset += 50) {
        NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(250 + offset, 100 + offset, 80, 28)];
        [button setButtonType:NSMomentaryPushInButton];
        [button setBezelStyle:NSRoundedBezelStyle];
        [button setTitle:@"Test Button"];
        [button setTarget:self];
        [button setAction:@selector(testButtonPushed:)];
        
        VELNSView *buttonHostView = [[VELNSView alloc] initWithNSView:button];
        [velvetHostView.guestView addSubview:buttonHostView];
    }
}

- (void)testButtonPushed:(id)sender {
    NSLog(@"%s: %@", __func__, sender);
}

@end
