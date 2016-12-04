//
//  SessionManager.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
