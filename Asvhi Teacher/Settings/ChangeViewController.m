//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ChangeViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface ChangeViewController ()
{
    

}
@end

@implementation ChangeViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
   
    _viewLogout.layer.cornerRadius = 3;
    _viewLogout.layer.masksToBounds = YES;
    
    
    [self.imgUser.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imgUser.layer setShadowOpacity:0.8];
    [self.imgUser.layer setShadowRadius:3.0];
    [self.imgUser.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.imgUser.layer.masksToBounds = YES;
    
    
    

    
 
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickLogout:(id)sender {
    
    
    if([_txtOld.text isEqualToString:@""])
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please enter old password";
        hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
        hud.yOffset = 250.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        
        if([_txtNew.text isEqualToString:@""])
        {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Please enter new password";
            hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
            hud.yOffset = 250.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:2];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
            
            if([_txtRetype.text isEqualToString:@""])
            {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"Please enter confirm password";
                hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                hud.yOffset = 250.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                
                // [_emailFld becomeFirstResponder];
            }
            else
            {

                if(_txtRetype.text.length < 6 || _txtNew.text.length < 6 || _txtOld.text.length < 6)
                {
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"Password length minimum 6 characters";
                    hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                    hud.yOffset = 250.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hideAnimated:YES afterDelay:2];
                    
                    // [_emailFld becomeFirstResponder];
                }
                else
                {
                    
                    if(![_txtRetype.text isEqualToString:_txtNew.text])
                    {
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text = @"Password does not match";
                        hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                        hud.yOffset = 250.f;
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hideAnimated:YES afterDelay:2];

                        
                    }
                    else
                    {
        
        [ProgressHUD show:nil];
        
        //[MBProgressHUD show];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                        
        [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_EMAIL"] ] forKey:@"email"];
        
        [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_PHONE"] ] forKey:@"mobile"];
                        
        [parameters setObject:[NSString stringWithFormat:@"%@",_txtOld.text] forKey:@"old_pass"];
                        
         [parameters setObject:[NSString stringWithFormat:@"%@",_txtNew.text] forKey:@"new_pass"];
        
        
        NSLog(@"Params:%@",parameters);
        
        
        NSString *urlString=[NSString stringWithFormat:@"%@/pindex/password_change",ApiBaseURLNew];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            // NSLog(@"Success: %@", responseObject);
            
            NSError *error = nil;
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            NSLog(@"JSON:%@",JSON);
            
            if ([[JSON valueForKey:@"status"] intValue]!=200)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = [JSON valueForKeyPath:@"message"][0];
                hud.label.numberOfLines =2;
                
                hud.label.adjustsFontSizeToFitWidth=YES;
                hud.label.minimumScaleFactor=0.5;
                
                hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                hud.yOffset = 250.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                
                [ProgressHUD dismiss];
            }
            else
            {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"Successfully changed the password.";
                hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                hud.yOffset = 250.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                
                [ProgressHUD dismiss];
                
               [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            
            
            
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
            
            
            [ProgressHUD showError:error.localizedDescription];
            
            
        }];
        
        }
            }
            }
        
        }
        
        
        
        
    }
    

    
}
@end
