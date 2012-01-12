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
    TUITextView *textView = [[TUITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    textView.placeholder = @"Type some text?";
    textView.font = [TUIFont systemFontOfSize:17];

    VELTUIView *twuiHostView = [[VELTUIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    twuiHostView.TUIView = textView;

    [self.window.rootView addSubview:twuiHostView];
}

@end
