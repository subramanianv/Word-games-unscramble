//
//  Game.h
//  AppScaffold
//

#import <Foundation/Foundation.h>
#import "BELinkHelper.h"
#import "GameDelegate.h"
struct Points
{
    float x;
    float y;
};

@interface Game : SPStage<UIWebViewDelegate,UIAlertViewDelegate>
{
    
    NSMutableArray *randarray;
    id<GameDelegate> delegate;
    SPSprite *menu;
    int word_no,fla;
    SPSprite *optionsSpirit;
    SPSprite *gameSpirit;
    int score;
    int level;
    int time;
    int soundOn;
    int rewards;
    SPSprite *emptyBoxes;
    SPSprite *playFieldSpirit;
    SPTextField *meaningTextField;
    SPTextField *scoretext;
    SPSprite *letterSpirit;
    SPTextField *leveltext;
    SPTween *tween;
    SPTextField *timer;
    int word_length;
    int xdir;
    int ydir;
    int a_no;
    NSString *word;
    NSString *meaningString;
    SPTextField *wordText;
    SPButton *resetButton;
    SPButton *showAnswerButton;
    SPSprite *resetSpirit;
    BOOL rewardShown;
    SPImage *cimg;
    SPImage *wimg;    
    SPButton *clueButton;
    SPSound *switchSound;
    SPSprite *itemsSpirit;
    SPSound *correctSound;
    SPSprite *How_To_Play_Spirit;
    //word and meaning list
    
    NSDictionary *word_meaningList;
    NSArray *wordlist;
    NSArray *meaninglist;
    
    NSMutableDictionary *imgPos;
    NSMutableString *letterSeen;
    int x,y;
    NSMutableArray *questions;
    NSMutableArray *stack;
    
    NSMutableDictionary *gldict;
    NSMutableDictionary *wldict;
    int flag;
    int difficulty;
    int csf;
   // int How_To_Play;
    
}
@property(nonatomic,retain)NSMutableDictionary *glo;
@property(nonatomic,retain)id<GameDelegate> delegate;
@property(nonatomic,retain)NSArray *wl;
-(void)onCorrectTweenFinished:(SPEvent*)event;
-(void)KIIPNotificationShown;
-(void)KIIPNotificationClosed;
-(void)loadFile;
-(void)startGame;
-(void)How_To_Play_Method:(SPEvent*)event;
-(void)showTimer:(int)Seconds;
-(void)showWord;
-(void)getNewWord;
-(void)showMainScreen;
-(void)showAnimation:(NSString*)word;
-(void)letterTouched:(SPEvent*)event;
-(void)tweenCompleted:(SPEvent*)event;
-(void)animateCharacter:(NSString*)character;
-(void)checkAnswer;
-(void)endGame;
-(void)ResetButtonClicked:(SPEvent*)event;
-(void)showCorrectAnimation;
-(void)onCorrectTweenFinished:(SPEvent *)event;
-(void)onAlphaToZeroFinished:(SPEvent*)event;
-(void)aMethod:(id)sender;
-(void)playSound;
-(void)MenuButtonClicked:(SPEvent*)event;
-(void)GameButtonClicked:(SPEvent*)event;
-(int)getNumber;
-(int)NumberOfSetBits:(int) i;
-(void)ScreenButtonClicked:(SPEvent*)event;
-(void)showFinalScreen:(SPSprite*)sp;
-(void)next_sprit:(SPEvent*)event;
-(void)next_sprit1:(SPEvent *)event;
-(void)next_sprit2:(SPEvent *)event;
-(void)tutorialLettersTouched:(SPEvent*)event;
-(void)tutorialButtonPressed:(SPEvent*)event;
-(void)alphaCompleted:(SPEvent*)event;
-(void)spritButtonPressed:(SPEvent*)event;
-(void)showLastSprit:(SPEvent*)event;
-(void)tutclue:(SPEvent*)event;
-(void)start_game:(SPEvent*)event;
-(void)backtomain:(SPEvent*)event;
-(void)dismissTweenCompleted:(SPEvent*)event;
@end
