//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "CalendarViewController.h"
#import "DBCell.h"
#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface CalendarViewController ()
{
    DBCell *cell;
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation CalendarViewController

VRGCalendarView *calendarView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    calendarView = [[VRGCalendarView alloc] init];
    calendarView.delegate=self;
    
    
    
    _tblView.frame = CGRectMake(_tblView.frame.origin.x, calendarView.frame.size.height+10, _tblView.frame.size.width, _tblView.frame.size.height);
    
    [self.viewPageControl addSubview:calendarView];
    
    [self getDatas];
 
    
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
    
    
    [parameters setObject:@"0" forKey:@"timestamp"];

    //[parameters setObject:[NSString stringWithFormat:@"%lld",milliseconds] forKey:@"timestamp"];

    
    
    NSLog(@"Params:%@",parameters);
    
    
    
    
    dataArrayNew = [[NSMutableArray alloc]init];
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/teacher/listall_events",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forHTTPHeaderField:@"staff_id"];
    
    
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
            
            [dataArrayNew addObjectsFromArray:[JSON valueForKeyPath:@"data"]];
            
            [ProgressHUD dismiss];
            
            
        }
        
        NSLog(@"Data Array:%@",dataArrayNew);
        
       
       // [self pageAllocation];
        
        NSDate * myDateCurrent = [NSDate date];
        
        
        
        
        NSCalendar* calendarCurrent = [NSCalendar currentCalendar];
        
        
        
        NSDateComponents* componentsCurrent = [calendarCurrent components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDateCurrent]; // Get necessary date components
        
        NSMutableArray *datesArr = [[NSMutableArray alloc]init];
        
        for(int i=0;i<[dataArrayNew count];i++)
        {
            NSDictionary *dict = dataArrayNew[i];
            
            
            NSString *stringStart = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"start"]];
            
            NSString *stringEnd = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"endsd"]];
            
            
            NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
            
            NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
            
            
            
            
            NSCalendar* calendar = [NSCalendar currentCalendar];
            
            
            
            NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDateStart]; // Get necessary date components
            
            NSDateComponents* components1 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDateend]; // Get necessary date components
            
            
            
            NSLog(@"Hello:%ld",(long)[components month]);
            
            
            if ([componentsCurrent month]==[components month])
            {
                [datesArr addObject:[NSNumber numberWithInt:[components day]]];
            }
            
            if ([componentsCurrent month]==[components1 month])
            {
                [datesArr addObject:[NSNumber numberWithInt:[components1 day]]];
            }
            
            
            
            
            //[datesArr addObject:myDateend];
            
            
        }
        
        
        NSLog(@"Dates:%@",datesArr);
        
        // [calendarView markDates:datesArr];
        
        [calendarView markDates:datesArr];
        
        
        if([datesArr count]==0)
        {
            _lblNoEvents.hidden = NO;
            
            _lblNoEvents.text = @"No Events Found";
        }
        else
        {
            _lblNoEvents.hidden = YES;
            
            _lblNoEvents.text = @"Events Found";
        }
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        
        
        NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
        
        dataArray = [[NSMutableArray alloc]init];
        
        
        
        for(int i=0;i<[dataArrayNew count];i++)
        {
            NSDictionary *dict = dataArrayNew[i];
            
            
            NSString *stringStart = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"start"]];
            
            NSString *stringEnd = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"endsd"]];
            
            
            NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
            
            NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
            
            NSString *startdayName = [dateFormatter stringFromDate:myDateStart];
            NSString *enddayName = [dateFormatter stringFromDate:myDateend];
            
            
            if([dayName isEqualToString:startdayName]|| [dayName isEqualToString:enddayName] )
            {
                [dataArray addObject:dict];
            }
            
            
        }
        
        NSLog(@"Dates Arr:%@",dataArray);
        
        [dateFormatter setDateFormat:@"EEEE,MMMM dd"];
        
        
        NSString *dayNameNew = [dateFormatter stringFromDate:[NSDate date]];
        
        
        _currentLabel.text = [NSString stringWithFormat:@"  %@",dayNameNew];
        
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
    
    
    
    CallCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CallCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (CallCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
    
    
    NSString *stringStart = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"start"]];
    
    NSString *stringEnd = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"endsd"]];
    
    
    NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
    
    NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
    
    NSString *startdayName = [dateFormatter stringFromDate:myDateStart];
    NSString *enddayName = [dateFormatter stringFromDate:myDateend];
    
   
    
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@ - %@",startdayName,enddayName];
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"title"]];
   
   
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 68;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventDetailViewController *dashObj =[[EventDetailViewController alloc]init];
    NSDictionary *dict = dataArrayNew[indexPath.row];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"EVENT_DATA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:dashObj animated:YES];

}


