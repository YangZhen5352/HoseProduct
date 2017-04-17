//
//  MessageCell01.m
//  HoseProduct
//
//  Created by edz on 2017/3/10.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MessageCell01.h"

@interface MessageCell01()

@property (weak, nonatomic) IBOutlet UIView *msgBackView;

@end

@implementation MessageCell01

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.msgBackView.layer.masksToBounds = YES;
    self.msgBackView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)messageCell01:(UITableView *)tableView
{
    static NSString *ID = @"messageCell01";
    MessageCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = LoadNib(@"MessageCell01");
    }
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

@end
