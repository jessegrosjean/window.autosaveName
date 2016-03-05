//
//  SplitViewController.m
//  Test
//
//  Created by Jesse Grosjean on 3/3/16.
//  Copyright © 2016 Jesse Grosjean. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController ()

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    self.splitView.autosaveName = @"Split View Controller";
    
    if ([[NSProcessInfo processInfo] operatingSystemVersion].minorVersion >= 11) {
        NSSplitViewItem *sidebarSplitViewItem = self.splitViewItems[0];
        NSSplitViewItem *contentSplitViewItem = self.splitViewItems[1];
        
        self.minimumThicknessForInlineSidebars = 450;
        sidebarSplitViewItem.minimumThickness = 100;
        contentSplitViewItem.minimumThickness = 300;
    }
}

- (IBAction)toggleSidebar:(id)sender {
    NSSplitViewItem *sidebarSplitViewItem = self.splitViewItems[0];
    
    // Default implementations animation messes up NSTextView scrollview size
    // vrs content size if you toggle the sidebar animation fast. Not sure how/why
    // but if implement the switch manually with no animation then solves the problem.
    if (sidebarSplitViewItem.collapsed) {
        CGFloat grow = self.minimumThicknessForInlineSidebars - self.splitView.frame.size.width;
        if (grow > 0) {
            NSWindow *window = self.view.window;
            NSRect frame = window.frame;
            frame.origin.x -= grow;
            frame.size.width += grow;
            frame = [window constrainFrameRect:frame toScreen:window.screen];
            [window setFrame:frame display:YES animate:NO];
        }
        sidebarSplitViewItem.collapsed = NO;
    } else {
        sidebarSplitViewItem.collapsed = YES;
    }
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    NSSplitViewItem *sidebarSplitViewItem = self.splitViewItems[0];
    
    SEL action = menuItem.action;
    if (action == @selector(toggleSidebar:)) {
        if (sidebarSplitViewItem.collapsed) {
            [menuItem setTitle:NSLocalizedString(@"Show Sidebar", nil)];
        } else {
            [menuItem setTitle:NSLocalizedString(@"Hide Sidebar", nil)];
        }
    }
    return YES;
}

@end
