//
//  SessionManager.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "SessionManager.h"


@implementation SessionManager

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:BaseURL]];
    if(!self) return nil;
    
    return self;
}

+ (id)sharedManager {
    static SessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

@end
