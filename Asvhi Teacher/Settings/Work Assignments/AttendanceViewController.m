//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "AttendanceViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface AttendanceViewController ()
{
    FavCellSmall *cell;
    
    NSMutableArray *dataArray;
    NSMutableArray *checkMarkArray;
    
    NSMutableArray *dataArraySub;
    NSMutableArray *checkMarkArraySub;
    
    
    NSMutableArray *dataArrayNew;
    NSMutableArray *checkMarkArrayNew;
    
    
    
    
    long long totalAmount;
    
    
    NSString *classId;
    NSString *subjectId;
    
    
    NSString *base64String;
    NSString *imageName;
}
@end

@implementation AttendanceViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [self.collectionViewFav registerNib:[UINib nibWithNibName:@"FavCellSmall" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    [self.collectionViewSub registerNib:[UINib nibWithNibName:@"FavCellSmall" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    
    _classView.layer.cornerRadius = 3;
    _classView.layer.masksToBounds = YES;
    
    _subInner.layer.cornerRadius = 3;
    _subInner.layer.masksToBounds = YES;
    
    _view1.layer.cornerRadius = 3;
    _view1.layer.masksToBounds = YES;

    _view2.layer.cornerRadius = 3;
    _view2.layer.masksToBounds = YES;

    _view3.layer.cornerRadius = 3;
    _view3.layer.masksToBounds = YES;

    _view4.layer.cornerRadius = 3;
    _view4.layer.masksToBounds = YES;

    _submitView.layer.cornerRadius = 3;
    _submitView.layer.masksToBounds = YES;

    self.txtDescription.textColor = [UIColor lightGrayColor];
    self.txtDescription.text = @"Description *";

    
    classId = @"";
    subjectId = @"";
    
    base64String = @"";
    imageName = @"";
    
   
 
}




-(void)viewWillAppear:(BOOL)animated
{
    
   
        
    totalAmount=0;
    
    dataArray = [[NSMutableArray alloc]init];
    checkMarkArray = [[NSMutableArray alloc]init];
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
    
    NSArray *favDataArr=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    NSArray *tempArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARR"];
    
    for(int i=0;i<[favDataArr count];i++)
    {
        
        NSDictionary *dict = favDataArr[i];
        
        NSString *tempId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
        
        if ([tempArr containsObject:tempId]) {
            
            
            [dataArray addObject:dict];
            
            
            
        }
        
        
        
    }
    
    
    
    
        for(int i=0;i<[dataArray count];i++)
        {
        if(i==0)
        {
            [checkMarkArray addObject:@"1"];
        }
        else
        {
            [checkMarkArray addObject:@"0"];
        }
        }
        
        
        NSDictionary *dict = dataArray[0];
        
        NSString *idVa=[dict valueForKeyPath:@"id"];
        
    
    [self getDatas:idVa];
    
    
    [_collectionViewFav reloadData];
    [_collectionViewSub reloadData];
    
    

}


-(void)getDatas:(NSString *)idVa
{
    NSLog(@"ID Va:%@",idVa);
    
    
    [ProgressHUD show:nil];
    
    //[MBProgressHUD show];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    
    //[parameters setObject:@"1466533800" forKey:@"timestamp"];
    
    [parameters setObject:[NSString stringWithFormat:@"%@",idVa] forKey:@"classes[]"];
    
    
   // [parameters setObject:[NSString stringWithFormat:@"2",idVa] forKey:@"class_id[1]"];
   // [parameters setObject:[NSString stringWithFormat:@"3",idVa] forKey:@"class_id[2]"];
    
    
    
    NSLog(@"Params:%@",parameters);
    
    
    dataArrayNew = [[NSMutableArray alloc]init];
    checkMarkArrayNew = [[NSMutableArray alloc]init];
    
    
    
    
    //NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"classes[]":idVa};
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/students/listall",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
   // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forHTTPHeaderField:@"staff_id"];
    
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
       // NSLog(@"Success: %@", string);

        
        
        
        
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
            @try {
                
                [dataArrayNew addObjectsFromArray:[JSON valueForKeyPath:@"data"][0]];
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            
            [ProgressHUD dismiss];
            
            
        }
        
        for(int i=0;i<[dataArrayNew count];i++)
        {
           
            NSDictionary *dict = dataArrayNew[i];
            
            
            
            if([[dict valueForKeyPath:@"status"] intValue] == 1)
            {
            
                [checkMarkArrayNew addObject:@"1"];
            }
            else
            {
                 [checkMarkArrayNew addObject:@"0"];
            }
            
        }
        
        [self.tblAttendance reloadData];
        
        
        
        
        totalAmount = [dataArrayNew count];
        
        [self displayIcons];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];

    
}

-(void)displayIcons
{
    _lblTotal.text = [NSString stringWithFormat:@"%lu",(unsigned long)[dataArrayNew count]];
    
    
    _lblAbsent.text = [NSString stringWithFormat:@"%llu",[dataArrayNew count] - totalAmount];
    
    _lblPresent.text = [NSString stringWithFormat:@"%llu",totalAmount];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    
    if(view == _collectionViewFav)
    {
        
    return [dataArray count]+1;
    }
    else
    {
        return [dataArraySub count];
    }
    
}

- (FavCellSmall *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.favView.layer.cornerRadius = 3;
    cell.favView.layer.masksToBounds = YES;
    
    
    if(collectionView == _collectionViewFav)
    {
    
    if(indexPath.item == [dataArray count])
    {
       cell.lblTitle.text = @"+ Add";
        cell.lblTitle.textColor = [UIColor whiteColor];
    }
    else
    {
    NSDictionary *dict = dataArray[indexPath.row];
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKeyPath:@"class_name"],[dict valueForKeyPath:@"section_name"]];
    
    if([checkMarkArray[indexPath.item] intValue]==0)
    {
        cell.lblTitle.textColor = [UIColor whiteColor];
    }
    else
    {
        cell.lblTitle.textColor = [UIColor greenColor];
        
        classId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];

    }
    }
    }
    else
    {
       
        NSDictionary *dict = dataArraySub[indexPath.row];
        
        cell.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subject_name"]];
        
        if([checkMarkArraySub[indexPath.item] intValue]==0)
        {
            cell.lblTitle.textColor = [UIColor whiteColor];
        }
        else
        {
            cell.lblTitle.textColor = [UIColor orangeColor];
            
            subjectId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
            
        }
        
        
    }
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(collectionView == _collectionViewFav)
    {
    
    
        if(indexPath.row == [dataArray count])
            {
        
        
                               
        FavouritesViewController *dashObj =[[FavouritesViewController alloc]init];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"IN" forKey:@"FAV_COME"];
        
        [self.navigationController pushViewController:dashObj animated:YES];
    }
        else
        {
            for(int i=0;i<[dataArray count];i++)
            {
        
        
        if(i == indexPath.row)
        {
            [checkMarkArray replaceObjectAtIndex:i withObject:@"1"];
        }
        else
        {
            [checkMarkArray replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    
    
        
        {
            
            for(int i=0;i<[dataArray count];i++)
            {
                if(i==0)
                {
                    [checkMarkArray addObject:@"1"];
                }
                else
                {
                    [checkMarkArray addObject:@"0"];
                }
            }
            
            
            NSDictionary *dict = dataArray[indexPath.item];
            
            NSArray *idVa=[dict valueForKeyPath:@"subjects"];
            
            
            
            
            if([idVa count]==0)
            {
                _contentsView.frame = CGRectMake( _subjectView.frame.origin.x, _subjectView.frame.origin.y, _contentsView.frame.size.width, _contentsView.frame.size.height ); // set new position exactly
                

                _subjectView.hidden = YES;
            }
            else
            {
                
                dataArraySub = [[NSMutableArray alloc]init];
                checkMarkArraySub = [[NSMutableArray alloc]init];
                
                _subjectView.hidden = NO;
                
                _contentsView.frame = CGRectMake( _subjectView.frame.origin.x, _subjectView.frame.origin.y+ _subjectView.frame.size.height+10, _contentsView.frame.size.width, _contentsView.frame.size.height ); // set new position exactly
                
                [dataArraySub addObjectsFromArray:idVa];
                
                for(int i=0;i<[dataArraySub count];i++)
                {
                    if(i==0)
                    {
                        [checkMarkArraySub addObject:@"1"];
                    }
                    else
                    {
                        [checkMarkArraySub addObject:@"0"];
                    }
                }
            }
            
            
        }
        
        [_collectionViewFav reloadData];
        [_collectionViewSub reloadData];
            
            NSDictionary *dict = dataArray[indexPath.item];
            
            NSString *idVa=[dict valueForKeyPath:@"id"];
            
            
            [self getDatas:idVa];
    }
    }
   

   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 35);
}



