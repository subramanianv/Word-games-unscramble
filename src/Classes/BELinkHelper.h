//
//  BELinkHelper.h
//
//  Created by Brian Ensor on 5/8/11.
//  Copyright 2011 Brian Ensor Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

// Your ID in iTunes Connect
#define APP_ID @"349733798"

// Your developer name on the App Store lowercase and without spaces
#define DEVELOPER_NAME @"haliscapebusinesssolutions(p)ltd"

@interface BELinkHelper : NSObject

+ (void)showAllApps;
+ (void)showAppReviews;
+ (void)showAppWithID:(NSString *)appID;

@end
