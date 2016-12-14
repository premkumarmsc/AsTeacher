//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "EventDetailViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface EventDetailViewController ()
{
    

}
@end

@implementation EventDetailViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
   
    _viewLogout.layer.cornerRadius = 3;
    _viewLogout.layer.masksToBounds = YES;
    
    
  
    
    
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"EVENT_DATA"];
    
    NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"FAV_DATA_ARR:%@",datadict);
    

    
    self.imgUser.layer.masksToBounds = YES;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
    
    
    NSString *stringStart = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"start"]];
    
    NSString *stringEnd = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"endsd"]];
    
    
    NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
    
    NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
    
    NSString *startdayName = [dateFormatter stringFromDate:myDateStart];
    NSString *enddayName = [dateFormatter stringFromDate:myDateend];
    
    
    

    
    
    
    _lblUserName.text = [NSString stringWithFormat:@" %@",[datadict valueForKey:@"title"] ];;
    
    _lblRegNo.text = [NSString stringWithFormat:@": %@",[datadict valueForKey:@"event_organizer"] ];
    
    
    
    
    
    _lblFather.text = [NSString stringWithFormat:@": %@",startdayName ];
    
    _lblMother.text = [NSString stringWithFormat:@": %@",enddayName ];
    
    
   
    
    _lblEmail.text = [NSString stringWithFormat:@"%@",[datadict valueForKey:@"event_description"] ];
    
    

    
    
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickEventWeb:(id)sender {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"EVENT_DATA"];
    
    NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"FAV_DATA_ARR:%@",datadict);
    
    NSString *stringStart = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"url"]];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringStart]];

}
@end
