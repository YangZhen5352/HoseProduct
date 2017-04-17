//
//  BusinessCell.h
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)businessCell:(UITableView *)tableView and:(NSIndexPath *)indexPath;

@end