-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    
    
    
    
    
    NSLog(@"Month:%@",calendarView.currentMonth);
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"EEEE,MMMM "];
    
    
    NSString *dayNameNew = [dateFormatter stringFromDate:calendarView.currentMonth];
    
    
    _currentLabel.text = [NSString stringWithFormat:@"  %@ 01",dayNameNew];

    
    
    
    NSMutableArray *datesArr = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[dataArrayNew count];i++)
    {
        NSDictionary *dict = dataArrayNew[i];
        
        
        NSString *stringStart = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"start"]];
        
        NSString *stringEnd = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"endsd"]];
        
        
        NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
        
        NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
        
        
        
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        
        
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDateStart]; // Get necessary date components
        
        NSDateComponents* components1 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDateend]; // Get necessary date components
        

        
        NSLog(@"Hello:%ld",(long)[components month]);
        
        
        if (month==[components month])
        {
             [datesArr addObject:[NSNumber numberWithInt:[components day]]];
        }

        if (month==[components1 month])
        {
            [datesArr addObject:[NSNumber numberWithInt:[components1 day]]];
        }

        
        
       
        //[datesArr addObject:myDateend];
        
        
    }
    
    
    NSLog(@"Dates:%@",datesArr);
    
    if([datesArr count]==0)
    {
        _lblNoEvents.hidden = NO;
        
        _lblNoEvents.text = @"No Events Found";
    }
    else
    {
        _lblNoEvents.hidden = YES;
        
        _lblNoEvents.text = @"Events Found";
    }
    
    // [calendarView markDates:datesArr];
    
    [calendarView markDates:datesArr];
    
    
    
    
    
    
    dataArray = [[NSMutableArray alloc]init];
    
    [_tblView reloadData];

    
    
    
    
    
    NSLog(@"Hello:%f",targetHeight);
    
    
    int calculateWidth = self.viewPageControl.frame.size.height - targetHeight ;
    
     _tblView.frame = CGRectMake(_tblView.frame.origin.x, targetHeight+5, _tblView.frame.size.width, calculateWidth-5);
    
    
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    
     //_tblView.frame = CGRectMake(_tblView.frame.origin.x, calendarView.frame.size.height+10, _tblView.frame.size.width, _tblView.frame.size.height);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    
    NSString *dayName = [dateFormatter stringFromDate:date];
    
    dataArray = [[NSMutableArray alloc]init];
    
    
    
    for(int i=0;i<[dataArrayNew count];i++)
    {
        NSDictionary *dict = dataArrayNew[i];
        
        
        NSString *stringStart = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"start"]];
        
        NSString *stringEnd = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"endsd"]];
        
        
        NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[stringEnd longLongValue]];;
        
        NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[stringStart longLongValue]];;
        
        NSString *startdayName = [dateFormatter stringFromDate:myDateStart];
        NSString *enddayName = [dateFormatter stringFromDate:myDateend];
        
        
        if([dayName isEqualToString:startdayName]|| [dayName isEqualToString:enddayName] )
        {
            [dataArray addObject:dict];
        }
        
        
    }

    NSLog(@"Dates Arr:%@",dataArray);
    
    
    [dateFormatter setDateFormat:@"EEEE,MMMM dd"];
    
    
    NSString *dayNameNew = [dateFormatter stringFromDate:date];
    
    
    _currentLabel.text = [NSString stringWithFormat:@"  %@",dayNameNew];
    
    
    [_tblView reloadData];
    
}




@end
