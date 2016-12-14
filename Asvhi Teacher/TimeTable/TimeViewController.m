//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "TimeViewController.h"
#import "DBCell.h"
#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface TimeViewController ()
{
    DBCell *cell;
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation TimeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleSwipeLeft:)];
    [swipeLeftGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleSwipeRight:)];
    
    [swipeRightGesture setDirection: UISwipeGestureRecognizerDirectionRight];
    
    [self.tblView addGestureRecognizer:swipeLeftGesture];
    [self.tblView  addGestureRecognizer:swipeRightGesture];
    
    [self getDatas];
 
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Left");
    if(currentIndex != 7-1)
    {
        currentIndex = currentIndex + 1;
       pageControlObj.iFirstVisiblePageNumber  = currentIndex;
        
        [pageControlObj.view removeFromSuperview];
        
        
        //page 0
        ADPageModel *pageModel0 = [[ADPageModel alloc] init];
        
        pageModel0.strPageTitle = @"MON";
        pageModel0.iPageNumber = 0;
        pageModel0.bShouldLazyLoad = YES;
        
        //page 1
        ADPageModel *pageModel1 = [[ADPageModel alloc] init];
        pageModel1.strPageTitle = @"TUE";
        pageModel1.iPageNumber = 1;
        pageModel1.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel2 = [[ADPageModel alloc] init];
        pageModel2.strPageTitle = @"WED";
        pageModel2.iPageNumber = 2;
        pageModel2.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel3 = [[ADPageModel alloc] init];
        pageModel3.strPageTitle = @"THU";
        pageModel3.iPageNumber = 2;
        pageModel3.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel4 = [[ADPageModel alloc] init];
        pageModel4.strPageTitle = @"FRI";
        pageModel4.iPageNumber = 2;
        pageModel4.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel5 = [[ADPageModel alloc] init];
        pageModel5.strPageTitle = @"SAT";
        pageModel5.iPageNumber = 2;
        pageModel5.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel6 = [[ADPageModel alloc] init];
        pageModel6.strPageTitle = @"SUN";
        pageModel6.iPageNumber = 2;
        pageModel6.bShouldLazyLoad = YES;
        
        
        
        /**** 2. Initialize page control ****/
        
        pageControlObj = [[ADPageControl alloc] init];
        pageControlObj.delegateADPageControl = self;
        pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2,pageModel3,pageModel4,pageModel5,pageModel6, nil];
        
        /**** 3. Customize parameters (Optinal, as all have default value set) ****/
        
        pageControlObj.iFirstVisiblePageNumber = currentIndex;
        
        
        
        pageControlObj.iTitleViewHeight = 45;
        pageControlObj.iPageIndicatorHeight = 4;
        pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        pageControlObj.bEnablePagesEndBounceEffect = NO;
        pageControlObj.bEnableTitlesEndBounceEffect = NO;
        pageControlObj.colorTabText = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];
        pageControlObj.colorTitleBarBackground = [UIColor whiteColor];
        pageControlObj.colorPageIndicator = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];
        
        pageControlObj.colorPageOverscrollBackground = [UIColor whiteColor];
        pageControlObj.bShowMoreTabAvailableIndicator = NO;
        
        pageControlObj.view.frame = CGRectMake(0, 0, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
        
        [self.viewPageControl addSubview:pageControlObj.view];
        

        
        
        dataArray = [[NSMutableArray alloc]init];
        
        for(int i=0;i<[dataArrayNew count];i++)
        {
            NSDictionary *dict = dataArrayNew[i];
            
            
            NSString *weekDay = [dict valueForKey:@"week_day"];
            
            if([weekDay intValue] == currentIndex+1)
            {
                [dataArray addObject:dict];
            }
            
        }
        
        
        
        [_tblView reloadData];
    }
    else
    {
        
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {
    
    NSLog(@"Right");
    
    if(currentIndex != 0)
    {
        
        currentIndex = currentIndex - 1;
        
        
        [pageControlObj.view removeFromSuperview];
        
        
        //page 0
        ADPageModel *pageModel0 = [[ADPageModel alloc] init];
        
        pageModel0.strPageTitle = @"MON";
        pageModel0.iPageNumber = 0;
        pageModel0.bShouldLazyLoad = YES;
        
        //page 1
        ADPageModel *pageModel1 = [[ADPageModel alloc] init];
        pageModel1.strPageTitle = @"TUE";
        pageModel1.iPageNumber = 1;
        pageModel1.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel2 = [[ADPageModel alloc] init];
        pageModel2.strPageTitle = @"WED";
        pageModel2.iPageNumber = 2;
        pageModel2.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel3 = [[ADPageModel alloc] init];
        pageModel3.strPageTitle = @"THU";
        pageModel3.iPageNumber = 2;
        pageModel3.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel4 = [[ADPageModel alloc] init];
        pageModel4.strPageTitle = @"FRI";
        pageModel4.iPageNumber = 2;
        pageModel4.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel5 = [[ADPageModel alloc] init];
        pageModel5.strPageTitle = @"SAT";
        pageModel5.iPageNumber = 2;
        pageModel5.bShouldLazyLoad = YES;
        
        //page 2
        ADPageModel *pageModel6 = [[ADPageModel alloc] init];
        pageModel6.strPageTitle = @"SUN";
        pageModel6.iPageNumber = 2;
        pageModel6.bShouldLazyLoad = YES;
        
        
        
        /**** 2. Initialize page control ****/
        
        pageControlObj = [[ADPageControl alloc] init];
        pageControlObj.delegateADPageControl = self;
        pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2,pageModel3,pageModel4,pageModel5,pageModel6, nil];
        
        /**** 3. Customize parameters (Optinal, as all have default value set) ****/
        
        pageControlObj.iFirstVisiblePageNumber = currentIndex;
        
        
        
        pageControlObj.iTitleViewHeight = 45;
        pageControlObj.iPageIndicatorHeight = 4;
        pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        pageControlObj.bEnablePagesEndBounceEffect = NO;
        pageControlObj.bEnableTitlesEndBounceEffect = NO;
        pageControlObj.colorTabText = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];
        pageControlObj.colorTitleBarBackground = [UIColor whiteColor];
        pageControlObj.colorPageIndicator = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];
        
        pageControlObj.colorPageOverscrollBackground = [UIColor whiteColor];
        pageControlObj.bShowMoreTabAvailableIndicator = NO;
        
        pageControlObj.view.frame = CGRectMake(0, 0, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
        
        [self.viewPageControl addSubview:pageControlObj.view];
        
        

        
        
        dataArray = [[NSMutableArray alloc]init];
        
        for(int i=0;i<[dataArrayNew count];i++)
        {
            NSDictionary *dict = dataArrayNew[i];
            
            
            NSString *weekDay = [dict valueForKey:@"week_day"];
            
            if([weekDay intValue] == currentIndex+1)
            {
                [dataArray addObject:dict];
            }
            
        }
        
        
        [_tblView reloadData];
    }
    else
    {
        currentIndex = 0;
    }
    
}



