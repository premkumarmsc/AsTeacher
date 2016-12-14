//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ADPageControl.h"
#import "VRGCalendarView.h"


@interface CalendarViewController : UIViewController<ADPageControlDelegate,VRGCalendarViewDelegate>
{
    ADPageControl *pageControlObj;
}

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFav;
@property (weak, nonatomic) IBOutlet UILabel *lblClasses;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblmonth;


@property (weak, nonatomic) IBOutlet UIView *viewPageControl;

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *lblNoEvents;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end
