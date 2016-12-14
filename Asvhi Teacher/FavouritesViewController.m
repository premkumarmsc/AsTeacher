//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "FavouritesViewController.h"
#import "FavCell.h"
#import "AFNetworking.h"
#import "DashboardViewController.h"


@interface FavouritesViewController ()
{
    FavCell *cell;
    
    NSMutableArray *dataArray;

}
@end

@implementation FavouritesViewController


NSMutableArray *checkMarkArray;



int totalAmount;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [self.collectionViewFav registerNib:[UINib nibWithNibName:@"FavCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    totalAmount=0;
    
    dataArray = [[NSMutableArray alloc]init];
     checkMarkArray = [[NSMutableArray alloc]init];
    
    [ProgressHUD show:nil];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"STAFF_ID"] forKey:@"staff_id"];
    
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/favclasses/classes_subjects",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
            
            [dataArray addObjectsFromArray:[JSON valueForKeyPath:@"data"]];
            
            [ProgressHUD dismiss];
          
            
        }
        
        
       
        
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"FAV_COME"] isEqualToString:@"IN"])
        {
            
            NSArray *tempArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"FAV_ARR"];
            
            for(int i=0;i<[dataArray count];i++)
            {
                
                NSDictionary *dict = dataArray[i];
                
                NSString *tempId = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
                
                if ([tempArr containsObject:tempId]) {
                    // do something
                    
                     [checkMarkArray addObject:@"1"];
                    
                   
                        
                        totalAmount = totalAmount + 1;
                    
                }
                else
                {
                     [checkMarkArray addObject:@"0"];
                }
                
                
               
            }
        }
        else
        {
        for(int i=0;i<[dataArray count];i++)
        {
            [checkMarkArray addObject:@"0"];
        }
        }
        
        [_collectionViewFav reloadData];
        
        
        
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

- (FavCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.favView.layer.cornerRadius = 5;
    cell.favView.layer.masksToBounds = YES;
    
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKeyPath:@"class_name"],[dict valueForKeyPath:@"section_name"]];
    
    if([checkMarkArray[indexPath.item] intValue]==0)
    {
        cell.iconFav.image = [UIImage imageNamed:@"ic_favourite_default"];
    }
    else
    {
        cell.iconFav.image = [UIImage imageNamed:@"ic_favourite_select"];

    }
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([checkMarkArray[indexPath.row]intValue]==0)
    {
        [checkMarkArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        
        totalAmount = totalAmount + 1;
    }
    else
    {
        [checkMarkArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        
        totalAmount = totalAmount - 1;
    }
    
    [self.collectionViewFav reloadData];
    
    
    
    
    NSLog(@"Total:%d",totalAmount);

   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 70);
}



- (IBAction)backBtn:(id)sender
{
    if(totalAmount==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"Please choose atleast one class";
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
        
        NSMutableArray *newArr=[[NSMutableArray alloc]init];
        
        for(int i=0;i<[checkMarkArray count];i++)
        {
            if([checkMarkArray[i]intValue]==1)
            {
                
                NSDictionary *dict = dataArray[i];
                
                [newArr addObject:[dict valueForKey:@"id"]];
            }
        }
        
        
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"FAV_DATA_ARR"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        
        [[NSUserDefaults standardUserDefaults]setObject:newArr forKey:@"FAV_ARR"];
        
        if([[[NSUserDefaults standardUserDefaults]stringForKey:@"FAV_COME"] isEqualToString:@"IN"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
        DashboardViewController *dashObj =[[DashboardViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        }
    }
}
@end
