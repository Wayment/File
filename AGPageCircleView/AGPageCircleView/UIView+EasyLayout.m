//
//  UIView+AGAutoLayout.m
//  AGJointOperationSDK
//
//  Created by Mao on 16/3/2.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import "UIView+EasyLayout.h"
#import <objc/runtime.h>

static char CurrentConstraintKey;

static BOOL ELFloatNotEqual(CGFloat a, CGFloat b){
    if (fabs(a - b) > FLT_EPSILON) {
        return YES;
    }
    return NO;
}

@implementation UIView (EasyLayout)

- (void)el_setCurrentConstraint:(NSLayoutConstraint*)constraint{
    return objc_setAssociatedObject(self, &CurrentConstraintKey, constraint, OBJC_ASSOCIATION_RETAIN);
}

- (UIView*(^)(CGSize size))el_toSize;{
    return ^UIView*(CGSize size){
        return self.el_toWidth(size.width).el_toHeight(size.height);
    };
}
- (UIView*(^)(CGFloat))el_toWidth{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
        [self addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat))el_toHeight{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
        [self addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(CGFloat width, NSLayoutRelation relation))el_toWidthRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
        [self addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(CGFloat height, NSLayoutRelation relation))el_toHeightRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
        [self addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(NSLayoutAttribute attr1, NSLayoutRelation relation, UIView *toView, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant))el_constraintTo{
    return ^UIView*(NSLayoutAttribute attr1, NSLayoutRelation relation, UIView *toView, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:relation toItem:toView attribute:attr2 multiplier:multiplier constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintLessThanOrEqualTo{
    return ^UIView*(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:NSLayoutRelationLessThanOrEqual toItem:toView attribute:attr2 multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintEnqualTo{
    return ^UIView*(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:NSLayoutRelationEqual toItem:toView attribute:attr2 multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant))el_constraintGreaterThanOrEqualTo{
    return ^UIView*(NSLayoutAttribute attr1, UIView *toView, NSLayoutAttribute attr2, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attr1 relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:toView attribute:attr2 multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)())el_centreToSuperView{
    return ^UIView*{
        return self.el_axisXToSuperView().el_axisYToSuperView();
    };
}
- (UIView*(^)())el_axisXToSuperView{
    return ^UIView*{
        self.el_axisXToSuperViewOffset(0);
        return self;
    };
}
- (UIView*(^)())el_axisYToSuperView{
    return ^UIView*{
        self.el_axisYToSuperViewOffset(0);
        return self;
    };
}

- (UIView*(^)(CGFloat offset))el_axisXToSuperViewOffset{
    return ^UIView*(CGFloat offset){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(CGFloat offset))el_axisYToSuperViewOffset{
    return ^UIView*(CGFloat offset){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:-offset];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}


- (UIView*(^)(UIView *view))el_centreTo{
    return ^UIView*(UIView *view){
        self.el_sameAgixXTo(view).el_sameAgixYTo(view);
        return self;
    };
}
- (UIView*(^)(UIView *view))el_sameAgixXTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(UIView *view))el_sameAgixYTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *view))el_sameTopTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *view))el_sameLeftTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *view))el_sameBottomTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *view))el_sameRightTo{
    return ^UIView*(UIView *view){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)())el_edgesStickToSuperView{
    return ^UIView*(){
        return self.el_edgesToSuperView(0, 0, 0, 0);
    };
}

