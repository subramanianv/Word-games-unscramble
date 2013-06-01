//
//  WordGameController.m
//  Barebone
//
//  Created by Subramanian Venkatesan on 21/05/12.
//  Copyright 2012 SRv. All rights reserved.
//

#import "WordGameController.h"
#import "AppDelegate.h"
@implementation WordGameController
@synthesize webview,wordList,gl;
- (id)initWithTitle:(NSString*)aTitle method:(id)aMethod
{
    self = [super init];
    if (self) {
        self.title=aTitle;
        if([aMethod isKindOfClass:[NSDictionary class]])
            {
                [aMethod retain];
                method=(NSString*)[aMethod objectForKey:@"method"];
                [method retain];
                html=[aMethod objectForKey:@"html"];
                [html retain];
                
                [aMethod release];
            }
        else
            {
                method=(NSString*)aMethod;
                
            }
    }
    return self;
}
-(NSString*)FilePathString1
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0]stringByAppendingPathComponent:@"gl.plist"];
    
    
}

- (void)dealloc
{
    [super dealloc];
    
}
-(void)showHTML
{
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]autorelease];
    
    [self.webview loadHTMLString:html baseURL:nil];
    [html release];
    [method release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)showInstructions
{
    [self.webview loadHTMLString:@"<html><body><b>About the game</b><hr/><b>UnScramble</b> is a word game. The aim of the game is to find the word that is scrambled. You would be given with the meaning of the word. The difficulty of the words will increase as you proceed. You can win rewards as you finish certain levels.There are lots of rewards in the game. Make sure that the <b>internet connection</b> is on.<hr/><br/><img src=\"scramble.png\"><span style=\"position:relative;top:-10pt;\">- Scrambles the letters again.</span><br/><img src=\"bulb_ copy.png\"><span style=\"position:relative;top:-10pt;\">-Fills up a part of the word with the remaining letters for you to choose.You can use the clue only when there are no letters selected.</span><br/><img src=\"cross.png\"><span style=\"position:relative;top:-10pt;\">- To <b>quit/pause</b> the game.</span><br/><img src=\"next_arrow1.png\"<span style=\"position:relative;top:-12pt;\">-Show the <b>next word</b>.</span></body></html>" baseURL:[[NSBundle mainBundle]resourceURL]];
    
}
-(void)showAbout
{
    
}
-(void)showCredits
{[self.webview loadHTMLString:@"<html><body><b>Credits for the game</b><hr/><ul><li>Concept & Programming:<b>V Subramanian</b></li><li>Graphics & Sound :<b> S Sriramachandiran</b></li><li>Testing: <b>Meena Harish & Vidhya Arun</b></li><li>Word Meanings:<b>Wordnet 3.0</b></li></ul><hr/>This game was created using<br/><img src=\"sp.png\"/><hr/><b>Notes</b><ul><li>This is a <b>Kiip</b> enabled game.</li><li><b>Kiip</b> is not related to <b>Apple</b></li></ul></body></html>" baseURL:[[NSBundle mainBundle]resourceURL]];}





-(void)showWordsSeen
{
    self.view=nil;
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 289) style:UITableViewStyleGrouped];
   
    self.wordList=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"word.plist"]];
    
    self.gl=[[NSMutableDictionary new]autorelease];
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[self FilePathString1]];
    NSDictionary *cl=[dict objectForKey:@"wl"];
    
    for (int i=0; i<[[cl allKeys]count]; i++) {
        
       
        
        
        NSArray *r=[[cl objectForKey:[NSString stringWithFormat:@"%@",[[cl allKeys]objectAtIndex:i]]]objectForKey:@"ws"];
      
        for (int j=0; j<[r count]; j++) {
            
            NSDictionary *op=[self.wordList objectAtIndex:[[r objectAtIndex:j]intValue]];
            
            NSString *key=[[[[op allKeys]objectAtIndex:0]substringToIndex:1]uppercaseString];
            NSMutableArray *ap=[self.gl objectForKey:key];
            if (ap==NULL) {
                ap=[NSMutableArray arrayWithObject:op];
                
            }else [ap addObject:op];
            [self.gl setObject:ap forKey:key];
            
        }
        
    }
    
    table.delegate=self;
    table.dataSource=self;
    self.view=table;
        
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.gl allKeys]count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.gl objectForKey:[[[self.gl allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.gl allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *key=[[[self.gl allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]objectAtIndex:indexPath.section];
    NSString *word=[[[[self.gl objectForKey:key]objectAtIndex:indexPath.row]allKeys]objectAtIndex:0];
    NSString *w=[[[[self.gl objectForKey:key]objectAtIndex:indexPath.row]allValues]objectAtIndex:0];

    cell.textLabel.text=[NSString stringWithFormat:@"%@%@",[[word substringToIndex:1]uppercaseString],[word substringFromIndex:1]];
    float width=[w sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f]].width;
    width/=320.0f;
    int num=1;
    while (width>0)
    {
    num++;
    
    width--;
    }
    cell.detailTextLabel.numberOfLines=num;
    cell.detailTextLabel.text=w;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=18;
    NSString *key=[[[self.gl allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]objectAtIndex:indexPath.section];
    NSString *w=[[[[self.gl objectForKey:key]objectAtIndex:indexPath.row]allValues]objectAtIndex:0];
    float width=[w sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0f]].width;
    width/=320.0f;
    while (width>0)
        {
        height+=14;
        width--;
        }
    return height+20;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.gl allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)loadView
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.070 green:0.278 blue:0.501 alpha:1.0]];
    self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 480,320-32)];
    self.view=webview;
}
-(void)viewWillAppear:(BOOL)animated
{
    SEL methodSel=NSSelectorFromString(method);
    if ([self respondsToSelector:methodSel])
    {
        [self performSelector:methodSel];
        
    }
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.gl release];
    [self.wordList release];
}
    
-(void)back
{
    AppDelegate *del=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [del backButtonPressed];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
