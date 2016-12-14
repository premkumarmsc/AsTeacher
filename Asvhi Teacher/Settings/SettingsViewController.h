//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface SettingsViewController : UIViewController

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIView *viewLogout;
- (IBAction)clickLogout:(id)sender;

- (IBAction)clickAccount:(id)sender;
- (IBAction)clickChangePassword:(id)sender;
- (IBAction)clickTC:(id)sender;
- (IBAction)clickHelp:(id)sender;
- (IBAction)clickAbout:(id)sender;



@end
