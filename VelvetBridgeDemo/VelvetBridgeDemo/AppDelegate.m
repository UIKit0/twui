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
    TUITextView *textView = [[TUITextView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];

    VELTUIView *twuiHostView = [[VELTUIView alloc] initWithFrame:textView.frame];
    twuiHostView.TUIView = textView;

    [self.window.rootView addSubview:twuiHostView];
}

@end
