//
//  InputCell.m
//  CatStreet
//
//  Created by Fluva on 2020/11/7.
//

#import "InputCell.h"

@interface InputCell ()
<UITextFieldDelegate>
@end

@implementation InputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLab = [[UILabel alloc]init];
        self.textLabel.font = PFFONT_Regular(17);
        [self.contentView addSubview:self.textLab];
        
        
        self.contentTfd = [[UITextField alloc]init];
        self.contentTfd.textAlignment = NSTextAlignmentRight;
        self.contentTfd.font = PFFONT_Regular(17);
        self.contentTfd.delegate = self;
        [self.contentView addSubview:self.contentTfd];
        
        
        [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        [self.contentTfd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    frame.origin.x += AutoW(40);

    frame.size.width -= 2 * AutoW(40);

    [super setFrame:frame];
}

@end
