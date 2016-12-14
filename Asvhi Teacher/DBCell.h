//
//  MyCell.h
//  TestCollectionViewWithXIB
//
//  Created by Quy Sang Le on 2/3/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblFrom;

@property (weak, nonatomic) IBOutlet UILabel *lblTo;

@property (weak, nonatomic) IBOutlet UIView *favView;
@property (weak, nonatomic) IBOutlet UILabel *lblSubject;

@property (weak, nonatomic) IBOutlet UILabel *lblClass;

@end

