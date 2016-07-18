//
//  UIView+AGAutoLayout.h
//  AGJointOperationSDK
//
//  Created by Mao on 16/3/2.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EL_INGNORE MAXFLOAT

@interface UIView (EasyLayout)

- (UIView*(^)(CGSize size))el_toSize;
- (UIView*(^)(CGFloat width))el_toWidth;
- (UIView*(^)(CGFloat height))el_toHeight;
- (UIView*(^)(CGFloat width, NSLayoutRelation relation))el_toWidthRelatedBy;
- (UIView*(^)(CGFloat height, NSLayoutRelation relation))el_toHeightRelatedBy;

- (UIView*(^)(NSLayoutAttribute attr1, NSLayoutRelation relation, UIView *toView, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant))el_constraintTo;

- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintLessThanOrEqualTo;
- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintEnqualTo;
- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintGreaterThanOrEqualTo;

- (UIView*(^)())el_centreToSuperView;

- (UIView*(^)())el_axisXToSuperView;
- (UIView*(^)())el_axisYToSuperView;

- (UIView*(^)(CGFloat offset))el_axisXToSuperViewOffset;
- (UIView*(^)(CGFloat offset))el_axisYToSuperViewOffset;

- (UIView*(^)(UIView *view))el_centreTo;

- (UIView*(^)(UIView *view))el_sameAgixXTo;
- (UIView*(^)(UIView *view))el_sameAgixYTo;

- (UIView*(^)(UIView *view))el_sameTopTo;
- (UIView*(^)(UIView *view))el_sameLeftTo;
- (UIView*(^)(UIView *view))el_sameBottomTo;
- (UIView*(^)(UIView *view))el_sameRightTo;

- (UIView*(^)())el_edgesStickToSuperView;
- (UIView*(^)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right))el_edgesToSuperView;

- (UIView*(^)(CGFloat constant))el_topToSuperView;
- (UIView*(^)(CGFloat constant))el_leftToSuperView;
- (UIView*(^)(CGFloat constant))el_bottomToSuperView;
- (UIView*(^)(CGFloat constant))el_rightToSuperView;

- (UIView*(^)())el_widthEqualToHeight;


- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_topToSuperViewRelatedBy;
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_leftToSuperViewRelatedBy;
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_bottomToSuperViewRelatedBy;
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_rightToSuperViewRelatedBy;

- (UIView*(^)(UIView *toView,CGFloat constant))el_topToView;
- (UIView*(^)(UIView *toView,CGFloat constant))el_leftToView;
- (UIView*(^)(UIView *toView,CGFloat constant))el_bottomToView;
- (UIView*(^)(UIView *toView,CGFloat constant))el_rightToView;

- (UIView*(^)(UIView *toView,CGFloat constant))el_leftToRight;
- (UIView*(^)(UIView *toView,CGFloat constant))el_rightToLeft;
- (UIView*(^)(UIView *toView,CGFloat constant))el_topToBottom;
- (UIView*(^)(UIView *toView,CGFloat constant))el_bottomToTop;



- (UIView*(^)(UIViewController * viewController))el_stickToTopLayoutGuide;
- (UIView*(^)(UIViewController * viewController))el_stickToBottomLayoutGuide;

- (UIView*(^)(UIViewController * viewController, CGFloat inset))el_closeToTopLayoutGuide;
- (UIView*(^)(UIViewController * viewController, CGFloat inset))el_closeToBottomLayoutGuide;

- (UIView*(^)(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation))el_toTopLayoutGuide;
- (UIView*(^)(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation))el_toBottomLayoutGuide;


@end

@interface UIView (EasyLayout_Helper)
- (NSLayoutConstraint*)el_constraintTopToSuperView;
- (NSLayoutConstraint*)el_constraintLeftToSuperView;
- (NSLayoutConstraint*)el_constraintBottomToSuperView;
- (NSLayoutConstraint*)el_constraintRightToSuperView;
- (NSLayoutConstraint*)el_constraintWidth;
- (NSLayoutConstraint*)el_constraintHeight;
- (NSLayoutConstraint*)el_currentConstraint;

- (NSLayoutConstraint*)el_constraintTopToBottomView:(UIView*)view;
- (NSLayoutConstraint*)el_constraintLeftToRightView:(UIView*)view;
- (NSLayoutConstraint*)el_constraintBottomToTopView:(UIView*)view;
- (NSLayoutConstraint*)el_constraintRightToLeftView:(UIView*)view;


@end

@interface NSArray (EasyLayout_Helper)
- (NSArray<NSLayoutConstraint *>*)el_distributeViewsAlongAxisXWithSize:(CGSize)size
                                                                margin:(CGFloat)margin;
- (NSArray<NSLayoutConstraint *>*)el_distributeViewsAlongAxisYWithSize:(CGSize)size
                                                                margin:(CGFloat)margin;
- (NSArray<NSLayoutConstraint *>*)autoSetViewsWidth:(CGFloat)width;
- (NSArray<NSLayoutConstraint *>*)autoSetViewsheight:(CGFloat)height;
@end

