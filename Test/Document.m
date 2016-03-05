//
//  Document.m
//  Test
//
//  Created by Jesse Grosjean on 3/3/16.
//  Copyright © 2016 Jesse Grosjean. All rights reserved.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textStorage = [[NSTextStorage alloc] init];
    }
    return self;
}

- (id)initWithType:(NSString *)typeName error:(NSError **)outError {
    self = [super initWithType:typeName error:outError];
    if (self) {
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

+ (BOOL)canConcurrentlyReadDocumentsOfType:(NSString *)typeName {
    return NO;
}

- (BOOL)canAsynchronouslyWriteToURL:(NSURL *)url ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation {
    return NO;
}

- (void)makeWindowControllers {
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    return [self.textStorage.string dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (string) {
        [self.textStorage replaceCharactersInRange:NSMakeRange(0, self.textStorage.length) withString:string];
        return YES;
    }
    return NO;
}

@end