- (IBAction)backBtn:(id)sender
{
   
            [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)clickSubmit:(id)sender {
    
        {
                    
                    [ProgressHUD show:nil];
                    
                    //[MBProgressHUD show];
                    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                    
                 //   [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] ] forKey:@"staff_id"];
            
           
            
            
            NSDateComponents *components= [[NSDateComponents alloc] init];
            [components setMinute:0];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *newDate=[calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
            
           
            
            
                     long long milliseconds = (long long)([newDate timeIntervalSince1970]);
            
            
            
                    [parameters setObject:[NSString stringWithFormat:@"%lld",milliseconds] forKey:@"date"];
            
            
                    [parameters setObject:[NSString stringWithFormat:@"%@",classId] forKey:@"classes"];
            
            
            
            
            
            NSMutableArray *tempApp=[[NSMutableArray alloc]init];
            
            for(int i=0;i< [dataArrayNew count];i++)
            {
                
                NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];

                
                if([checkMarkArrayNew[i] intValue]==0)
                {
                    [myDictionary setObject:@"0"  forKey:@"status"];
                }
                else
                {
                    [myDictionary setObject:@"1"  forKey:@"status"];
                }
                
                
                NSDictionary *dict = dataArrayNew[i];
                
              
                
                [myDictionary setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"student_id"]]  forKey:@"student_id"];
                
                [myDictionary setObject:@"absent"  forKey:@"remarks"];
                
                
                [tempApp addObject:myDictionary];

            }
            
            
            
            [parameters setObject:tempApp forKey:@"attendances"];
            
            
           
            
            NSString *milli = [NSString stringWithFormat:@"%lld",milliseconds];
            
            
            NSDictionary *dict = @{@"attendances":tempApp,@"class_id":classId,@"date":milli};
                    
                    NSLog(@"Params:%@",dict);
                    
                    
                    NSString *urlString=[NSString stringWithFormat:@"%@/attendence/create_class",ApiBaseURL];
            
            
            
            
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    
                    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
                    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
                   [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forHTTPHeaderField:@"staff_id"];
            

                    manager.securityPolicy.allowInvalidCertificates = YES;
            
            
            NSLog(@"Manager:%@",manager);
            
            
            
            
                    [manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        
                        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"Success: %@", string);


                        
                        NSError *error = nil;
                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                        
                        NSLog(@"JSON:%@",JSON);
                        
                        if ([[JSON valueForKey:@"status"] intValue]==201)
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
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }
                        
                        
                        
                        
                        
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"Error: %@", error);
                        
                        
                        [ProgressHUD showError:error.localizedDescription];
                        
                        
                    }];
                    
                }
            
        
        
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [dataArrayNew count];
    
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
    
    
    
    AttendanceCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"AttendanceCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (AttendanceCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    cell1.viewBack.layer.cornerRadius = 5;
    cell1.viewBack.layer.masksToBounds = YES;
    
    cell1.viewInner.layer.cornerRadius = 5;
    cell1.viewInner.layer.masksToBounds = YES;
    
    
    
    
    NSDictionary *dict = dataArrayNew[indexPath.section];
    
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"student_name"]];
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"registration_number"]];
    
    if([checkMarkArrayNew[indexPath.section]intValue]==0)
    {
        
        cell1.imgAttach.image = [UIImage imageNamed:@"ic_absent"];
    }
    else
    {
        cell1.imgAttach.image = [UIImage imageNamed:@"ic_present"];
    }
    
    
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   // NSDictionary *dict = dataArray[indexPath.section];
    
    
    if([checkMarkArrayNew[indexPath.section]intValue]==0)
    {
        [checkMarkArrayNew replaceObjectAtIndex:indexPath.section withObject:@"1"];
        
        totalAmount = totalAmount + 1;
    }
    else
    {
        [checkMarkArrayNew replaceObjectAtIndex:indexPath.section withObject:@"0"];
        
        totalAmount = totalAmount - 1;
    }
    
    [self.tblAttendance reloadData];
    
    [self displayIcons];
    
}




@end
