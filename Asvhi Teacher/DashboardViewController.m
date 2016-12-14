//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "DashboardViewController.h"
#import "DBCell.h"
#import "AFNetworking.h"


@interface DashboardViewController ()
{
    DBCell *cell;
    NSMutableArray *dataArray;
}
@end

@implementation DashboardViewController


NSMutableArray *checkMarkArrayNew;
int totalChecked;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [self.collectionViewFav registerNib:[UINib nibWithNibName:@"DBCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
      
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
    
    NSArray *favDataArr=[NSKeyedUnarchiver unarchiveObjectWithData:data2];

    NSLog(@"FAV_DATA_ARR:%@",favDataArr);
    
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
    
    
    //[parameters setObject:@"1466533800" forKey:@"timestamp"];

    [parameters setObject:[NSString stringWithFormat:@"%lld",milliseconds] forKey:@"timestamp"];

    
    
    NSLog(@"Params:%@",parameters);
    
    
    dataArray = [[NSMutableArray alloc]init];
    checkMarkArrayNew = [[NSMutableArray alloc]init];
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/teacherdashboard/listall",ApiBaseURL];
    
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
            
            [dataArray addObjectsFromArray:[JSON valueForKeyPath:@"data.timetable"]];
            
            [ProgressHUD dismiss];
            
            
        }
        
        for(int i=0;i<[dataArray count];i++)
        {
            if(i==0)
            {
                [checkMarkArrayNew addObject:@"1"];
            }
            else
            {
                [checkMarkArrayNew addObject:@"0"];
            }
        }
        
        [_collectionViewFav reloadData];
        
        
        _lblClasses.text = [NSString stringWithFormat:@"%lu",(unsigned long)[dataArray count]];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    
    return [dataArray count];
}

- (DBCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    cell.lblClass.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKeyPath:@"class_name"],[dict valueForKeyPath:@"section_name"]];
    
    
    NSArray* foo = [[dict valueForKeyPath:@"start_time"] componentsSeparatedByString: @":"];
    
    
    cell.lblFrom.text = [NSString stringWithFormat:@"%@:%@",foo[0],foo[1]];
    
    foo = [[dict valueForKeyPath:@"end_time"] componentsSeparatedByString: @":"];
    
    cell.lblTo.text = [NSString stringWithFormat:@"%@:%@",foo[0],foo[1]];
    
    cell.lblSubject.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subject_name"]];
    
    
    
    if([checkMarkArrayNew[indexPath.item] intValue]==0)
    {
        cell.favView.backgroundColor = [UIColor colorWithRed:(248/255.0) green:(158/255.0) blue:(112/255.0) alpha:1];
    }
    else
    {
         cell.favView.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(100/255.0) blue:(72/255.0) alpha:1];

    }
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    for(int i=0;i<[dataArray count];i++)
    {
        
        
        if(i == indexPath.row)
        {
            [checkMarkArrayNew replaceObjectAtIndex:i withObject:@"1"];
        }
        else
        {
            [checkMarkArrayNew replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    
    
   // NSLog(@"CM ARRAY:%@",checkMarkArrayNew);
    
    
    [self.collectionViewFav reloadData];
    
    
   

   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(125, 70);
}



- (IBAction)backBtn:(id)sender
{
    

    CGRect basketTopFrame = _backView.frame;
    // basketTopFrame.origin.x = -basketTopFrame.size.width;
    
    
    /*
    if(IS_IPHONE_6){
        basketTopFrame.origin.x = 300;
    }
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
        basketTopFrame.origin.x = 250;
    }
    if(IS_IPHONE_6P){
        basketTopFrame.origin.x = 330;
    }
    */
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _backView.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         //NSLog(@"Done 1233!");
         
         
         
         
     }];
    
    
    
    
    
    
    SideView *sideView=[[SideView alloc]init];
    sideView.delegate= self;
    sideView.frame = self.view.bounds;
    [self.view addSubview:sideView];
    
}

- (void)didTapSomeButton:(NSString *)getController
{
    NSLog(@"Tabbed:%@",getController);
    
    if ([getController isEqualToString:@"UserProfile"]) {
        
        
        
        
        ProfileViewController *dashObj =[[ProfileViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        

        
        
        
        
    }
    
    if ([getController isEqualToString:@"UserSettings"]) {
        
        
        
        
        SettingsViewController *dashObj =[[SettingsViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    
    if ([getController isEqualToString:@"Favourites"]) {
        
        
        
        
        FavouritesViewController *dashObj =[[FavouritesViewController alloc]init];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"IN" forKey:@"FAV_COME"];
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    
    if ([getController isEqualToString:@"Work Assignment"]) {
        
        
        
        
        AssignmentsViewController *dashObj =[[AssignmentsViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    
    if ([getController isEqualToString:@"Attendance"]) {
        
        
        
        
        AttendanceViewController *dashObj =[[AttendanceViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    
    
    if ([getController isEqualToString:@"Remark"]) {
        
        RemarksViewController *dashObj =[[RemarksViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
        }

    
    if ([getController isEqualToString:@"Notice Board"]) {
        
        NoticeViewController *dashObj =[[NoticeViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    if ([getController isEqualToString:@"Student Profile"]) {
        
        StudentsViewController *dashObj =[[StudentsViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }

    if ([getController isEqualToString:@"Time Table"]) {
        
        TimeViewController *dashObj =[[TimeViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    if ([getController isEqualToString:@"Calendar"]) {
        
        CalendarViewController *dashObj =[[CalendarViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    
    if ([getController isEqualToString:@"Results"]) {
        
        ResultsViewController *dashObj =[[ResultsViewController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    
    if ([getController isEqualToString:@"Gallery"]) {
        
        GallaryController *dashObj =[[GallaryController alloc]init];
        
        
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }

    
    
    
}




@end
