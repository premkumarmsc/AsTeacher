//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "TermsViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface TermsViewController ()
{
    

}
@end

@implementation TermsViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    self.topView.layer.masksToBounds = NO;
//    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
//    self.topView.layer.shadowRadius = 5;
//    self.topView.layer.shadowOpacity = 0.5;
    
    
    NSString *url = @"http://www.theashischool.com/Privacy-Policy";
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    [_webView loadRequest:request];
    
 
}



- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
