//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "StudentProfileViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface StudentProfileViewController ()
{
    

}
@end

@implementation StudentProfileViewController




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
        
        _imgUser.layer.frame = CGRectMake(149, 18, 80, 80);
        _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2.30;
        _imgUser.clipsToBounds = true;
        
    }

    
    
    [self.imgUser.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imgUser.layer setShadowOpacity:0.8];
    [self.imgUser.layer setShadowRadius:3.0];
    [self.imgUser.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"PROFILE_DATA"];
    
    NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"FAV_DATA_ARR:%@",datadict);
    

    
    self.imgUser.layer.masksToBounds = YES;
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[datadict valueForKey:@"file_url"] ];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default_profile_icon"]];
    
    
    
    
    _lblUserName.text = [NSString stringWithFormat:@" %@",[datadict valueForKey:@"student_name"] ];;
    
    _lblEmail.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"contact_email"] ];
    
    _lblPhone.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"mobile_number"] ];
    
    _lblRegNo.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"registration_number"] ];
    
    
    NSString *dob = [datadict valueForKey:@"date_of_birth"];
    NSString *gender = [datadict valueForKey:@"gender"];
    
    if([gender intValue]==2)
    {
        _lblGender.text = [NSString stringWithFormat:@": Femaile"];
        
 
    }
    else
    {
        _lblGender.text = [NSString stringWithFormat:@": Male"];
    }
    
    
    
    
    NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[dob longLongValue]];;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *dayName = [dateFormatter stringFromDate:myDateend];
   
  
    
    
    _lblDOB.text = [NSString stringWithFormat:@": %@",dayName ];
    
    
    _lblFather.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"father_name"] ];
    _lblMother.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"mother_name"] ];
    _lblAddress.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"permanent_address"] ];
    //_lblPhone.text = [NSString stringWithFormat:@":%@",[datadict valueForKey:@"mobile_number"] ];
    

    
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
