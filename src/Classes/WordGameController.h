//
//  WordGameController.h
//  Barebone
//
//  Created by Subramanian Venkatesan on 21/05/12.
//  Copyright 2012 SRv. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WordGameController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    
    id method;
    UIWebView *webview;
    NSArray *wordList;
    NSMutableDictionary *gl;
    NSString *html;
    
}
@property(nonatomic,retain)NSArray *wordList;
@property(nonatomic,retain)NSMutableDictionary *gl;
@property(nonatomic,retain)UIWebView *webview;
- (id)initWithTitle:(NSString*)aTitle method:(id)aMethod;
-(void)showInstructions;
-(void)showCredits;
-(void)showAbout;
-(void)showWordsSeen;
-(void)showHTML;
-(void)back;
@end