-(void)pageAllocation
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    NSString *dayName = [[dateFormatter stringFromDate:[NSDate date]] uppercaseString];
    
    NSLog(@"Day:%@",dayName);
    
    //page 0
    ADPageModel *pageModel0 = [[ADPageModel alloc] init];
    
    pageModel0.strPageTitle = @"MON";
    pageModel0.iPageNumber = 0;
    pageModel0.bShouldLazyLoad = YES;
    
    //page 1
    ADPageModel *pageModel1 = [[ADPageModel alloc] init];
    pageModel1.strPageTitle = @"TUE";
    pageModel1.iPageNumber = 1;
    pageModel1.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel2 = [[ADPageModel alloc] init];
    pageModel2.strPageTitle = @"WED";
    pageModel2.iPageNumber = 2;
    pageModel2.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel3 = [[ADPageModel alloc] init];
    pageModel3.strPageTitle = @"THU";
    pageModel3.iPageNumber = 2;
    pageModel3.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel4 = [[ADPageModel alloc] init];
    pageModel4.strPageTitle = @"FRI";
    pageModel4.iPageNumber = 2;
    pageModel4.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel5 = [[ADPageModel alloc] init];
    pageModel5.strPageTitle = @"SAT";
    pageModel5.iPageNumber = 2;
    pageModel5.bShouldLazyLoad = YES;
    
    //page 2
    ADPageModel *pageModel6 = [[ADPageModel alloc] init];
    pageModel6.strPageTitle = @"SUN";
    pageModel6.iPageNumber = 2;
    pageModel6.bShouldLazyLoad = YES;
    
    
    
    /**** 2. Initialize page control ****/
    
    pageControlObj = [[ADPageControl alloc] init];
    pageControlObj.delegateADPageControl = self;
    pageControlObj.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModel0,pageModel1,pageModel2,pageModel3,pageModel4,pageModel5,pageModel6, nil];
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    
    //pageControlObj.iFirstVisiblePageNumber = 0;
    
    
    NSString *upperStr=[dayName uppercaseString];
    
    
    
    
    SWITCH (upperStr)
    {
        CASE (@"MON") {
            pageControlObj.iFirstVisiblePageNumber = 0;
            break;
        }
        CASE (@"TUE") {
            pageControlObj.iFirstVisiblePageNumber = 1;
            break;
        }
        CASE (@"WED") {
            pageControlObj.iFirstVisiblePageNumber = 2;
            break;
        }
        CASE (@"THU") {
            pageControlObj.iFirstVisiblePageNumber = 3;
            break;
        }
        CASE (@"FRI") {
            pageControlObj.iFirstVisiblePageNumber = 4;
            break;
        }
        CASE (@"SAT") {
            pageControlObj.iFirstVisiblePageNumber = 5;
            break;
        }
        CASE (@"SUN") {
            pageControlObj.iFirstVisiblePageNumber = 6;
            break;
        }
        DEFAULT {
            break;
        }
    }
    
    currentIndex = pageControlObj.iFirstVisiblePageNumber;
    
    pageControlObj.iTitleViewHeight = 45;
    pageControlObj.iPageIndicatorHeight = 4;
    pageControlObj.fontTitleTabText =  [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    pageControlObj.bEnablePagesEndBounceEffect = NO;
    pageControlObj.bEnableTitlesEndBounceEffect = NO;
    pageControlObj.colorTabText = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];
    pageControlObj.colorTitleBarBackground = [UIColor whiteColor];
    pageControlObj.colorPageIndicator = [UIColor colorWithRed:0.0/255.0 green:161.0/255.0 blue:195.0/255.0 alpha:1.0f];

    pageControlObj.colorPageOverscrollBackground = [UIColor whiteColor];
    pageControlObj.bShowMoreTabAvailableIndicator = NO;
    
    pageControlObj.view.frame = CGRectMake(0, 0, self.viewPageControl.frame.size.width, self.viewPageControl.frame.size.height);
    
    [self.viewPageControl addSubview:pageControlObj.view];
    
    
    
    dataArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[dataArrayNew count];i++)
    {
        NSDictionary *dict = dataArrayNew[i];
        
        
        NSString *weekDay = [dict valueForKey:@"week_day"];
        
        if([weekDay intValue] == pageControlObj.iFirstVisiblePageNumber+1)
        {
            [dataArray addObject:dict];
        }
        
    }
    
    [_tblView reloadData];
    
    
}
-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    
    
    
    
    return nil;
}

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
    
    
    currentIndex = iCurrentVisiblePage;
    
    dataArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[dataArrayNew count];i++)
    {
        NSDictionary *dict = dataArrayNew[i];
        
        
        NSString *weekDay = [dict valueForKey:@"week_day"];
        
        if([weekDay intValue] == iCurrentVisiblePage+1)
        {
            [dataArray addObject:dict];
        }
        
    }
    
    
    [_tblView reloadData];
    
}

