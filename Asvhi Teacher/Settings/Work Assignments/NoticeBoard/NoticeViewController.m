//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "NoticeViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "AssignmentsViewController.h"


@interface NoticeViewController ()
{
    
    NSMutableArray *dataArray;
}
@end

@implementation NoticeViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
   
    
    
    

    

    
 
}



-(void)viewWillAppear:(BOOL)animated
{
    NSDateComponents *components= [[NSDateComponents alloc] init];
    [components setMinute:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate=[calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    
    
    long long milliseconds = (long long)([newDate timeIntervalSince1970]);
    
    
    
    
    NSLog(@"Time Stamp Home:%lld",milliseconds);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    
    [parameters setObject:@"0" forKey:@"timestamp"];
    
    //[parameters setObject:[NSString stringWithFormat:@"%lld",milliseconds] forKey:@"timestamp"];
    
    
    
    NSLog(@"Params:%@",parameters);
    
    
    dataArray = [[NSMutableArray alloc]init];
    
   
    
    [ProgressHUD show:nil];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/noticeboard/listall",ApiBaseURL];
    
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
            
            [dataArray addObjectsFromArray:[JSON valueForKeyPath:@"data"]];
            
            
            /*
            NSArray *tempArray = [JSON valueForKeyPath:@"data"];
            
            
            
            
            
            NSMutableArray *arr1=[[NSMutableArray alloc]init];
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            
            
            for(int i=0;i<[tempArray count];i++)
            {
                NSDictionary *dict = tempArray[i];
                
                
                if([[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"notice_type"]] intValue] ==2 )
                {
                    
                    [arr1 addObject:dict];
                }
                else
                {
                    [arr2 addObject:dict];
                }
                

            }
            
            
            [dataArray addObjectsFromArray:arr2];
            [dataArray addObjectsFromArray:arr1];

            */
            
            [ProgressHUD dismiss];
            
            
        }
        
        
        
        
        
        [_tblView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [dataArray count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    NoticeCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"NoticeCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (NoticeCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    cell1.viewBack.layer.cornerRadius = 5;
    cell1.viewBack.layer.masksToBounds = YES;
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    NSDictionary *dict = dataArray[indexPath.section];
    
  
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"notice_title"]];
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"notice_description"]];
    //cell1.lblSubject.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subject_name"]];
    
 
    
    
  
    NSString *start= [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"created"]];
    NSString *end= [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"due_date"]];
    
    NSDate * myDateStart = [NSDate dateWithTimeIntervalSince1970:[start longLongValue]];
    
    NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[end longLongValue]];;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSString *dayName = [dateFormatter stringFromDate:myDateStart];
    cell1.lblStart.text = dayName;
    
    
    dayName = [dateFormatter stringFromDate:myDateend];
    cell1.lblend.text = dayName;
    
    
    if([[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"homework_type"]] intValue] ==2 )
    {
        
       cell1.lblBottomTitle.text = @"AS";
    }
    else
    {
        cell1.lblBottomTitle.text = @"HW";
    }
    
    if(![[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"file_url"]]  isEqualToString:@"" ])
    {
        
        cell1.imgAttach.hidden = NO;
    }
    else
    {
        cell1.imgAttach.hidden = YES;
    }

    
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
    
    NSArray *favDataArr=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    //NSLog(@"FAV_DATA_ARR:%@",favDataArr);
    
    for(int i=0;i<[favDataArr count];i++)
    {
    
        NSDictionary *dictNew = favDataArr[i];
        
        
        
        NSString *idVal=[dict valueForKey:@"subject_id"];
        
        
        NSArray *idVa=[dictNew valueForKeyPath:@"subjects"];
        
        if([idVa count]==0)
        {
        
            NSString *idValNew1=[dictNew valueForKeyPath:@"id"];
            
            if([idValNew1 isEqualToString:idVal])
            {
              cell1.lblLevel.text = [NSString stringWithFormat:@"%@ %@",[dictNew valueForKeyPath:@"class_name"],[dictNew valueForKeyPath:@"section_name"]];
            }
        }
        else
        {
            for(int j=0;j<[idVa count];j++)
            {
                NSDictionary *dictNewval = idVa[j];
                
                
                
                NSString *idVal1=[dictNewval valueForKey:@"id"];
                
                
                if([idVal1 isEqualToString:idVal])
                {
                    cell1.lblLevel.text = [NSString stringWithFormat:@"%@ %@",[dictNew valueForKeyPath:@"class_name"],[dictNew valueForKeyPath:@"section_name"]];
                }
            }
            
        }
        
        
    }
    
    
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddNoticeController *dashObj =[[AddNoticeController alloc]init];
    
    
    NSDictionary *dict = dataArray[indexPath.section];

    
    
    
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"EDIT_NOTICE_DATA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"notice_id"]] forKey:@"ASSIGN_NOTICE_ID"];
    
    [self.navigationController pushViewController:dashObj animated:YES];

}


- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickAdd:(id)sender {
    
    
    AddNoticeController *dashObj =[[AddNoticeController alloc]init];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"ASSIGN_NOTICE_ID"];
    
    [self.navigationController pushViewController:dashObj animated:YES];
    
    
}
@end
