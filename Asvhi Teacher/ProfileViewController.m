//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ProfileViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface ProfileViewController ()
{
    

}
@end

@implementation ProfileViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
   
    _viewLogout.layer.cornerRadius = 3;
    _viewLogout.layer.masksToBounds = YES;
    
    
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
        
        _imgUser.layer.frame = CGRectMake(139, 53, 100, 100);
        _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2.30;
        _imgUser.clipsToBounds = true;
        
    }

    
    
    [self.imgUser.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imgUser.layer setShadowOpacity:0.8];
    [self.imgUser.layer setShadowRadius:3.0];
    [self.imgUser.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.imgUser.layer.masksToBounds = YES;
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_PIC"] ];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default_profile_icon"]];
    
    
    
    
    _lblUserName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_NAME"] ];
    
    _lblEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_EMAIL"] ];
    
    _lblPhone.text = [NSString stringWithFormat:@"+91 %@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_PHONE"] ];
    

    
 
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickLogout:(id)sender {
    
    
    [UIAlertView showWithTitle:@"Logout"
                       message:@"Are you sure you want to Logout?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_ID"];
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_PIC"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_NAME"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_DESIGNATION"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_EMAIL"];
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"STAFF_PHONE"];
                              
                              
                              
                              HomeViewController *dashObj =[[HomeViewController alloc]init];
                              [self.navigationController pushViewController:dashObj animated:YES];
                          }
                      }];
    

    
}
@end
