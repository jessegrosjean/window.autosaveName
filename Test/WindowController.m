//
//  WindowController.m
//  Test
//
//  Created by Jesse Grosjean on 3/3/16.
//  Copyright © 2016 Jesse Grosjean. All rights reserved.
//

#import "WindowController.h"
#import "Document.h"

@interface WindowController ()

@end

NSString *frameAutosaveName = @"Document Window Controller";

BOOL useMyHack = NO;

@implementation WindowController {
    BOOL _saveFrames;
}

- (void)windowDidLoad {
    [super windowDidLoad];

    if (useMyHack) {
        [self.window setFrameUsingName:frameAutosaveName];
        
        NSRect frame = self.window.frame;
        NSPoint topLeftPoint = NSMakePoint(NSMinX(frame), NSMaxY(frame));
        for (NSWindow *each in [NSApp windows]) {
            NSRect eachFrame = each.frame;
            NSPoint eachTopLeftPoint = NSMakePoint(NSMinX(eachFrame), NSMaxY(eachFrame));
            
            if (NSEqualPoints(topLeftPoint, eachTopLeftPoint)) {
                [self.window setFrameTopLeftPoint:[self.window cascadeTopLeftFromPoint:topLeftPoint]];
                break;
            }
        }
        
        _saveFrames = YES;
    } else {
        self.windowFrameAutosaveName = frameAutosaveName;
    }
}

- (void)setDocument:(Document *)document {
    [super setDocument:document];
    [self setDocument:document forViewController:self.contentViewController];
}

- (void)setDocument:(Document *)document forViewController:(NSViewController *)viewController {
    if ([viewController respondsToSelector:@selector(setDocument:)]) {
        [viewController performSelector:@selector(setDocument:) withObject:document];
    }
    
    for (NSViewController *each in viewController.childViewControllers) {
        [self setDocument:document forViewController:each];
    }
}

- (void)windowDidBecomeMain:(NSNotification *)notification {
    if (_saveFrames) {
        [self.window saveFrameUsingName:frameAutosaveName];
    }
}

- (void)windowDidResize:(NSNotification *)notification {
    if (_saveFrames) {
        [self.window saveFrameUsingName:frameAutosaveName];
    }
}

- (void)windowDidMove:(NSNotification *)notification {
    if (_saveFrames) {
        [self.window saveFrameUsingName:frameAutosaveName];
    }
}

@end
