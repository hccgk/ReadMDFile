//
//  MDFileTableViewCell.m
//  ReadMD
//
//  Created by 何川 on 2019/2/12.
//  Copyright © 2019 何川. All rights reserved.
//

#import "MDFileTableViewCell.h"

@implementation MDFileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    self.textLabel.textColor = [UIColor blackColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
