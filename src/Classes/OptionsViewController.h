//
//  OptionsViewController.h
//  Barebone
//
//  Created by Subramanian Venkatesan on 19/05/12.
//  Copyright 2012 SRv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface OptionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,MFMailComposeViewControllerDelegate> {
    UITableView *table;
    NSDictionary *dict;
    
}
@property(nonatomic,retain)IBOutlet UISwitch *sw;
@property(nonatomic,retain)IBOutlet UISegmentedControl *seg;
@property(nonatomic,retain)IBOutlet UITableViewCell *cellone;
@property(nonatomic,retain)IBOutlet UITableViewCell *celltwo;
@property(nonatomic,retain)NSDictionary *dict;
-(IBAction)buttonPressed:(id)sender;
-(void)back;
@end
