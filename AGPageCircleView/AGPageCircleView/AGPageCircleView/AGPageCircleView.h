//
//  AGPageCircleView.h
//  AGPageCircleView
//
//  Created by Huiming on 16/7/18.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGPageCircleView;

typedef void(^ClickBlock)(NSInteger index);

@protocol AGPageCircleViewDelegate <NSObject>

@optional
/** 返回索引 */
- (void)pageCircleView:(AGPageCircleView *)pageCircleView didClickIndex:(NSInteger)index;

@end

@interface AGPageCircleView : UIView

/** 轮播图片组 UrlString或imageName */
@property (nonatomic, strong) NSArray *imageNameArray;
/** 每页时间 */
@property (nonatomic, assign) NSTimeInterval pageTime;
/** 点击回调 */
@property (nonatomic, copy) void(^clickOperationBlock)(NSUInteger index);
@property (nonatomic, weak) id<AGPageCircleViewDelegate> delegate;

@end
