//
//  BELinkHelper.m
//
//  Created by Brian Ensor on 5/8/11.
//  Copyright 2011 Brian Ensor Apps. All rights reserved.
//

#import "BELinkHelper.h"

@implementation BELinkHelper

+ (void)showAllApps {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://goo.gl/WL56X"]]];
}
// http://itunes.apple.com/us/app/remedial-english-grammar/id487720613?mt=8
+ (void)showAppReviews {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_ID]]];
}

+ (void)showAppWithID:(NSString *)appID {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appID]]];
}

@end
