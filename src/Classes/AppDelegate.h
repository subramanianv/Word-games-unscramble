//
//  AppScaffoldAppDelegate.h
//  AppScaffold
//

#import <UIKit/UIKit.h>
#import "KPManagerDelegate.h"
#import "GameDelegate.h"


@interface AppDelegate : NSObject <UIApplicationDelegate,KPManagerDelegate,GameDelegate> 
{
  @private 
    UIWindow *mWindow;
    SPView *mSparrowView;
    UINavigationController *controller;
    UINavigationController *cont;
}
@property(nonatomic,retain)UINavigationController *controller;
-(void)backButtonPressed;
-(void)OptionsButtonPressed;
-(void)HTMLButtonPressed:(NSDictionary*)dict;
@end
