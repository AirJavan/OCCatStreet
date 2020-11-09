//
//  BaseTableViewCell.m
//  CatStreet
//
//  Created by Fluva on 2020/11/3.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
}

@end
