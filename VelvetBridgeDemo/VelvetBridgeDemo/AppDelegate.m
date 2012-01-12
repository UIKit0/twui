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
    VELTUIView *twuiHostView = [[VELTUIView alloc] initWithFrame:CGRectMake(50, 50, 400, 400)];
    twuiHostView.TUIView = [[TUIView alloc] initWithFrame:twuiHostView.bounds];

    TUITextView *textView = [[TUITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    textView.placeholder = @"Type some text?";
    textView.font = [TUIFont systemFontOfSize:17];
    [twuiHostView.TUIView addSubview:textView];

    TUIVelvetView *velvetHostView = [[TUIVelvetView alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
    velvetHostView.backgroundColor = [TUIColor blueColor];
    [twuiHostView.TUIView addSubview:velvetHostView];

    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 80, 28)];
    [button setButtonType:NSMomentaryPushInButton];
    [button setBezelStyle:NSRoundedBezelStyle];
    [button setTitle:@"Test Button"];
    [button setTarget:self];
    [button setAction:@selector(testButtonPushed:)];
    
    VELNSView *buttonHostView = [[VELNSView alloc] initWithNSView:button];
    buttonHostView.backgroundColor = [NSColor redColor];
    [velvetHostView.rootView addSubview:buttonHostView];

    [self.window.rootView addSubview:twuiHostView];
}

- (void)testButtonPushed:(id)sender {
    NSLog(@"%s: %@", __func__, sender);
}

@end
