//
//  AGPageCircleViewCell.m
//  AGPageCircleView
//
//  Created by Huiming on 16/7/18.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import "AGPageCircleViewCell.h"
#import "UIImageView+WebCache.h"

@interface AGPageCircleViewCell()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation AGPageCircleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView = imageView;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    if ([imageName isKindOfClass:[NSString class]]) {
        if ([imageName hasPrefix:@"http"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
        } else {
            UIImage *image = [UIImage imageNamed:imageName];
            if (!image) {
                
            }
            self.imageView.image = image;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
