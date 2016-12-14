//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "AddViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface AddViewController ()
{
    FavCellSmall *cell;
    
    NSMutableArray *dataArray;
    NSMutableArray *checkMarkArray;
    
    NSMutableArray *dataArraySub;
    NSMutableArray *checkMarkArraySub;
    
    
    
    
    int totalAmount;
    
    
    NSString *classId;
    NSString *subjectId;
    
    
    NSString *base64String;
    NSString *imageName;
}
@end

@implementation AddViewController

int tag = 1;


long long duedateTime;

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

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
    
    tag = 1;
 
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
    
    
    if(tag == 1)
    {
    
        
        
        
        tag = 1;
        
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
    
    
    NSString *assignId = [[NSUserDefaults standardUserDefaults]stringForKey:@"ASSIGN_ID"];;
    
    if([assignId intValue]==0)
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
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components= [[NSDateComponents alloc] init];
        [components setMinute:0];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *newDate=[calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
        
        
        duedateTime = (long long)([newDate timeIntervalSince1970]);
        
        
        _lblDueDate.text = [NSString stringWithFormat:@"%@",dayName];


        
    }
    else
    {
        NSString *subId = @"";
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"EDIT_HOME_DATA"];
        
        NSDictionary *datadict=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"FAV_DATA_ARR:%@",datadict);
        
        
        NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"FAV_DATA_ARR"];
        
        NSArray *favDataArr=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
        
        NSLog(@"FAV_DATA_ARR:%@",dataArray);
        
        NSString *getId = @"";
        
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
        
        NSString *end= [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"due_date"]];
        
       NSString *fileURL = [NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"file_url"]];
        
        if(![fileURL isEqualToString:@""])
        {
            [_imgViewLicence sd_setImageWithURL:[NSURL URLWithString:fileURL]
                        placeholderImage:nil];
            

        }
        NSDate * myDateend = [NSDate dateWithTimeIntervalSince1970:[end longLongValue]];;
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dayName = [dateFormatter stringFromDate:myDateend];
        

        duedateTime = [end longLongValue];

        
        
        _lblDueDate.text = [NSString stringWithFormat:@"%@",dayName];
        
        
        if([[NSString stringWithFormat:@"%@",[datadict valueForKeyPath:@"homework_type"]] intValue] ==2 )
        {
            
            _segmentControl.selectedSegmentIndex = 1;
        }
        else
        {
            _segmentControl.selectedSegmentIndex = 0;
        }
        
        
    }
    
    
    
    [_collectionViewFav reloadData];
    [_collectionViewSub reloadData];
    }
    

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
        
        
                tag = 1;
                
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
    }
    }
    else
    {
        for(int j=0;j<[dataArraySub count];j++)
        {
            
            
            if(j == indexPath.item)
            {
                [checkMarkArraySub replaceObjectAtIndex:j withObject:@"1"];
            }
            else
            {
                [checkMarkArraySub replaceObjectAtIndex:j withObject:@"0"];
            }
        }
        
        [_collectionViewSub reloadData];
        

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
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] ] forKey:@"staff_id"];
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"ASSIGN_ID"] ] forKey:@"homework_id"];
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",_txtTitle.text] forKey:@"title"];
                    
                    [parameters setObject:[NSString stringWithFormat:@"%@",_txtDescription.text] forKey:@"description"];
            
            
            
                    if(_segmentControl.selectedSegmentIndex == 0)
                    {
                     [parameters setObject:[NSString stringWithFormat:@"1"] forKey:@"homework_type"];
                    }
                    else
                    {
                       
                            [parameters setObject:[NSString stringWithFormat:@"2"] forKey:@"homework_type"];
                        
                    }
            
            
           
            
            
            
            
                    [parameters setObject:[NSString stringWithFormat:@"%@",subjectId] forKey:@"subject_id"];
                    [parameters setObject:[NSString stringWithFormat:@"%@",classId] forKey:@"classes"];
            
            
                     [parameters setObject:[NSString stringWithFormat:@"%lld",duedateTime] forKey:@"due_date"];
            
            
            
                base64String =  [self base64String:[self imageWithImageSimple:_imgViewLicence.image scaledToSize:CGSizeMake(300, 300)]];
            
                //NSLog(@"Base 64 Str:%@",base64String);
            
            
            
            
                    if(![base64String isEqualToString:@""])
                    {
                     [parameters setObject:[NSString stringWithFormat:@"%@.png",[self randomStringWithLength:5]] forKey:@"new_file_name"];
                    }
                     [parameters setObject:[NSString stringWithFormat:@"%@",base64String] forKey:@"image_base64"];
            
                    
                    NSLog(@"Params:%@",parameters);
                    
                    
                    NSString *urlString=[NSString stringWithFormat:@"%@/homework/addupdate",ApiBaseURL];
            
            
            
            
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    
                    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
                    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
                    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    manager.securityPolicy.allowInvalidCertificates = YES;
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
- (IBAction)clickPhoto:(id)sender {
    
    NSString *actionSheetTitle = @"Where do you want to take the image from?"; //Action Sheet Title
    // NSString *destructiveTitle = @"Destructive Button"; //Action Sheet Button Titles
    NSString *other1 = @"Camera";
    NSString *other2 = @"Album";
    
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2,  nil];
    [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    tag = 0;
    
    if (buttonIndex==0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            
            
            
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setShowsCameraControls:YES];
            [picker setAllowsEditing:NO];
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert-360" message:@"The device does not have camera" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            // [alert release];
        }
        
    }
    else  if (buttonIndex==1)
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
    
}

/*
1.Splash
2. Login
3. Forgot
4. Register
5. OTP
6. Home page Map
7. Drawer
 */




-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image;
    
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        ////(@"CAMERA");
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
    }
    else
    {
        ////(@"ALBUM");
        
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
        
        
        
        
        
    }
    
    
    
    
    
    _imgViewLicence.image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    
    //_newImage.image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    
    //[_btnImage setImage:image forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    
    
}


-(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //[viewSlide shouldAutoShow:YES];
    [picker dismissModalViewControllerAnimated:YES];
}


- (NSString *)base64String : (UIImage *)img
{
    return [UIImagePNGRepresentation(img) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


- (IBAction)clickDate:(id)sender {
    
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select Due Date" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = 5;
    [datePicker showActionSheetPicker];

    
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dayName = [dateFormatter stringFromDate:selectedTime];
    
    
    
    long long milliseconds = (long long)([selectedTime timeIntervalSince1970]);
    
    
    duedateTime = milliseconds;
    
    
    
    _lblDueDate.text = [NSString stringWithFormat:@"%@",dayName];
    

    
}

- (IBAction)changeSegment:(id)sender {
}
@end
