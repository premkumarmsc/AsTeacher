//
//  HomeViewController.h
//  WescaleT
//
//  Created by SYZYGY on 17/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HomeViewController : UIViewController
{
    
    BOOL isUniqueIdVisible;
}
@property (weak, nonatomic) IBOutlet UITextField *emailFld;
@property (weak, nonatomic) IBOutlet UITextField *uniqueIdFld;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UITextField *txtForgotEmail;

- (IBAction)signINBtn:(id)sender;


- (IBAction)clickForgotPassword:(id)sender;
- (IBAction)clickForgotSubmit:(id)sender;
- (IBAction)clickBack:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *viewForget;
@property (weak, nonatomic) IBOutlet UIView *subViewForget;

@end
