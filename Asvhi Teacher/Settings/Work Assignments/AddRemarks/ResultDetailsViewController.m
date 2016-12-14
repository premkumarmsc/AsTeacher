//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ResultDetailsViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface ResultDetailsViewController ()
{
    FavCellSmall *cell;
    
    NSMutableArray *dataArray;
    NSMutableArray *checkMarkArray;
    
    NSMutableArray *dataArraySub;
    NSMutableArray *checkMarkArraySub;
    
    
    
    NSMutableArray *dataArrayNew;
    NSMutableArray *checkMarkArrayNew;
    

    
    int totalAmount;
    
    
    NSString *classId;
    
     NSString *examId;
    
    NSString *studentIds;
    
    NSString *subjectId;
    
    
    NSString *base64String;
    NSString *imageName;
}
@end

@implementation ResultDetailsViewController




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
    
    _submitViewNew.layer.cornerRadius = 3;
    _submitViewNew.layer.masksToBounds = YES;

    self.txtDescription.textColor = [UIColor lightGrayColor];
    self.txtDescription.text = @"Description *";

    
    classId = @"";
    subjectId = @"";
    
    base64String = @"";
    imageName = @"";
    
   
 
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.txtDescription.text = @"";
    self.txtDescription.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.txtDescription.text.length == 0)
    {
        self.txtDescription.textColor = [UIColor lightGrayColor];
        self.txtDescription.text = @"Description *";
        [self.txtDescription resignFirstResponder];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
   studentIds = @"";
        
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
    
    
  
        NSString *subId = @"";
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"RESULT_DATA"];
        
        NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"FAV_DATA_ARR:%@",datadict);
        
        
        NSData *data3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
        
        NSArray *favDataArrNew=[NSKeyedUnarchiver unarchiveObjectWithData:data3];
        
        NSLog(@"FAV_DATA_ARR:%@",dataArray);
        
        NSString *getId = [datadict valueForKey:@"class_id"];
    
    _lblParticipants.text = [datadict valueForKey:@"exam_type"];
        
    classId = getId;
    
        NSLog(@"ID:%@",getId);
    
            for(int i=0;i<[dataArray count];i++)
            {
                
                
                NSDictionary *dictNew = dataArray[i];
                
                
                
                NSString *idVal=[dictNew valueForKey:@"id"];
                
                
                if([idVal intValue]==[getId intValue])
                {
                    [checkMarkArray addObject:@"1"];
                    
                    
                }
                else
                {
                    [checkMarkArray addObject:@"0"];
                }

               
            }
            
            
    
    

        
   // NSDictionary *dict = dataArray[0];
    
  
    
    
    NSString *idNew=[datadict valueForKeyPath:@"exam_id"];
    
    examId = [datadict valueForKeyPath:@"exam_id"];
    
    [self getDatas:idNew];
    
    
    
    [_collectionViewFav reloadData];
    [_collectionViewSub reloadData];
    
    

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
    
    
            NSDictionary *dict = dataArray[indexPath.row];
          
         
                classId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
            
           
        
            [self getDatas:examId];
            
            
           
        
        [_collectionViewFav reloadData];
        [_collectionViewSub reloadData];
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