- (UIView*(^)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right))el_edgesToSuperView{
    return ^UIView*(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
        if (ELFloatNotEqual(top, EL_INGNORE)) {
            self.el_topToSuperView(top);
        }
        if (ELFloatNotEqual(left, EL_INGNORE)) {
            self.el_leftToSuperView(left);
        }
        if (ELFloatNotEqual(bottom, EL_INGNORE)) {
            self.el_bottomToSuperView(bottom);
        }
        if (ELFloatNotEqual(right, EL_INGNORE)) {
            self.el_rightToSuperView(right);
        }
        return self;
    };
}
- (UIView*(^)(CGFloat))el_topToSuperView{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat))el_leftToSuperView{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat))el_bottomToSuperView{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat))el_rightToSuperView{
    return ^UIView*(CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)())el_widthEqualToHeight{
    return ^UIView*(){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_topToSuperViewRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_leftToSuperViewRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:relation toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_bottomToSuperViewRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:-relation toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(CGFloat constant, NSLayoutRelation relation))el_rightToSuperViewRelatedBy{
    return ^UIView*(CGFloat constant, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:-relation toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView*,CGFloat))el_topToView{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(UIView*,CGFloat))el_leftToView{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(UIView*,CGFloat))el_bottomToView{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(UIView*,CGFloat))el_rightToView{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *toView,CGFloat constant))el_leftToRight{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *toView,CGFloat constant))el_rightToLeft{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *toView,CGFloat constant))el_topToBottom{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIView *toView,CGFloat constant))el_bottomToTop{
    return ^UIView*(UIView *view, CGFloat constant){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-constant];
        [self.superview addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}

- (UIView*(^)(UIViewController * viewController))el_stickToTopLayoutGuide{
    return ^UIView*(UIViewController * viewController){
        return self.el_closeToTopLayoutGuide(viewController, 0);
    };
}
- (UIView*(^)(UIViewController * viewController))el_stickToBottomLayoutGuide{
    return ^UIView*(UIViewController * viewController){
        return self.el_closeToBottomLayoutGuide(viewController, 0);
    };
}

- (UIView*(^)(UIViewController * viewController, CGFloat inset))el_closeToTopLayoutGuide{
    return ^UIView*(UIViewController * viewController, CGFloat inset){
        return self.el_toTopLayoutGuide(viewController, inset, NSLayoutRelationEqual);
    };
}
- (UIView*(^)(UIViewController * viewController, CGFloat inset))el_closeToBottomLayoutGuide{
    return ^UIView*(UIViewController * viewController, CGFloat inset){
        return self.el_toBottomLayoutGuide(viewController, inset, NSLayoutRelationEqual);
    };
}

- (UIView*(^)(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation))el_toTopLayoutGuide{
    return ^UIView*(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation toItem:viewController.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:inset];
        [viewController.view  addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
- (UIView*(^)(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation))el_toBottomLayoutGuide{
    return ^UIView*(UIViewController * viewController, CGFloat inset, NSLayoutRelation relation){
        self.translatesAutoresizingMaskIntoConstraints = NO;
        inset = -inset;
        if (relation == NSLayoutRelationLessThanOrEqual) {
            relation = NSLayoutRelationGreaterThanOrEqual;
        } else if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation = NSLayoutRelationLessThanOrEqual;
        }
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation toItem:viewController.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:inset];
        [viewController.view addConstraint:constraint];
        [self el_setCurrentConstraint:constraint];
        return self;
    };
}
@end

@implementation UIView (EasyLayout_Helper)

- (NSLayoutConstraint*)el_constraintTopToSuperView{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeTop && [each.secondItem isEqual:self.superview ] && each.secondAttribute == NSLayoutAttributeTop) || (([each.firstItem isEqual:self.superview] && each.firstAttribute == NSLayoutAttributeTop) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeTop)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintLeftToSuperView{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeLeft && [each.secondItem isEqual:self.superview ] && each.secondAttribute == NSLayoutAttributeLeft) || (([each.firstItem isEqual:self.superview] && each.firstAttribute == NSLayoutAttributeLeft) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeLeft)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintBottomToSuperView{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeBottom && [each.secondItem isEqual:self.superview ] && each.secondAttribute == NSLayoutAttributeBottom) || (([each.firstItem isEqual:self.superview] && each.firstAttribute == NSLayoutAttributeBottom) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeBottom)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintRightToSuperView{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeRight && [each.secondItem isEqual:self.superview ] && each.secondAttribute == NSLayoutAttributeRight) || (([each.firstItem isEqual:self.superview] && each.firstAttribute == NSLayoutAttributeRight) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeRight)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintWidth{
    for (NSLayoutConstraint *each in self.constraints) {
        if([each isMemberOfClass:[NSLayoutConstraint class]]){
            if([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeWidth){
                return each;
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintHeight{
    for (NSLayoutConstraint *each in self.constraints) {
        if([each isMemberOfClass:[NSLayoutConstraint class]]){
            if([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeHeight){
                return each;
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_currentConstraint{
    return objc_getAssociatedObject(self, &CurrentConstraintKey);
}

- (NSLayoutConstraint*)el_constraintTopToBottomView:(UIView*)view{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeTop && [each.secondItem isEqual:view ] && each.secondAttribute == NSLayoutAttributeBottom) || (([each.firstItem isEqual:view] && each.firstAttribute == NSLayoutAttributeTop) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeBottom)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintLeftToRightView:(UIView*)view{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeLeft && [each.secondItem isEqual:view ] && each.secondAttribute == NSLayoutAttributeRight) || (([each.firstItem isEqual:view] && each.firstAttribute == NSLayoutAttributeLeft) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeLeft)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintBottomToTopView:(UIView*)view{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeBottom && [each.secondItem isEqual:view ] && each.secondAttribute == NSLayoutAttributeTop) || (([each.firstItem isEqual:view] && each.firstAttribute == NSLayoutAttributeBottom) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeTop)){
                    return each;
                }
            }
        }
    }
    return nil;
}
- (NSLayoutConstraint*)el_constraintRightToLeftView:(UIView*)view{
    if (self.superview) {
        for (NSLayoutConstraint *each in self.superview.constraints) {
            if([each isMemberOfClass:[NSLayoutConstraint class]]){
                if(([each.firstItem isEqual:self] && each.firstAttribute == NSLayoutAttributeRight && [each.secondItem isEqual:view ] && each.secondAttribute == NSLayoutAttributeLeft) || (([each.firstItem isEqual:view] && each.firstAttribute == NSLayoutAttributeRight) && [each.secondItem isEqual:self ] && each.secondAttribute == NSLayoutAttributeLeft)){
                    return each;
                }
            }
        }
    }
    return nil;
}
@end

@implementation NSArray (EasyLayout_Helper)
- (NSArray<NSLayoutConstraint *>*)el_distributeViewsAlongAxisXWithSize:(CGSize)size
                                                                margin:(CGFloat)margin{
    
    NSMutableArray<NSLayoutConstraint*> *constraints = [NSMutableArray new];
    CGFloat itemWidth = size.width;
    CGFloat count = self.count;
    
    for (NSInteger i = 0; i < self.count; ++i) {
        UIView *view = self[i];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [view.el_axisYToSuperView().el_constraintTo(NSLayoutAttributeCenterX, NSLayoutRelationEqual, view.superview, NSLayoutAttributeCenterX, MAX(0.0001, i / (count - 1) * 2), itemWidth * (i + 0.5) - (i * (count * itemWidth + 2*margin))/(count-1) + margin).el_toSize(size) el_currentConstraint];
        [constraints addObject:constraint];
        
    }
    return constraints;
}

- (NSArray<NSLayoutConstraint *>*)el_distributeViewsAlongAxisYWithSize:(CGSize)size
                                                                margin:(CGFloat)margin{
    NSMutableArray<NSLayoutConstraint*> *constraints = [NSMutableArray new];
    CGFloat itemWidth = size.width;
    CGFloat count = self.count;
    
    for (NSInteger i = 0; i < self.count; ++i) {
        UIView *view = self[i];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *constraint = [view.el_axisXToSuperView().el_constraintTo(NSLayoutAttributeCenterY, NSLayoutRelationEqual, view.superview, NSLayoutAttributeCenterY, MAX(0.0001, i / (count - 1) * 2), itemWidth * (i + 0.5) - (i * (count * itemWidth + 2*margin))/(count-1) + margin).el_toSize(size) el_currentConstraint];
        [constraints addObject:constraint];
        
    }
    return constraints;
}

- (NSArray<NSLayoutConstraint *>*)autoSetViewsWidth:(CGFloat)width{
    return nil;
}
- (NSArray<NSLayoutConstraint *>*)autoSetViewsheight:(CGFloat)height{
    return nil;
}
@end
