//
//  AppScaffoldAppDelegate.m
//  AppScaffold
//

#import "AppDelegate.h"
#import "Game.h"
#import "OptionsViewController.h"
#import "Kiip.h"
#import "Appirater.h"
#import "WordGameController.h"
#import "TapjoyConnect.h"
#import "TapForTap.h"
@implementation AppDelegate
@synthesize controller;

-(NSString*)FilePathString
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0]stringByAppendingPathComponent:@"TSSettings.plist"];
    
    
}
-(NSString*)FilePathString1
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0]stringByAppendingPathComponent:@"gl.plist"];
    
}
- (id)init
{
    if ((self = [super init]))
    {
        mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        mSparrowView = [[SPView alloc] initWithFrame:mWindow.bounds]; 
        [mWindow addSubview:mSparrowView];
    }
    return self;
}
-(void)applicationWillEnterForeground:(UIApplication *)application
{
    
}
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{   
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [SPStage setSupportHighResolutions:YES];
    [SPAudioEngine start];
    
    // Start and initialize when application starts
    KPManager *manager = [[KPManager alloc] initWithKey:@"c20c561b9840c467cafc624c5a25d0c8" secret:@"6338ec33b8e7c972eb29867254602938"];
    // Set the shared instance after initialization
    // to allow easier access of the object throughout the project.
    [KPManager setSharedManager:manager];
    [manager setDelegate:self];
    [[KPManager sharedManager] setGlobalOrientation:UIDeviceOrientationLandscapeLeft];

    [manager release];
    
    [TapForTap setDefaultAppId:@"bd8b3560-b840-012f-f680-4040d804a637"];
    [TapForTap checkIn];
    
    
    
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self FilePathString]]) {
        
    }
    else
        {
        NSError *error;
        
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"TSSettings" ofType:@"plist"] toPath:[self FilePathString] error:&error];
        
        
        
        }
    
    
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self FilePathString1]]) 
    {
        
    }
    else
        {
            NSError *error;
        
            [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"gl" ofType:@"plist"] toPath:[self FilePathString1] error:&error];
        }
    
    [TapjoyConnect requestTapjoyConnect:@"2c0d4988-7c7e-4f97-b9e8-fac85c15b802" secretKey:@"pEz85AQeEgBZ0QNqmACI"];
    Game *game = [[Game alloc] init];        
    game.wl=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"word.plist"]];
    game.glo=[NSMutableDictionary dictionaryWithContentsOfFile:[self FilePathString1]];
    game.delegate=self;
    mSparrowView.stage = game;
    mSparrowView.frameRate = 30.0f;
    
    [game release];
    
    [mWindow makeKeyAndVisible];
    [mSparrowView start];
    
    [pool release];
}


//KPDELS

-(void)manager:(KPManager *)manager didReceiveError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"web-view-close" object:nil userInfo:nil];

}
- (void) willShowWebView:(NSString*)rid;
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"web-view-open" object:nil userInfo:nil];
    
}

-(void)didCloseWebView:(NSString *)rid
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"web-view-close" object:nil userInfo:nil];
    
}
- (void)applicationWillResignActive:(UIApplication *)application 
{    
    [mSparrowView stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
	[mSparrowView start];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [SPPoint purgePool];
    [SPRectangle purgePool];
    [SPMatrix purgePool];    
}
-(void)applicationWillTerminate:(UIApplication *)application   
{
    NSLog(@"Application terminate");
}
- (void)dealloc 
{
    [SPAudioEngine stop];
    [mSparrowView release];
    [mWindow release];    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [super dealloc];
}
-(void)OptionsButtonPressed
{
    [mSparrowView stop];
    OptionsViewController *opc=[[OptionsViewController alloc]initWithNibName:@"OptionsViewController" bundle:nil];
    self.controller=[[UINavigationController alloc]initWithRootViewController:opc];
  //  [controller pushViewController:opc animated:YES];
    
    //:opc];
    
   controller.view.tag=0;
    
    [mWindow addSubview:controller.view];
    [opc release];

    
}
-(void)HTMLButtonPressed:(NSDictionary*)dict;
{
 /*   [dict retain];
    */
    [dict retain];
    [mSparrowView stop];
    WordGameController *word=[[WordGameController alloc]initWithTitle:@"Answers" method:(NSDictionary*)dict];
    self.controller=[[UINavigationController alloc]initWithRootViewController:word];
    [mWindow addSubview:controller.view];
    [dict release];
    [word release];
    
}
-(void)backButtonPressed
{
    [[[mWindow subviews]lastObject]removeFromSuperview];
    [mSparrowView start];
    self.controller=nil;
}
@end
