//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "AddRemarksViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface AddRemarksViewController ()
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
    
    NSString *studentIds;
    
    NSString *subjectId;
    
    
    NSString *base64String;
    NSString *imageName;
}
@end

@implementation AddRemarksViewController




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
    
    
    NSString *assignId = [[NSUserDefaults standardUserDefaults]stringForKey:@"ASSIGN_REMARK_ID"];;
    
    if([assignId intValue]==0)
    {
    
        for(int i=0;i<[dataArray count];i++)
        {
        if(i==0)
        {
            [checkMarkArray addObject:@"0"];
        }
        else
        {
            [checkMarkArray addObject:@"0"];
        }
        }
        
        
        NSDictionary *dict = dataArray[0];
        
        NSArray *idVa=[dict valueForKeyPath:@"subjects"];
        
        
        
        
        if([idVa count]==0)
        {
            
            
            _subjectView.hidden = YES;
        }
        else
        {
            
            dataArraySub = [[NSMutableArray alloc]init];
            checkMarkArraySub = [[NSMutableArray alloc]init];
            
             _subjectView.hidden = NO;
           
            
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
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components= [[NSDateComponents alloc] init];
        [components setMinute:0];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *newDate=[calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
        
        

        
    }
    else
    {
        NSString *subId = @"";
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"EDIT_REMARK_DATA"];
        
        NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"FAV_DATA_ARR:%@",datadict);
        
        
        NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
        
        NSArray *favDataArr=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
        
        NSLog(@"FAV_DATA_ARR:%@",dataArray);
        
        NSString *getId = [datadict valueForKey:@"class_id"];
        
        
        /*
        
        for(int i=0;i<[dataArray count];i++)
        {
            
            NSDictionary *dictNew = dataArray[i];
            
            
            
            NSString *idVal=[datadict valueForKey:@"subject_id"];
            
            subId = idVal;
            
            
            NSArray *idVa=[dictNew valueForKeyPath:@"subjects"];
            
            if([idVa count]==0)
            {
                
                NSString *idValNew1=[dictNew valueForKeyPath:@"id"];
                
                if([idValNew1 isEqualToString:idVal])
                {
                    
                    NSLog(@"Dict Old:%@",dictNew);
                    
                    getId = [dictNew valueForKey:@"id"];
                    //cell1.lblLevel.text = [NSString stringWithFormat:@"%@ %@",[dictNew valueForKeyPath:@"class_name"],[dictNew valueForKeyPath:@"section_name"]];
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
                        
                        
                        NSLog(@"Dict:%@",dictNew);
                        
                        getId = [dictNew valueForKey:@"id"];
                        
                        
                        
                        
                        //cell1.lblLevel.text = [NSString stringWithFormat:@"%@ %@",[dictNew valueForKeyPath:@"class_name"],[dictNew valueForKeyPath:@"section_name"]];
                    }
                }
                
            }
            
            
        }
        
         */
        NSLog(@"ID:%@",getId);
        
        
        if([getId isEqualToString:@""])
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
            
            
            NSDictionary *dict = dataArray[0];
            
            NSArray *idVa=[dict valueForKeyPath:@"subjects"];
            
            
            
            
            if([idVa count]==0)
            {
                
                
                _subjectView.hidden = YES;
            }
            else
            {
                
                dataArraySub = [[NSMutableArray alloc]init];
                checkMarkArraySub = [[NSMutableArray alloc]init];
                
                _subjectView.hidden = NO;
                
              
                
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
        else
        {
            
            int indexVal =898787;
            
            for(int i=0;i<[dataArray count];i++)
            {
                
                NSDictionary *dictNew = dataArray[i];
                
                
                
                NSString *idVal=[dictNew valueForKey:@"id"];

                
                if([idVal intValue]==[getId intValue])
                {
                    [checkMarkArray addObject:@"1"];
                    
                    indexVal = i;
                }
                else
                {
                    [checkMarkArray addObject:@"0"];
                }
                
                
                
                
            }
            
            
            
            
            NSDictionary *dict = dataArray[indexVal];
            
            NSArray *idVa=[dict valueForKeyPath:@"subjects"];
            
            
            
            
            if([idVa count]==0)
            {
                
                
                _subjectView.hidden = YES;
            }
            else
            {
                
                dataArraySub = [[NSMutableArray alloc]init];
                checkMarkArraySub = [[NSMutableArray alloc]init];
                
                _subjectView.hidden = NO;
                
                
                
                [dataArraySub addObjectsFromArray:idVa];
                
                for(int i=0;i<[dataArraySub count];i++)
                {
                    
                    NSDictionary *dictNewval = dataArraySub[i];
                    
                    
                    
                    NSString *idVal1=[dictNewval valueForKey:@"id"];
                    
                    
                    if([subId isEqualToString:idVal1])
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
        
        
        _txtTitle.text = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"title"]];
        _txtDescription.text = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"description"]];
        self.txtDescription.textColor = [UIColor blackColor];
        
        studentIds = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"student_ids"]];
        
        NSArray *lines = [[NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"student_ids"]] componentsSeparatedByString: @","];
        
        
        if ([lines count]==0) {
            // No characters found
            NSLog(@"No characters found");
            
            _lblParticipants.text = @"Participants:1";
        }
        else
        {
            
            _lblParticipants.text = [NSString stringWithFormat:@"Participants:%ld",[lines count]];
        }

        
    }
    
    
    
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
             
                _subjectView.hidden = YES;
            }
            else
            {
                
                dataArraySub = [[NSMutableArray alloc]init];
                checkMarkArraySub = [[NSMutableArray alloc]init];
                
                _subjectView.hidden = NO;
                
              
                
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
                
                
                NSString *idNew=[dict valueForKeyPath:@"id"];
                
                [self getDatas:idNew];
            
            
        }
            
            _viewStudentsList.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
           
            
            _viewStudentsList.hidden = NO;
            
            [self.view addSubview:_viewStudentsList];
            
            
           
        
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
- (IBAction)clickSubmit:(id)sender {
    
    
    int countClass = 0;
    
    for(int i=0;i< [checkMarkArray count];i++)
    {
        if([checkMarkArray[i] intValue]==1)
        {
            countClass = countClass + 1;
        }
    }
    
    
    if(countClass == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please select class";
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
    
    
    if([studentIds isEqualToString:@""])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please select one student";
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
    
    if([_txtTitle.text isEqualToString:@""])
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please enter title";
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
        
        if([_txtDescription.text isEqualToString:@""] || [_txtDescription.text isEqualToString:@"Description *"] )
        {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Please enter description";
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
                    
            
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"ASSIGN_REMARK_ID"] ] forKey:@"remark_id"];
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",_txtTitle.text] forKey:@"title"];
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",_txtDescription.text] forKey:@"description"];
            
            
            
            
            
            
                    [parameters setObject:[NSString stringWithFormat:@"%@",studentIds] forKey:@"student_ids"];
            
            
                    [parameters setObject:[NSString stringWithFormat:@"%@",classId] forKey:@"class_id"];
            
            
                    
                    NSLog(@"Params:%@",parameters);
                    
                    
                    NSString *urlString=[NSString stringWithFormat:@"%@/remarks/addupdate",ApiBaseURL];
            
            
            
            
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    
                    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
                    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
                    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    manager.securityPolicy.allowInvalidCertificates = YES;
            
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forHTTPHeaderField:@"staff_id"];
            

            
                    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        
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
    }
    }
    
}

