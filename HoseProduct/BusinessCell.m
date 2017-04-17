//
//  BusinessCell.m
//  HoseProduct
//
//  Created by edz on 2017/3/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "BusinessCell.h"

@interface BusinessCell()

@end

@implementation BusinessCell

+ (instancetype)businessCell:(UITableView *)tableView and:(NSIndexPath *)indexPath
{
    static NSString *ID = @"BusinessCell";
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = LoadNib(@"BusinessCell");
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"准入条件";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"业务流程";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"下户查询资料";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