- (IBAction)clickbackStudents:(id)sender {
    
    
   

    
    _viewStudentsList.hidden = YES;
    
   
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   return [dataArrayNew count];
    
    
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
    
    
    
    ResultsDataCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ResultsDataCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (ResultsDataCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
   
    if(indexPath.row == 0)
    {
        cell1.lblTitle.textColor = [UIColor whiteColor];
        cell1.lblSubtitle.textColor = [UIColor whiteColor];
        cell1.lblLevel.textColor = [UIColor whiteColor];
        
        
        cell1.lblTitle.text = @"S.No";
        cell1.lblSubtitle.text = @"Name";

        cell1.lblLevel.text = @"Total";


        
        
        
        
        cell1.viewInner.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(133/255.0) blue:(165/255.0) alpha:1];
    }
    else
    {
    
    
        
        NSDictionary *dict = dataArrayNew[indexPath.row];
        
        
        cell1.lblTitle.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"student_name"]];
        
        cell1.lblLevel.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"Total"]];
        
        
        cell1.selectionStyle = UITableViewCellAccessoryNone;
        
        cell1.lblTitle.textColor = [UIColor lightGrayColor];
        cell1.lblSubtitle.textColor = [UIColor lightGrayColor];
        cell1.lblLevel.textColor = [UIColor lightGrayColor];
        
        cell1.viewInner.backgroundColor = [UIColor whiteColor];
    
   
    }
    
    
    return cell1;
    
    
}
-(void)LevelClicked:(UIButton*)button
{
    NSDictionary *dict = dataArrayNew[(long int)[button tag]];
    
    NSString *number = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"mobile_number"]];
    
    if([number isEqualToString:@""]||number.length==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"Invalid Phone Number";
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
    }
    else
    {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel://%@",number]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
        {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"Invalid Phone Number";
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
        }
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row != 0)
    {
    
    ResultMarkViewController *dashObj =[[ResultMarkViewController alloc]init];
    NSDictionary *dict = dataArrayNew[indexPath.row];
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"MARK_DATA"];
        
     [[NSUserDefaults standardUserDefaults] setObject:examId forKey:@"EXAM_ID"];
         [[NSUserDefaults standardUserDefaults] setObject:classId forKey:@"CLASS_ID"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"STU_ID"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Test Student" forKey:@"STU_NAME"];
        
        
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:dashObj animated:YES];
        
    }
}

-(void)displayIcons
{
    
    int totalCount = 0;
    
    for(int i=0;i<[checkMarkArrayNew count];i++)
    {
        
        if([checkMarkArrayNew[i] intValue]==1)
        {
            totalCount = totalCount + 1;
        }
    }
    
    
    if(totalCount==[checkMarkArrayNew count])
    {
        
        
        
            
            [_btnSelectAll setTitle:@"Deselect All" forState:UIControlStateNormal];
       
    }
    else
    {
          [_btnSelectAll setTitle:@"Select All" forState:UIControlStateNormal];
    }
    
    
}




-(void)getDatas:(NSString *)idVa
{
    //NSLog(@"ID Va:%@",idVa);
    
    
    [ProgressHUD show:nil];
    
    //[MBProgressHUD show];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    
    //[parameters setObject:@"1466533800" forKey:@"timestamp"];
    
    // [parameters setObject:[NSString stringWithFormat:@"%@",idVa] forKey:@"exam_id"];
    
    
    // [parameters setObject:[NSString stringWithFormat:@"2",idVa] forKey:@"class_id[1]"];
    // [parameters setObject:[NSString stringWithFormat:@"3",idVa] forKey:@"class_id[2]"];
    
    
    
    
    
    dataArrayNew = [[NSMutableArray alloc]init];
    checkMarkArrayNew = [[NSMutableArray alloc]init];
    
    
    
    
    
    //NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"exam_id":examId,@"class_id":classId};
    
    
    NSLog(@"Params:%@",dict);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/exams/classresult",ApiBaseURL];
    
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
        
        
        
        
        
        if ([[JSON valueForKey:@"status"] intValue] == 200)
        {
            
            
            
            @try {
                
                
                [dataArrayNew addObject:@"Title"];
                
                [dataArrayNew addObjectsFromArray:[JSON valueForKeyPath:@"data"]];
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            
            [ProgressHUD dismiss];
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = [JSON valueForKeyPath:@"message"];
            hud.label.numberOfLines =2;
            
            hud.label.adjustsFontSizeToFitWidth=YES;
            hud.label.minimumScaleFactor=0.5;
            
            hud.margin = 10.f;
            hud.yOffset = 250.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:2];
            
            [ProgressHUD dismiss];
            
            
            
            
        }
        
        [self.tblStudents reloadData];
        
        
        
        
        //  [self displayIcons];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}

@end
