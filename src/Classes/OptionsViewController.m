//
//  OptionsViewController.m
//  Barebone
//
//  Created by Subramanian Venkatesan on 19/05/12.
//  Copyright 2012 SRv. All rights reserved.
//

#import "OptionsViewController.h"
#import "AppDelegate.h"
#import "WordGameController.h"
#import "Appirater.h"

@implementation OptionsViewController
@synthesize dict,seg,cellone,celltwo,sw;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Options";
        
    }
    return self;
}

- (void)dealloc
{
    [self.dict release];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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


- (void)viewDidLoad
{
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]autorelease];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.070 green:0.278 blue:0.501 alpha:1.0]];
    
    [super viewDidLoad];
    
    
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480,289) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
 
    self.dict=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"How to play",@"Credits",@"Words done correctly",nil],[NSArray arrayWithObjects:@"Recommend the app through e-mail",@"Rate the app",nil],nil] forKeys:[NSArray arrayWithObjects:@"0",@"2",nil]];
    [self.view addSubview:table];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary *d=[NSDictionary dictionaryWithContentsOfFile:[self FilePathString]];
    int time,sound;
    sound=[[d objectForKey:@"Sound"]intValue];
    time=[[d objectForKey:@"Time"]intValue];
    
    if (sound==1) [sw setOn:YES]; else [sw setOn:NO];
    
    if (time==2)[seg setSelectedSegmentIndex:0]; else if(time==4)[seg setSelectedSegmentIndex:1];
    else [seg setSelectedSegmentIndex:2];
    
    
    
    

    
}
-(void)buttonPressed:(id)sender
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithContentsOfFile:[self FilePathString]];

    
   // NSLog(@"%@",dict);

    int time,sound;
    switch (seg.selectedSegmentIndex) {
        case 0:
            time=2;
            break;
        case 1:
            time=4;
            break;
        case 2:
            time=6;
            break;
        default:
            break;
    }
    if (sw.on) sound=1; else sound=0;
    
    [dict setValue:[NSNumber numberWithInt:sound] forKey:@"Sound"];
    [dict setValue:[NSNumber numberWithInt:time] forKey:@"Time"];
    [dict writeToFile:[self FilePathString] atomically:YES];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 3;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *m;
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            m=@"showInstructions";
        }
        else if(indexPath.row==1) { m=@"showCredits";}else { m=@"showWordsSeen";}
        
        WordGameController *wc=[[WordGameController alloc]initWithTitle:[[self.dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]objectAtIndex:indexPath.row] method:(NSString*)m];
        [self.navigationController pushViewController:wc animated:YES];
        [wc release];
    }
   else if(indexPath.section==2)
       {
       if (indexPath.row==1) {
           
           [Appirater rateApp];
       }   
       else
        {
       Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
       if (mailClass != nil)
           {
           // We must always check whether the current device is configured for sending emails
           if ([mailClass canSendMail])
               {
                    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                    picker.mailComposeDelegate = self;
               
                    [picker setSubject:@"Try UnScramble"];
               NSString *emailBody = @"Hi,Learning words can never be more fun and rewarding. Thanks to the all new iPhone App : UnScramble. I learnt new words playing this game. I also earned real rewards playing this game.Please download <a href=\"http://goo.gl/YtsRZ\">Word Game UnScramble</a> from the <a href=\"http://goo.gl/YtsRZ\">iTunes store</a>";
               [picker setMessageBody:emailBody isHTML:YES];
               [self presentModalViewController:picker animated:YES];
               [picker release];

               }
           else
               {
               UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"You cannot send mail" message:@"Your mail client is not configured" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertview show];
               [alertview release];
               
                        
               
               }
           }
       else
           {    
               UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"You cannot send mail" message:@"Your mail client is not configured" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertview show];
               [alertview release];
               
           }
           
        }
       }
    else
        {
       
       if (indexPath.row==2) {
           
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Do you want to reset the game ?" message:@"Please select an option" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
           [alert show];
           [alert release];
           
                        }
       }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
 
    [self dismissModalViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[self.dict objectForKey:[NSString stringWithFormat:@"%d",section]]count];
            break;
            case 1:
            return 3;
            case 2:
            return 2;
            break;
          
        default:
            break;
    }
    return 0;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Word Game";
            break;
        case 1:
            return @"Settings";
            break;
        case 2:
            return @"Tell a friend";
            break;
        default:
            break;
    }
return @"lol";
}
-(void)viewDidDisappear:(BOOL)animated
{
  //  [self.dict release];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    if (indexPath.section==1)
    {
        
        if (indexPath.row==0) {return cellone;}
        else if(indexPath.row==1)
            return celltwo;
          }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        
    {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    // Configure the cell...
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=[[self.dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]objectAtIndex:indexPath.row];
            break;
            
         case 2:
            cell.textLabel.text=[[self.dict objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]objectAtIndex:indexPath.row];
            break;
        default:
            cell.textLabel.text=@"Reset";
            break;
}
    return cell;
    
}
-(void)back
{
    AppDelegate *del=[[UIApplication sharedApplication]delegate];
    [del backButtonPressed];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        
        NSDictionary *sett=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TSSettings" ofType:@"plist"]];
        [sett writeToFile:[self FilePathString] atomically:YES];
        
        NSDictionary *gldict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"gl" ofType:@"plist"]];
        [gldict writeToFile:[self FilePathString1] atomically:YES];
        [self viewWillAppear:NO];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reset" object:nil userInfo:nil];
        
        
        
    }
}


@end
