//
//  HomeViewController.m
//  WescaleT
//
//  Created by SYZYGY on 17/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "HomeViewController.h"
#import "FavouritesViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController


NSString *allDetails;
NSString *validEmail;

- (void)viewDidLoad
{
    
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"].length == 0)
    {
        
    }
    else
    {
        
        DashboardViewController *dashObj =[[DashboardViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        

    }
    
    [self.emailFld setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.txtForgotEmail setValue:[UIColor whiteColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.uniqueIdFld setValue:[UIColor whiteColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    
   
    
    
    
        self.navigationController.navigationBarHidden = TRUE;
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)signINBtn:(id)sender
{
    
    FavouritesViewController *dashObj =[[FavouritesViewController alloc]init];
    //[self.navigationController pushViewController:dashObj animated:YES];

   
    
    if (_emailFld.text.length ==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please enter emailId";
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
        
        if(![self NSStringIsValidEmail:_emailFld.text])
        {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Please enter valid emailId";
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
            if (_uniqueIdFld.text.length ==0 )
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"Please enter password";
                hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                hud.yOffset = 250.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                
                //[_uniqueIdFld becomeFirstResponder];
            }
            else
            {
                NSLog(@"Next");
                
                [ProgressHUD show:nil];
                
                //[MBProgressHUD show];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:_emailFld.text forKey:@"username"];
                [parameters setObject:_uniqueIdFld.text forKey:@"password"];
                
                
                NSLog(@"Params:%@",parameters);
                
                
                NSString *urlString=[NSString stringWithFormat:@"%@/teacher/login",ApiBaseURL];
                
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
                    
                    if ([[JSON valueForKey:@"status"] intValue]==400)
                    {
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text = [JSON valueForKeyPath:@"message"][0];
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
                        
                        [ProgressHUD dismiss];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.staff_id"] forKey:@"STAFF_ID"];
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.prof_pic_url"] forKey:@"STAFF_PIC"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.name"] forKey:@"STAFF_NAME"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.designation"] forKey:@"STAFF_DESIGNATION"];
                        
                         [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.aauth_email"] forKey:@"STAFF_EMAIL"];
                        
                         [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_data.aauth_mobile"] forKey:@"STAFF_PHONE"];
                        
                        
                         [[NSUserDefaults standardUserDefaults]setObject:@"OUT" forKey:@"FAV_COME"];
                        FavouritesViewController *dashObj =[[FavouritesViewController alloc]init];
                        [self.navigationController pushViewController:dashObj animated:YES];
                        

                    }
                    
                  
                    
                    
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    
                    [ProgressHUD showError:error.localizedDescription];
                    
                    
                }];
            
                
                
                
                           }
          
        }

        
     
    }
  
}

- (IBAction)clickForgotPassword:(id)sender {
    
    
    _viewForget.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    _subViewForget.layer.cornerRadius = 5;
    _subViewForget.layer.masksToBounds = YES;
    
    _viewForget.hidden = NO;
    
    [self.view addSubview:_viewForget];
    
}

- (IBAction)clickForgotSubmit:(id)sender {
    
    if (_txtForgotEmail.text.length ==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please enter emailId";
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
        
        if(![self NSStringIsValidEmail:_txtForgotEmail.text])
        {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Please enter valid emailId";
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
            
            [ProgressHUD show:nil];
            
            //[MBProgressHUD show];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:_txtForgotEmail.text forKey:@"mail_mobile"];
            
            
            
            NSLog(@"Params:%@",parameters);
            
            
            NSString *urlString=[NSString stringWithFormat:@"%@/teacher/password_reset",ApiBaseURL];
            
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
                    hud.label.text = @"password is sent to your mail Id.";
                    hud.label.numberOfLines =2;
                            
                            hud.label.adjustsFontSizeToFitWidth=YES;
                            hud.label.minimumScaleFactor=0.5;
                            
                            hud.margin = 10.f;
                    hud.yOffset = 250.f;
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hideAnimated:YES afterDelay:2];
                    
                    [ProgressHUD dismiss];

                    
                 
                    
                    _txtForgotEmail.text = @"";
                    _viewForget.hidden = YES;
                    [_txtForgotEmail resignFirstResponder];
                    
                }
                
                
                
                
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@", error);
                
                
                [ProgressHUD showError:error.localizedDescription];
                
                
            }];
            
            
            
            
        
        
        
        
        }
    }


}

- (IBAction)clickBack:(id)sender {
    
    
    _txtForgotEmail.text = @"";
    
    _viewForget.hidden = YES;
    [_txtForgotEmail resignFirstResponder];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