- (IBAction)clickSelectAll:(id)sender {
    
    
    if([_btnSelectAll.titleLabel.text isEqualToString:@"Select All"])
    {
        for(int i=0;i<[checkMarkArrayNew count];i++)
        {
            [checkMarkArrayNew replaceObjectAtIndex:i withObject:@"1"];
        }
        
        [_btnSelectAll setTitle:@"Deselect All" forState:UIControlStateNormal];
    }
    else
    {
        for(int i=0;i<[checkMarkArrayNew count];i++)
        {
            [checkMarkArrayNew replaceObjectAtIndex:i withObject:@"0"];
        }
        
        [_btnSelectAll setTitle:@"Select All" forState:UIControlStateNormal];

    }
    
    [_tblStudents reloadData];
    
    
}

- (IBAction)clickbackStudents:(id)sender {
    
    
   

    
    _viewStudentsList.hidden = YES;
    
   
    
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
    
    [self.tblStudents reloadData];
    
    [self displayIcons];
    
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
                
                [checkMarkArrayNew addObject:@"0"];
            }
            else
            {
                [checkMarkArrayNew addObject:@"0"];
            }
            
        }
        
        [self.tblStudents reloadData];
        
        
        
        
        totalAmount = [dataArrayNew count];
        
        [self displayIcons];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}


- (IBAction)clickSubmitNew:(id)sender {
    
    
    NSMutableString *teststring = [[NSMutableString alloc]init];
    
    for(int i=0;i<[checkMarkArrayNew count];i++)
    {
        
        if([checkMarkArrayNew[i] intValue]==1)
        {
            
            NSDictionary *dict = dataArrayNew[i];
            
            
            
            
            
            
            NSString *stuId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"student_id"]];
            
            [teststring appendString:[NSString stringWithFormat:@"%@,",stuId]];
        }
    }
    
    
    studentIds = [NSString stringWithFormat:@"%@",teststring];
    
    if ([studentIds length] > 0) {
        studentIds = [studentIds substringToIndex:[studentIds length] - 1];
        
        
        
        NSArray *lines = [studentIds componentsSeparatedByString: @","];
        
        
        if ([lines count]==0) {
            // No characters found
            NSLog(@"No characters found");
            
            _lblParticipants.text = @"Participants:1";
        }
        else
        {
            
            _lblParticipants.text = [NSString stringWithFormat:@"Participants:%ld",[lines count]];
        }
    }
    
    
    
    
    
    _viewStudentsList.hidden = YES;
    
}
@end
