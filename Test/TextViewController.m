//
//  TextViewController.m
//  Test
//
//  Created by Jesse Grosjean on 3/3/16.
//  Copyright © 2016 Jesse Grosjean. All rights reserved.
//

#import "TextViewController.h"
#import "Document.h"

@interface TextViewController ()

@property (strong) IBOutlet NSTextView *textView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setDocument:(Document *)document {
    NSTextStorage *textStorage = document.textStorage;
    if (!textStorage) {
        textStorage = [[NSTextStorage alloc] init];
    }
    [self.textView.layoutManager replaceTextStorage:textStorage];
}

@end
