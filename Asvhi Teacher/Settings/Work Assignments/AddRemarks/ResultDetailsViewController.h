//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface ResultDetailsViewController : UIViewController

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *classView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFav;
@property (weak, nonatomic) IBOutlet UIView *viewTemp;
@property (weak, nonatomic) IBOutlet UIView *subjectView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewSub;
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UIView *subInner;
@property (weak, nonatomic) IBOutlet UIView *submitView;

@property (weak, nonatomic) IBOutlet UIView *submitViewNew;

- (IBAction)clickSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
- (IBAction)clickPhoto:(id)sender;
- (IBAction)clickDate:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
- (IBAction)changeSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *lblDueDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewLicence;
@property (weak, nonatomic) IBOutlet UILabel *lblParticipants;


@property (strong, nonatomic) IBOutlet UIView *viewStudentsList;
@property (weak, nonatomic) IBOutlet UITableView *tblStudents;
- (IBAction)clickSelectAll:(id)sender;
- (IBAction)clickbackStudents:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAll;
@property (weak, nonatomic) IBOutlet UIView *btnSubmitNew;
- (IBAction)clickSubmitNew:(id)sender;

@end
