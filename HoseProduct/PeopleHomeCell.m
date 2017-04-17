//
//  PeopleHomeCell.m
//  HoseProduct
//
//  Created by edz on 2017/3/7.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "PeopleHomeCell.h"

@implementation PeopleHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)peopleHomeCell:(UITableView *)tableView{
    static NSString *ID = @"PeopleHomeCell";
    PeopleHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = LoadNib(@"PeopleHomeCell");
    }
    
    return cell;
}

@end
