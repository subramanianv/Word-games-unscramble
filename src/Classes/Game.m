//
//  Game.m
//  AppScaffold
//

#import "Game.h" 
#import "Suffle.h"
#import <QuartzCore/QuartzCore.h>
#import "Kiip.h"
#import "AppDelegate.h"
#import "Appirater.h"
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define How_To_Play 1

@implementation Game
@synthesize delegate,wl,glo;
-(void)dealloc
{
    [self.wl release];
    [self.glo release];
}
-(int)NumberOfSetBits:(int)i
{
    i = i - ((i >> 1) & 0x55555555);
    i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
    return (((i + (i >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24;

}
-(NSString*)FilePathString
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0]stringByAppendingPathComponent:@"TSSettings.plist"];
    
    
}
-(int)getNumber
{
    
    
    if (csf>788) {
    
        self.glo=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"gl" ofType:@"plist"]];
        csf=0;
        
    }
    
        
    
    //csf++;
    NSDictionary *dict=[[self.glo objectForKey:@"wl"]objectForKey:[NSString stringWithFormat:@"%d",difficulty]];
    int index;
    if ([[dict objectForKey:@"ws"]count]<[[dict objectForKey:@"tc"]intValue])
    {
    
        NSMutableArray *wl=[dict objectForKey:@"ws"];
        NSDictionary *diffDict=[[self.glo objectForKey:@"wf"]objectForKey:[NSString stringWithFormat:@"%d",difficulty]];
        int f=[[diffDict objectForKey:@"f"]intValue];
        int t=[[diffDict objectForKey:@"t"]intValue];
    
    
    
       if ((t-f)==0) {index=t;}
        else{ index=f+(arc4random()%(t-f+1)); }
        
    while ([wl containsObject:[NSNumber numberWithInt:index]]) {
        
        index=f+(arc4random()%(t-f+1));
    }
    
    //[wl addObject:[NSNumber numberWithInt:index]];
    word_no=index;
    
    }
    else
    {
        
        difficulty++;
    difficulty=difficulty%28;
        index=[self getNumber];
    }
    return index;
}
-(NSString*)FilePathString1
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0]stringByAppendingPathComponent:@"gl.plist"];
    
    
}

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KIIPNotificationShown) name:@"web-view-open" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KIIPNotificationClosed) name:@"web-view-close" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadFile) name:@"reset" object:nil];
    [self showMainScreen];

    
    }
    return self;
}
-(void)loadFile
{
     self.glo=[NSMutableDictionary dictionaryWithContentsOfFile:[self FilePathString1]];
    
}
-(void)KIIPNotificationClosed
{
    [(SPView*)self.stage.nativeView start];  
}
-(void)KIIPNotificationShown
{   [self.stage.nativeView stop];
}
-(void)showMainScreen
{
    
    [self removeAllChildren];
    menu=nil;
    menu=[SPSprite sprite];
    [self addChild:menu];
    
    SPImage *boxOverlay=[SPImage imageWithContentsOfFile:@"bg_new.png"];
    boxOverlay.x=320;
    boxOverlay.y=0;
    boxOverlay.rotation=SP_D2R(90);
  //
    SPImage *gtitle=[SPImage imageWithTexture:[SPTexture textureWithContentsOfFile:@"gt.png"]];
    
    gtitle.x=280;
    gtitle.y=45;
    gtitle.rotation=SP_D2R(90);
    
    // gtitle.y=1;
    SPButton *playButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    flag=651;
    playButton.text=@"Play";
    playButton.x=160;
    playButton.y=180;
    playButton.rotation=SP_D2R(90);
    playButton.fontColor=SP_WHITE;
    playButton.fontName=@"Arial-BoldItalicMT";
    playButton.fontSize=19.0f;
    playButton.height=100;
    playButton.width=100;
    [playButton addEventListener:@selector(MenuButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    [menu addChild:boxOverlay];
    [menu addChild:gtitle];
    [menu addChild:playButton];
    
    SPButton *optionsButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    
    optionsButton.text=@"Options";
    optionsButton.x=160;
    optionsButton.y=60;
    optionsButton.rotation=SP_D2R(90);
    optionsButton.fontName=@"Arial-BoldItalicMT";
    optionsButton.fontColor=SP_WHITE;
    optionsButton.fontSize=19.0f;
    optionsButton.height=playButton.height;
    optionsButton.width=playButton.width;
    [optionsButton addEventListener:@selector(MenuButtonClicked:)  atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [menu addChild:optionsButton];
    
    
    
    
    SPButton *moreAppsButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    
    moreAppsButton.text=@"More\nApps";
    moreAppsButton.x=160;
    moreAppsButton.y=300;
    moreAppsButton.fontSize=19.0f;
    moreAppsButton.fontColor=SP_WHITE;
    moreAppsButton.fontName=@"Arial-BoldItalicMT";
    moreAppsButton.rotation=SP_D2R(90);
    moreAppsButton.width=optionsButton.width;
    moreAppsButton.height=optionsButton.height;
    [moreAppsButton addEventListener:@selector(MenuButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [menu addChild:moreAppsButton];
    
    SPButton *how_to_play=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"how_to_play.png"]];
    how_to_play.rotation=SP_D2R(90);
    how_to_play.x=100;
    how_to_play.y=340;
    [how_to_play addEventListener:@selector(MenuButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    [menu addChild:how_to_play];
    
    
   // [self addChild:menu];
    
    
    
}
-(void)MenuButtonClicked:(SPEvent*)event;
{
    SPButton *currentButton=(SPButton*)[event target];
    if ([currentButton.text isEqualToString:@"Play"]) {
        
            
        
        if (soundOn) {
            [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
        }
        
        
        
            NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[self FilePathString]];
            time=[[dict objectForKey:@"Time"]intValue];
            soundOn=[[dict objectForKey:@"Sound"]intValue];
       int x2=[[dict objectForKey:@"Show"]intValue];
        
        questions=[NSMutableArray new];
        difficulty=4;
        csf=[[self.glo objectForKey:@"csf"]intValue];
        NSLog(@"Shown:%d csf:%d",How_To_Play,csf);
        [self startGame];
        

    }
    else if([currentButton.text isEqualToString:@"Options"])
        {
        
        if(soundOn)[[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
        [delegate OptionsButtonPressed];

        }
    else if([currentButton.text isEqualToString:@"More\nApps"])
        {
        [BELinkHelper showAllApps];

        }
    else
        {
        if (soundOn) {
            [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
        }
        if (How_To_Play) {
            
            [self removeAllChildren];
            How_To_Play_Spirit=[SPSprite sprite];
            [self addChild:How_To_Play_Spirit];
            How_To_Play_Spirit.rotation=SP_D2R(90);
            How_To_Play_Spirit.x=320;
            SPSprite *first_sprit=[SPSprite sprite];
            [How_To_Play_Spirit addChild:first_sprit];
            SPImage *back_ground=[SPImage imageWithContentsOfFile:@"help.png"];
            
            SPTextField *tut=[SPTextField textFieldWithText:@"Welcome to the exciting world of word games.\nAll you have to do now is\n\n* Understand the meaning from the words displayed on the top.\n* Select the letters from the bottom of the screen in the order that will form the correct word which will match the meaning.\n* You can always use the clue only when you have not selected any letter."];
            tut.width=350;
            tut.hAlign=SPHAlignLeft;
            tut.height=200;
            tut.x=75;
            tut.y=50;
            tut.fontName=@"AmericanTypewriter-Bold";
            SPButton *new_button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"forward.png"]];
            [new_button addEventListener:@selector(How_To_Play_Method:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
            new_button.x=400;
            new_button.y=280;
            [first_sprit addChild:back_ground];
            [first_sprit addChild:tut];
            [first_sprit addChild:new_button];
            SPButton *close=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"close_mine.png"]];
            [close addEventListener:@selector(backtomain:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
            [first_sprit addChild:close];
            
            
            
        }

        
        }
    
}
-(void)How_To_Play_Method:(SPEvent *)event
{
 //   [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
   SPButton *sp=(SPButton*)[event target];
    SPSprite *old_sprit=(SPSprite*)[sp parent];
    SPTween *tween=[SPTween tweenWithTarget:old_sprit time:0.0f];
    [self.stage.juggler addObject:tween];
    [tween addEventListener:@selector(next_sprit:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
}
-(void)backtomain:(SPEvent *)event
{
    SPSprite *parentSprit=[[event target]parent];
    SPTween *tween=[SPTween tweenWithTarget:parentSprit time:0.2];
    [tween animateProperty:@"y" targetValue:400];
    [tween addEventListener:@selector(dismissTweenCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    [self.stage.juggler addObject:tween];
    
}
-(void)dismissTweenCompleted:(SPEvent *)event
{
    SPSprite *t=[[event target]target];
    [t removeAllChildren];
    [t removeFromParent];
    [self removeAllChildren];
    [self showMainScreen];
    
    
}
-(void)next_sprit:(SPEvent *)event
{
    SPSprite *old_sprit=[[event target]target];
    [old_sprit removeAllChildren];
    [old_sprit removeFromParent];
    SPSprite *new_sprit=[SPSprite sprite];
    SPImage *img=[SPImage imageWithTexture:[SPTexture textureWithContentsOfFile:@"entry11.png"]];
    [new_sprit addChild:img];
    new_sprit.rotation=SP_D2R(90);
    new_sprit.x=320;
    SPTextField *t=[SPTextField textFieldWithText:@"Meaning of the word will be shown here"];
    t.width=400;
    t.fontSize=20;
    t.fontName=@"AmericanTypewriter-Bold";
    [new_sprit addChild:t];
    
    [self addChild:new_sprit];
    SPButton *new_button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"forward.png"]];
    [new_button addEventListener:@selector(next_sprit1:)atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    new_button.x=400;
    new_button.y=280;
    [new_sprit addChild:new_button];
    SPButton *close=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"close_mine.png"]];
    [close addEventListener:@selector(backtomain:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [new_sprit addChild:close];
    
    
}
-(void)next_sprit1:(SPEvent *)event
{
   // [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
    SPButton *sp=(SPButton*)[event target];
    SPSprite *old_sprit=(SPSprite*)[sp parent];
    SPTween *tween=[SPTween tweenWithTarget:old_sprit time:0.0f];
    [tween animateProperty:@"alpha" targetValue:0.0f];
    [self.stage.juggler addObject:tween];
    [tween addEventListener:@selector(next_sprit2:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}
-(void)next_sprit2:(SPEvent *)event
{
    SPSprite *old_sprit=[[event target]target];
    [old_sprit removeAllChildren];
    [old_sprit removeFromParent];
    SPSprite *new_sprit=[SPSprite sprite];
    SPImage *img=[SPImage imageWithTexture:[SPTexture textureWithContentsOfFile:@"entry11.png"]];
    [new_sprit addChild:img];
    new_sprit.rotation=SP_D2R(90);
    new_sprit.x=320;
    [new_sprit addChild:img];
    [self addChild:new_sprit];
    SPTextField *t=[SPTextField textFieldWithText:@"To select any of the alphabets.just touch the alphabet"];
    t.width=400;
    t.x=10;
    t.fontName=@"AmericanTypewriter-Bold";
    [new_sprit addChild:t];
    
    for (int i=0,j=25; i<4; i++) {
        SPImage *eimage=[SPImage imageWithContentsOfFile:@"emptyBox12.png"];
        eimage.x=j;
        //eimage.x=175;
        eimage.y=130;
        eimage.height=48;
        eimage.width=36;
        j+=eimage.height-5;
        
        // NSLog(@"Called");
        [new_sprit addChild:eimage];
    }   
    NSString *word=@"WORD";
        NSLog(@"%d",[word length]);
    xdir=25;
    for (int i=0,j=25;i<[word length];i++) 
        {
     SPButton *button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"alphabox.png"]];
    button.x=j;
    button.y=200;
    button.width=38;
    button.fontColor=SP_WHITE;
    button.fontName=@"Georgia-Bold";
    button.text=[NSString stringWithFormat:@"%c",[word characterAtIndex:i]];
    button.fontSize=32;j+=40;
    [button addEventListener:@selector(tutorialLettersTouched:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];        
    [new_sprit addChild:button];
    }
    SPTextField *te=[SPTextField textFieldWithText:@"Touch on any of the letters"];
    te.y=90;
    te.x=250;
    te.fontName=@"AmericanTypewriter-Bold";
    SPButton *button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"forward.png"]];
    button.x=400;
    button.y=280;
    [button addEventListener:@selector(tutorialButtonPressed:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [new_sprit addChild:button];
    [new_sprit addChild:te];
    SPButton *close=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"close_mine.png"]];
    [close addEventListener:@selector(backtomain:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [new_sprit addChild:close];
    
        
    
    
}
-(void)tutorialLettersTouched:(SPEvent *)event
{
    
    [[SPSound soundWithContentsOfFile:@"switch-3.wav"]play];
    SPButton *button=[event target];
    SPTween *tween=[SPTween tweenWithTarget:button time:0.2];
    [tween animateProperty:@"x" targetValue:xdir];
    [tween animateProperty:@"y" targetValue:130];
    xdir+=43;
    [self.stage.juggler addObject:tween];
    button.touchable=NO;
}
-(void)tutorialButtonPressed:(SPEvent *)event
{   // [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];

    SPSprite *old_sprit=[[event target]parent];
    SPTween *tween=[SPTween tweenWithTarget:old_sprit time:0.0];
    [tween animateProperty:@"alpha" targetValue:0.0f];
    [tween addEventListener:@selector(alphaCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    [self.stage.juggler addObject:tween];
    
}
-(void)alphaCompleted:(SPEvent *)event
{
    SPSprite *old_sprit=[[event target]target];
    [old_sprit removeAllChildren];
    [old_sprit removeFromParent];
    SPSprite *new_sprit=[SPSprite sprite];
    SPImage *img=[SPImage imageWithTexture:[SPTexture textureWithContentsOfFile:@"entry11.png"]];
    [new_sprit addChild:img];
    new_sprit.rotation=SP_D2R(90);
    new_sprit.x=320;
    [new_sprit addChild:img];
    [self addChild:new_sprit];
    NSString *new_word=@"GAME";
    SPSprite *sp=[SPSprite sprite];
    for (int i=0,j=25; i<[new_word length]; i++) {
        SPImage *eimage=[SPImage imageWithContentsOfFile:@"emptyBox12.png"];
     
        eimage.x=j;
        NSLog(@"%f",eimage.x);
        eimage.y=130;
        eimage.height=48;
        eimage.width=36;
        j+=eimage.height-5;
        SPButton *button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"alphabox.png"]];
        button.x=eimage.x;
        button.y=eimage.y;
        button.fontColor=SP_WHITE;
        button.fontName=@"Georgia-Bold";
        button.fontSize=32;
        [button addEventListener:@selector(spritButtonPressed:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        button.text=[NSString stringWithFormat:@"%c",[new_word characterAtIndex:i]];
        [new_sprit addChild:eimage];
        [sp addChild:button];
    }   
    SPTextField *text_field=[SPTextField textFieldWithText:@"To delete any letter from the word. Touch the letter that you want to delete"];
    text_field.x=40;
    text_field.fontName=@"AmericanTypewriter-Bold";
    text_field.width=300;
    text_field.hAlign=SPHAlignLeft;
    SPTextField *te=[SPTextField textFieldWithText:@"Touch any of the letters"];
    te.y=90;
    te.x=250;
    te.fontName=@"AmericanTypewriter-Bold";
    
    [new_sprit addChild:text_field];
    [new_sprit addChild:te];
    xdir=25;
    
    [new_sprit addChild:sp];
    SPButton *close=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"close_mine.png"]];
    [close addEventListener:@selector(backtomain:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [new_sprit addChild:close];
    
    SPTextField *t2=[SPTextField textFieldWithText:@"To go back to the main screen. Use the close button"];
    t2.x=260;
    t2.y=220;
    t2.fontName=@"AmericanTypewriter-Bold";
    [new_sprit addChild:t2];
    
    
}
-(void)spritButtonPressed:(SPEvent *)event
{
    [[SPSound soundWithContentsOfFile:@"switch-3.wav"]play];
    SPButton *button=[event target];
    SPSprite *letter_sprit=[button parent];
    SPSprite *ps=[letter_sprit parent];
    int index=[[button parent]childIndex:button];
    [letter_sprit removeChildAtIndex:index];
    for (int i=index; i<[letter_sprit numChildren]; i++) {
        SPButton *b=[letter_sprit childAtIndex:i];
        NSLog(@"Current:Post%f",b.x);
        
        b.x-=43;
    
    }
    button.x=xdir;
    button.y=200;
    xdir+=43;
    button.touchable=NO;
    [ps addChild:button];
}
-(void)showLastSprit:(SPEvent *)event  
{
    [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];
    SPSprite *par=[[event target]parent];
    [par removeAllChildren];
    [par removeFromParent];
    [self removeAllChildren];
    [self showMainScreen];
    
    
}
-(void)didPresentAlertView:(UIAlertView *)alertView
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.1];
    alertView.transform = CGAffineTransformRotate(alertView.transform, degreesToRadian(90));
    [UIView commitAnimations];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
        case 1:
            [menu removeAllChildren];
            [menu removeFromParent];
            [self startGame];
            break;
        default:
            break;
    }
}


-(void)startGame
{
    gameSpirit=[SPSprite sprite];
    
    SPImage *gameimage=[SPImage imageWithContentsOfFile:@"game_bg.png"];
    gameimage.x=320;
    gameimage.rotation=SP_D2R(90);
    [gameSpirit addChild:gameimage];
    
    cimg=[SPImage imageWithContentsOfFile:@"wrong.png"];
    cimg.x=131;
    cimg.y=240;
    cimg.rotation=SP_D2R(90);
    cimg.visible=NO;
    
    wimg=[SPImage imageWithContentsOfFile:@"correct.png"];
    wimg.x=131;
    wimg.y=240;
    wimg.rotation=SP_D2R(90);
    wimg.visible=NO;
    
    
    
    [gameSpirit addChild:cimg];
    [gameSpirit addChild:wimg];
    
    
    
    
    score=0;
    level=0;
    scoretext=[SPTextField textFieldWithText:[NSString stringWithFormat:@"%d",score]];
    scoretext.x=371;
    scoretext.y=-20;
    scoretext.fontName=@"Arial-BoldMT";
    scoretext.fontSize=18;
    scoretext.color=SP_WHITE;
    scoretext.rotation=SP_D2R(90);
    //[self addChild:top];
    
    /*level Text Field*/
    
    leveltext=[SPTextField textFieldWithText:[NSString stringWithFormat:@"%d",level]];
    leveltext.x=370;
    leveltext.y=120;
    leveltext.fontName=@"Arial-BoldMT";
    leveltext.fontSize=18;
    leveltext.rotation=SP_D2R(90);
    leveltext.color=SP_WHITE;
    
    
    
    
    
    
    
    /*Timer TextField */
    timer=[SPTextField textFieldWithText:@""];
    timer.x=371;
    timer.y=360;
    timer.fontName=@"Arial-BoldMT";
    timer.fontSize=15;
    timer.rotation=SP_D2R(90);
    timer.color=SP_WHITE;
    
    
    
    
    /* Text Feild showing the meaning */
    
    
    meaningTextField=[SPTextField textFieldWithText:@""];
    meaningTextField.x=285;
    meaningTextField.y=23;
    meaningTextField.hAlign=SPHAlignLeft;
    meaningTextField.vAlign=SPVAlignTop;
    meaningTextField.fontName=@"Arial-BoldMT";
    meaningTextField.color=0x000000;
    meaningTextField.fontSize=16;
    //meaningTextField.color=SP_RED;
    meaningTextField.rotation=SP_D2R(90);
    
    
    
    
    /* adding textFields to the stage */
    
    [gameSpirit addChild:timer];
    [gameSpirit addChild:scoretext];
    //[gameSpirit addChild:leveltext];
    //;
    
    [gameSpirit addChild:meaningTextField];
    
    
    playFieldSpirit=[SPSprite sprite];
    playFieldSpirit.name=@"p";
    [gameSpirit addChild:playFieldSpirit];

    
    
    SPButton *scrambleButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"]downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    scrambleButton.rotation=SP_D2R(90);
    scrambleButton.x=65;
    scrambleButton.y=70;
    // scrambleButton.text=@"Scramble";
    scrambleButton.width=50;
    scrambleButton.height=50;
    scrambleButton.name=@"s";
    [scrambleButton addEventListener:@selector(GameButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    // [scrambleButton addChild:ScrambleLabel];
    [scrambleButton addChild:[SPImage imageWithContentsOfFile:@"scramble.png"]];
    
    SPTextField *scrambleText=[SPTextField textFieldWithText:@"Scramble"];
    scrambleText.x=73;
    scrambleText.y=35;
    scrambleText.fontName=@"Arial-BoldMT";
    scrambleText.rotation=SP_D2R(90);
    scrambleText.color=SP_WHITE;
    [gameSpirit addChild:scrambleText];
   [gameSpirit addChild:scrambleButton];
    
    
    
    clueButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    clueButton.rotation=SP_D2R(90);
    clueButton.x=65;
    clueButton.height=50;
    clueButton.width=50;
    clueButton.name=@"c";
    clueButton.y=150;
    [clueButton addChild:[SPImage imageWithContentsOfFile:@"bulb_ copy.png"]];
    
    [clueButton addEventListener:@selector(GameButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    SPTextField *clueText=[SPTextField textFieldWithText:@"Clue"];
    clueText.rotation=SP_D2R(90);
    clueText.x=72;
    clueText.y=115;
    clueText.fontName=@"Arial-BoldMT";
    clueText.color=SP_WHITE;
    [gameSpirit addChild:clueText];
    [gameSpirit addChild:clueButton];
    
    
    SPButton *quitButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    quitButton.rotation=SP_D2R(90);
    quitButton.x=65;
    quitButton.y=230;
    [quitButton addEventListener:@selector(GameButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [quitButton addChild:[SPImage imageWithContentsOfFile:@"cross.png"]];
    quitButton.height=50;
    quitButton.width=50;
    quitButton.name=@"q";
    SPTextField *quitText=[SPTextField textFieldWithText:@"Pause/Quit"];
    quitText.rotation=SP_D2R(90);
    quitText.x=72;
    quitText.y=200;
    quitText.fontName=@"Arial-BoldMT";
    quitText.color=SP_WHITE;
    [gameSpirit addChild:quitText];
    [gameSpirit addChild:quitButton];

    
    
    SPButton *nextButton=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    nextButton.rotation=SP_D2R(90);
    nextButton.x=quitButton.x;
    nextButton.y=quitButton.y+quitButton.width+40;
    [nextButton addChild:[SPImage imageWithContentsOfFile:@"next_arrow1.png"]];
    nextButton.width=quitButton.width;
    nextButton.height=quitButton.height;
    nextButton.name=@"n";
    [nextButton addEventListener:@selector(GameButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    SPTextField *nextText=[SPTextField textFieldWithText:@"Next word"];
    nextText.rotation=SP_D2R(90);
    nextText.fontName=@"Arial-BoldMT";
    nextText.x=72;
    nextText.y=290;
    nextText.color=SP_WHITE;
    [gameSpirit addChild:nextText];
    
    [gameSpirit addChild:nextButton]; 
    [self removeAllChildren];
    [self addChild:gameSpirit];
    [self showTimer:time*60];
    [self getNewWord];
    [self showWord];
    
    
}
-(void)GameButtonClicked:(SPEvent *)event
{
    SPButton *currentTarget=(SPButton*)[event currentTarget];
    if ([currentTarget.name isEqualToString:@"s"]) {
        if(soundOn)
        [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];

        
        [letterSpirit removeAllChildren];
        [playFieldSpirit removeAllChildren];
        [stack removeAllObjects];
        [stack release];
        stack=nil;
        [randarray removeAllObjects];
        [randarray release];
        randarray=nil;
        [letterSeen release];
        [self showWord];
        
    }
    else if([currentTarget.name isEqualToString:@"q"])
        {
        
      
        
        // SPJuggler
        [self.stage.nativeView stop];
        
        UIView *sparrowView = (UIView *)self.stage.nativeView;
        
        UIView *pauseScreen=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,480)];
        
        [pauseScreen setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_new.png"]]];
        // [pauseScreen setBackgroundColor:[UIColor colorWithRed:0.23 green:0.41 blue:0.66 alpha:1.0f]];
        
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(360, 260, -250, 40)];
        label.text=@"Game paused";
        label.transform=CGAffineTransformMakeRotation(M_PI/2);
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22]];
        [label setTextColor:[UIColor whiteColor]];
        
        [pauseScreen addSubview:label];
        [label release];
        
        
        
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myButton.frame = CGRectMake(210,110, -100, 100);
        myButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
        [myButton setBackgroundImage:[UIImage imageNamed:@"circle_button.png"] forState:UIControlStateNormal];
        [myButton setBackgroundImage:[UIImage imageNamed:@"circle_button_down.png"] forState:UIControlStateSelected];
        
        [myButton setTitle:@"Resume" forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
        myButton.transform=CGAffineTransformMakeRotation(90.0*M_PI/180.0);
        pauseScreen.layer.cornerRadius=8.0f;
        [pauseScreen addSubview:myButton];
        
        [sparrowView addSubview:pauseScreen];
        
        
        UIButton *quitButton=[UIButton buttonWithType:UIButtonTypeCustom];
        quitButton.frame=CGRectMake(210, 250, -100, 100);
        quitButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
        [quitButton setBackgroundImage:[UIImage imageNamed:@"circle_button.png"] forState:UIControlStateNormal];
        [quitButton setBackgroundImage:[UIImage imageNamed:@"circle_button_down.png"] forState:UIControlStateSelected];
        quitButton.transform=CGAffineTransformMakeRotation(M_PI/2);
        [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
        [quitButton addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
        [pauseScreen addSubview:quitButton];
        
        [pauseScreen release];
        
        
        }
    else if([currentTarget.name isEqualToString:@"n"])
        {
            
        if(soundOn)
        [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];

        [letterSpirit removeAllChildren];
        [playFieldSpirit removeAllChildren];
        difficulty++;
        difficulty=difficulty%28;
        [self getNewWord];
        [letterSeen release];
        [self showWord];
                
        }
    else
        {
        
            if ([letterSeen length]>0) {}
            else {
                
                if(soundOn)
                [[SPSound soundWithContentsOfFile:@"button_c.wav"]play];

                    int len=0.5*word_length;
                    for (int i=0; i<len; i++) {
                            for (int j=0; j<playFieldSpirit.numChildren; j++) {
                    
                                SPDisplayObject *key=[playFieldSpirit childAtIndex:j];
                                if ([key class]==[SPButton class]) {
                                    //SPImage *Keyimage=(SPImage*)[playFieldSpirit childAtIndex:j];
                        if ([key.name isEqualToString:[NSString stringWithFormat:@"%c",[word characterAtIndex:i]]]) {
                            
                            
                            
                            //    NSLog(@"%@",key.name);
                            [letterSeen appendString:key.name];
                            
                            struct Points p;
                            p.x=key.x;
                            p.y=key.y;
                            [stack addObject:[NSValue value:&p withObjCType:@encode(struct Points)]];
                            
                            SPTween *lettween=[SPTween tweenWithTarget:key time:0.2];
                            SPImage *box=(SPImage*)[itemsSpirit childAtIndex:itemsSpirit.numChildren-word_length];
                            
                            [lettween animateProperty:@"x" targetValue:193];
                            [lettween animateProperty:@"y" targetValue:box.y];
                            [self.juggler addObject:lettween];
                            [key removeFromParent];
                            //key.width=47.0f;
                            //  NSLog(@"height:%f",key.height);
                            //key.height=32;
                            
                            [letterSpirit addChild:key];
                            
                            
                            word_length--;
                            
                            break;
                            
                        }
                        
                    }   
                    }
                    
                    
                }
        }}
            
        
        
        
        
}

-(void)aMethod:(id)sender
{
    
    UIButton *button=sender;
    if ([button.currentTitle isEqualToString:@"Quit"]) {
        
        [self.juggler removeAllObjects];
        UIView *parentView=[sender superview];
        [gameSpirit removeAllChildren];
        
        [gameSpirit removeFromParent];
      //  [gameSpirit release];
        gameSpirit=nil;
        
        
        
        [sender removeFromSuperview];
        [parentView removeFromSuperview];
        [randarray removeAllObjects];
        if (randarray) {
            [randarray release];
        }
       randarray=nil;
       
        [questions removeAllObjects];
        [questions release];
        questions=nil;
        
        [self showMainScreen];
        [(SPView*)self.stage.nativeView start];
        
        [self.glo setValue:[NSNumber numberWithInt:csf] forKey:@"csf"];
        [self.glo writeToFile:[self FilePathString1] atomically:YES];
        
        
        
        
    }
    else
        {
        
        UIView *parentView=[sender superview];
        
        [sender removeFromSuperview];
        [parentView removeFromSuperview];
        
        [(SPView*)self.stage.nativeView start];
        }
}

-(void)getNewWord
{
    int index=[self getNumber];
    //csf++;
    //fla=index;
    NSDictionary  *dict=[self.wl objectAtIndex:index];
    NSString *w=[[dict allKeys]objectAtIndex:0];
    NSString *m=[[dict allValues]objectAtIndex:0];
    word=w;//@"abcdefghij";
    NSLog(@"%d %@ %@",index,w,m);
    
    
    meaningString=m;//@"to lower in position, estimation or the like; degrade";
    word_length=[w length];
    [randarray removeAllObjects];
    if (randarray) {
        [randarray release];
    }
    randarray=nil;



}
-(void)showWord
{
    if (cimg.visible==YES) {
        cimg.visible=NO;
    }
    
    meaningTextField.text=meaningString;
    meaningTextField.width=420;
    meaningTextField.vAlign=SPVAlignTop;
    meaningTextField.hAlign=SPHAlignLeft;
    y=0;
    
    
    
    itemsSpirit=[SPSprite sprite];
    [playFieldSpirit addChild:itemsSpirit];
    
        
    letterSpirit=[SPSprite sprite];
    letterSpirit.name=@"l";
    [playFieldSpirit addChild:letterSpirit];
    
    
    //j=10
    for (int i=0,j=25; i<[word length]; i++) {
        SPImage *eimage=[SPImage imageWithContentsOfFile:@"emptyBox12.png"];
        eimage.x=193;
        //eimage.x=175;
        eimage.y=j;
        eimage.height=48;
        eimage.width=36;
        j+=eimage.height-5;
        
        eimage.rotation=SP_D2R(90);
        // NSLog(@"Called");
        [itemsSpirit addChild:eimage];
        
    }
    
    float dashXPos=-40.0f;
    x=dashXPos;
    y=dashXPos;
    
    
    
   letterSeen=[NSMutableString new];

    [stack removeAllObjects];
    if (stack) {
        [stack release];
    }
    
    stack=nil;
    stack=[NSMutableArray new];
    [self showAnimation:word];
    
    
}
-(void)showAnimation:(NSString*)word1
{
    
    
    
    int len=[word1 length];
    word_length=len;
    
    
    if (!randarray) {
        randarray=[NSMutableArray new];
        for (int i=0; i<len; i++) {
            [randarray addObject:[NSNumber numberWithInt:i]];
        }
        [randarray shuffle];
        
    }
    
    
    xdir=125;
    ydir=30;
    
    
    
    for(int i=0;i<len;i++)
        {
        
        
        [self animateCharacter: [NSString stringWithFormat:@"%c",[word1 characterAtIndex:[[randarray objectAtIndex:i]intValue]]]];
        
        }
    
    
    
}



-(void)animateCharacter:(NSString*)character 
{
    SPButton *button=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"alphabox.png"]];
    button.name=character;
    button.x=arc4random()%200;
    button.y=arc4random()%370;
    button.rotation=SP_D2R(90);
    button.width=38;
    button.fontColor=SP_WHITE;
    button.fontName=@"Georgia-Bold";
    button.text=[character uppercaseString];
    button.fontSize=32;
    
    
    
    
    SPTween *chartween=[SPTween tweenWithTarget:button time:0.3 transition:SP_TRANSITION_LINEAR];
    [chartween animateProperty:@"x" targetValue:xdir];
    [chartween animateProperty:@"y" targetValue:ydir];
    [self.juggler addObject:chartween];
    [button addEventListener:@selector(letterTouched:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    ydir+=button.width+4;
    if (ydir>self.height)
        {
        ydir=0;
        xdir-=button.height;
        }
    [playFieldSpirit addChild:button];
}
-(void)letterTouched:(SPTouchEvent*)event
{
  
    SPButton *currentLetter=(SPButton*)[event target];
    
        if ([currentLetter.parent.name isEqualToString:@"p"])
            
            {
            
            
            if (soundOn==1) {
                [[SPSound soundWithContentsOfFile:@"switch-3.wav"]play];
            }
            
            if (letterSeen!=nil) {
                [letterSeen appendString:currentLetter.name];
            }
            
            struct Points p;
            p.x=currentLetter.x;
            p.y=currentLetter.y;
            [stack addObject:[NSValue value:&p withObjCType:@encode(struct Points)]];
            
            SPTween *lettween=[SPTween tweenWithTarget:currentLetter time:0.1];
            SPImage *box=(SPImage*)[itemsSpirit childAtIndex:itemsSpirit.numChildren-word_length];
            
            [lettween animateProperty:@"x" targetValue:193];
            [lettween animateProperty:@"y" targetValue:box.y+2];
            [self.juggler addObject:lettween];
            
            //  NSLog(@"%f",currentLetter.width);
            [currentLetter removeFromParent];
            // currentLetter.width=47.0f;
            [letterSpirit addChild:currentLetter];
            
            
            word_length--;
            
            // NSLog(@"word_length:%d",word_length);
            y+=currentLetter.width-2;
            
            }
        else
            {
            int index=[letterSpirit childIndex:currentLetter];
            [letterSeen deleteCharactersInRange:NSMakeRange(index,1)];
            
            word_length++;
            [letterSpirit removeChildAtIndex:index];
            
            //animate the character
            struct Points p;
            
            [[stack objectAtIndex:index]getValue:&p];
            
            SPTween *deltween=[SPTween tweenWithTarget:currentLetter time:0.2f];
            [deltween animateProperty:@"x" targetValue:p.x];
            [deltween animateProperty:@"y" targetValue:p.y];
            [stack removeObjectAtIndex:index];
            [self.juggler addObject:deltween];
            
            for (int i=index; i<letterSpirit.numChildren; i++) {
                
                SPButton *di=(SPButton*)[letterSpirit childAtIndex:i];
                di.x=[itemsSpirit childAtIndex:i].x;
                di.y=[itemsSpirit childAtIndex:i].y;
                
            }
            
            
            //currentLetter.width=40;
            [playFieldSpirit addChild:currentLetter];
            
            
            }
        
    if (word_length==0) {
        word_length=1;
        [self checkAnswer];
        
    }
    
    
    
}
-(void)tweenCompleted:(SPEvent *)event
{
    [self showTimer:time*60];
    [self getNewWord];
    [letterSeen release];
    [self showWord];
    
}

-(void)checkAnswer
{
    
    
    
    if (letterSeen!=nil) {
        
    
    if ([letterSeen isEqualToString:word]) {
        level+=[word length];
        
        score++;
        scoretext.text=[NSString stringWithFormat:@"%d",score];
        
        if (soundOn==1) {
            
            [[SPSound soundWithContentsOfFile:@"correctS.aifc"]play];
            
        }
        
        if ([letterSeen retainCount]>0) {
            
        
        [letterSeen release];
        }
        letterSeen=nil;
      
        NSDictionary *dict=[[self.glo objectForKey:@"wl"]objectForKey:[NSString stringWithFormat:@"%d",difficulty]];
        NSMutableArray *wl=[dict objectForKey:@"ws"];
        [wl addObject:[NSNumber numberWithInt:word_no]];
        csf++; 
        
        
        
        difficulty++;
        difficulty=difficulty%28;
        wimg.visible=YES;
        [questions addObject:[NSNumber numberWithInt:word_no]];
        [self showCorrectAnimation];
        
        
        
        
        
        
        
        
    }
    
    else
        {
        
            [letterSeen release];
        letterSeen=nil;
            
        
                level-=5;

        cimg.visible=YES;
        [[self.juggler delayInvocationAtTarget:playFieldSpirit byTime:1.0f]removeAllChildren];
        [[self.juggler delayInvocationAtTarget:self byTime:1.0f]showWord];
            
        
        
        }
    
    
    
}  
    
    
    
}

-(void)showTimer:(int)Seconds
{
    NSString *t;
    for (int j=Seconds; j>=0; j--) {
        
        if (j%60 < 10) {
            t=[NSString stringWithFormat:@"0%d",j%60];
        }
        else
            {
            t=[NSString stringWithFormat:@"%d",j%60];
            
            }
        
        
        
        [[self.juggler delayInvocationAtTarget:timer byTime:Seconds-j]setText:[NSString stringWithFormat:@"%d:%@",j/60,t]];
        if (j==10)
            {
            
            float fsize=timer.fontSize;
            [[self.juggler delayInvocationAtTarget:timer byTime:Seconds-j]setFontSize:fsize+10];
            [[self.juggler delayInvocationAtTarget:timer byTime:Seconds-j+0.2]setFontSize:fsize];
            [[self.juggler delayInvocationAtTarget:timer byTime:Seconds-j]setColor:0xff0000];
            }
        if (j<=10) {
            [[self.juggler delayInvocationAtTarget:self byTime:Seconds-j-0.2]playSound];
            
        }
        
        
    }
    [[self.juggler delayInvocationAtTarget:self.juggler byTime:Seconds]removeAllObjects];
    
    [[self.juggler delayInvocationAtTarget:playFieldSpirit byTime:Seconds]removeAllChildren];
    [[self.juggler delayInvocationAtTarget:self byTime:Seconds]endGame];
    
    
    
    
    
}
-(void)playSound
{
    if(soundOn)[[SPSound soundWithContentsOfFile:@"clock_tick.wav"]play];
}
-(void)endGame
{
       
    
    [stack removeAllObjects];
    [stack release];
    stack=nil;
    [randarray removeAllObjects];
    [randarray release];
    randarray=nil;
    resetSpirit=[SPSprite sprite];
    
    SPImage *img=[SPImage imageWithContentsOfFile:@"bg_new.png"];
    img.x=320;
    img.rotation=SP_D2R(90);
    
    // SPQuad *boxOverlay=[SPQuad quadWithWidth:320 height:479 color:SP_COLOR(83, 122, 174)];
    SPImage *boxOverlay=[SPImage imageWithContentsOfFile:@"score_screen.png"];
    boxOverlay.x=290;
    boxOverlay.y=120;
    boxOverlay.rotation=SP_D2R(90);
    
    
    //
  SPTextField *scoreReport=[SPTextField textFieldWithText:[NSString stringWithFormat:@"%d",score]];
    scoreReport.x=225;
    scoreReport.y=239;
    scoreReport.fontSize=25;
    scoreReport.rotation=SP_D2R(80);
    scoreReport.vAlign=SPVAlignTop;
    scoreReport.hAlign=SPHAlignLeft;
    scoreReport.width=300;
    scoreReport.fontName=@"MarkerFelt-Thin";
    
    //
    
    
    // SPImage *img=[SPImage imageWithContentsOfFile:@"box.png"];
    //img.rotation=SP_D2R(90);
    //img.x=250;
    //img.y=100;
    
    SPButton *mainmenu=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    mainmenu.text=@"Menu";
    mainmenu.fontName=@"Arial-BoldItalicMT";
    mainmenu.fontSize=19.0f;
    mainmenu.height=100;
    mainmenu.width=100;
    mainmenu.x=150;
    mainmenu.y=100;
    mainmenu.fontColor=SP_WHITE;
    mainmenu.rotation=SP_D2R(90);
    [mainmenu addEventListener:@selector(ResetButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    SPButton *viewSolution=[SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"circle_button.png"] downState:[SPTexture textureWithContentsOfFile:@"circle_button_down.png"]];
    viewSolution.text=@"View\n Answers";
    viewSolution.fontName=@"Arial-BoldItalicMT";
    viewSolution.fontSize=19.0f;
    viewSolution.x=150;
    viewSolution.y=250;
    viewSolution.height=100;
    viewSolution.width=100;
    viewSolution.fontColor=SP_WHITE;
    viewSolution.rotation=SP_D2R(90);
    [viewSolution addEventListener:@selector(ResetButtonClicked:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    
    
    [resetSpirit addChild:img];
    [resetSpirit addChild:boxOverlay];
    [resetSpirit addChild:scoreReport];
    //  [resetSpirit addChild:redQuad];
    [resetSpirit addChild:mainmenu];
    [resetSpirit addChild:viewSolution];
    [gameSpirit removeAllChildren];
     [gameSpirit removeFromParent];
    
    [self.glo setValue:[NSNumber numberWithInt:csf] forKey:@"csf"];  
    [self.glo writeToFile:[self FilePathString1] atomically:YES];
   
    
    [[self.juggler delayInvocationAtTarget:self byTime:1.0f]addChild:resetSpirit];
    
    
}
-(void)showCorrectAnimation
{
    
    SPTween *myTween=[SPTween tweenWithTarget:letterSpirit time:0.2f];
    [myTween animateProperty:@"alpha" targetValue:0.0f];
    [self.juggler addObject:myTween];
    [myTween addEventListener:@selector(onCorrectTweenFinished:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    
}
-(void)onCorrectTweenFinished:(SPEvent *)event
{
    
    
    
    
    [self.juggler removeObject:(id)event.target];
    
    
    SPTween *alphaToOne=[SPTween tweenWithTarget:letterSpirit time:0.2f];
    [alphaToOne animateProperty:@"alpha" targetValue:1.0f];
    
    [self.juggler addObject:alphaToOne];
    [alphaToOne addEventListener:@selector(onAlphaToZeroFinished:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    
    
}
-(void)onAlphaToZeroFinished:(SPEvent *)event
{
    
    
    [itemsSpirit removeAllChildren];
    [letterSpirit removeAllChildren];
    [playFieldSpirit removeAllChildren];
    if (csf==10 || csf==25 || csf==50 || csf==80 || csf==100 || csf==125 || csf==150 || csf==175 || csf==200 || csf==250 || csf==300 || csf==350 || csf==400 || csf==450 || csf== 500 || csf==550 || csf==600 || csf==650 || csf==700 || csf==750 || csf==786) {
        
            [[KPManager sharedManager]unlockAchievement:[NSString stringWithFormat:@"%d",csf]];
                
            
        }
    
    
    wimg.visible=NO;
    [self getNewWord];
    [self showWord];
    
}
-(void)ResetButtonClicked:(SPEvent *)event
{
    
    
    SPButton *button=(SPButton*)[event target];
    
    if ([button.text isEqualToString:@"Retry"]) {
        
        [gameSpirit removeAllChildren];
        [gameSpirit removeFromParent];
        [self startGame];
    }
    else if([button.text isEqualToString:@"Menu"])
        {
        [self.juggler removeAllObjects];
        [questions release];
        [letterSeen release];
        questions=nil;
        [Appirater userDidSignificantEvent:YES];
        [self showMainScreen];
        
        }
    else if([button.text isEqualToString:@"View\n Answers"])
        {
 
        NSMutableString *htmlString=[NSMutableString new];
        [htmlString appendString:@"<html><body style=\"font-size:14pt;\">"];
        if ([questions count]==0) {
            
            [htmlString appendString:@"No words done!!!"];
            
        }
        else
            {
        for (int i=0; i<[questions count]; i++) {
            
            int qno=[[questions objectAtIndex:i]intValue];
            
            
            NSDictionary  *dict=[self.wl objectAtIndex:qno];
            
           // NSLog(@"first:%@",);
            [htmlString appendFormat:@"<div style=\"border-bottom:1px solid #87CEFA;\"><span style=\"color:#2C5E93;\"><b>#%d %@%@</b></span><ul><li> %@</li></ul></div>",i+1,[[[[dict allKeys]objectAtIndex:0]substringToIndex:1]uppercaseString],[[[dict allKeys]objectAtIndex:0]substringFromIndex:1],[[dict allValues]objectAtIndex:0]];
            
        }
            }
        [htmlString appendFormat:@"<br/></body></html>"];
        AppDelegate *del=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [del HTMLButtonPressed:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"showHTML",htmlString,nil] forKeys:[NSArray arrayWithObjects:@"method",@"html",nil]]];
        [htmlString release];
    }
    
    
    
        
}

@end