-(void)getDatas
{
    [ProgressHUD show:nil];
    
    //[MBProgressHUD show];
    
    
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setMinute:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate=[calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:newDate];
    _lblDay.text = dayName;
    
    
    [dateFormatter setDateFormat:@"MMMM"];
    dayName = [dateFormatter stringFromDate:newDate];
    _lblmonth.text = dayName;
    
    [dateFormatter setDateFormat:@"dd"];
    dayName = [dateFormatter stringFromDate:newDate];
    _lbldate.text = dayName;

    
    long long milliseconds = (long long)([newDate timeIntervalSince1970]);
    
    
    
    
    NSLog(@"Time Stamp Home:%lld",milliseconds);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    
    //[parameters setObject:@"1466533800" forKey:@"timestamp"];

    [parameters setObject:[NSString stringWithFormat:@"%lld",milliseconds] forKey:@"timestamp"];

    
    
    NSLog(@"Params:%@",parameters);
    
    
    
    
    dataArrayNew = [[NSMutableArray alloc]init];
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/teachertimetable/listall",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forHTTPHeaderField:@"staff_id"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
            
            [dataArrayNew addObjectsFromArray:[JSON valueForKeyPath:@"data"]];
            
            [ProgressHUD dismiss];
            
            
        }
        
        NSLog(@"Data Array:%@",dataArrayNew);
        
       
        [self pageAllocation];
        
        
        
        
        [_tblView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
}



- (IBAction)backBtn:(id)sender
{
    

    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataArray count];
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    TimeCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"TimeCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (TimeCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    
    
    NSArray* foo = [[dict valueForKeyPath:@"start_time"] componentsSeparatedByString: @":"];
    
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@:%@",foo[0],foo[1]];
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subject_name"]];
    
    cell1.lblSubject.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKeyPath:@"class_name"],[dict valueForKeyPath:@"section_name"]];
   
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 68;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



@end
