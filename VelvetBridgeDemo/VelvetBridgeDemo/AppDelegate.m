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
    VELTUIView *twuiHostView = [[VELTUIView alloc] initWithFrame:self.window.rootView.bounds];
    twuiHostView.autoresizingMask = VELViewAutoresizingFlexibleSize;

    #if 0
        twuiHostView.TUIView = [[TUIView alloc] initWithFrame:twuiHostView.bounds];

        TUITextView *textView = [[TUITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        textView.placeholder = @"Type some text?";
        textView.font = [TUIFont systemFontOfSize:17];
        [twuiHostView.TUIView addSubview:textView];
    #else
        TUIScrollView *scrollView = [[TUIScrollView alloc] initWithFrame:twuiHostView.bounds];
        scrollView.backgroundColor = [TUIColor colorWithWhite:0.9 alpha:1.0];
        scrollView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
        scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDark;

        twuiHostView.TUIView = scrollView;
    
        TUIImageView *imageView = [[TUIImageView alloc] initWithImage:[TUIImage imageNamed:@"large-image.jpeg"]];
        [scrollView addSubview:imageView];
        [scrollView setContentSize:imageView.frame.size];
    #endif

    TUIVelvetView *velvetHostView = [[TUIVelvetView alloc] initWithFrame:twuiHostView.TUIView.bounds];
    [twuiHostView.TUIView addSubview:velvetHostView];

    for (CGFloat offset = 0; offset < 200; offset += 50) {
        NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(250 + offset, 100 + offset, 80, 28)];
        [button setButtonType:NSMomentaryPushInButton];
        [button setBezelStyle:NSRoundedBezelStyle];
        [button setTitle:@"Test Button"];
        [button setTarget:self];
        [button setAction:@selector(testButtonPushed:)];
        
        VELNSView *buttonHostView = [[VELNSView alloc] initWithNSView:button];
        [velvetHostView.rootView addSubview:buttonHostView];
    }

    [self.window.rootView addSubview:twuiHostView];
}

- (void)testButtonPushed:(id)sender {
    NSLog(@"%s: %@", __func__, sender);
}

@end
