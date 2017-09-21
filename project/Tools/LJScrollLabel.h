//
//  LJScrollLabel.h
//  yy
//
//  Created by 刘蒋 on 2017/9/19.
//  Copyright © 2017年 刘蒋. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 描述字符串滚动前端起始位置：
 */
typedef enum {
    LJLabelScrollContinuous,     // 从控件内开始连续滚动
    LJLabelScrollIntermittent,   // 从控件内开始间断滚动
    LJLabelScrollFromOutside,    // 从控件外开始滚动
    LJLabelScrollWandering       // 在控件中往返滚动（不受设置方向影响）
}LJLabelScrollMode;

/**
 描述字符串移动的方向
 */
typedef enum {
    LJLabelScrollMoveLeft,
    LJLabelScrollMoveRight
}LJLabelScrollMoveDirection;

@interface LJScrollLabel : UIView

/**
 *  请用该函数进行控件的初始化
 *
 *  @param frame         控件的frame
 *  @param scrollModel   字符串的滚动模式
 *  @param moveDirection 滚动方向
 *
 *  @return 控件实例
 */
-(id)initWithFrame:(CGRect)frame LabelScrollModel:(LJLabelScrollMode)scrollModel direction:(LJLabelScrollMoveDirection)moveDirection;



/**
 *  更改滚动的字符串
 *
 *  @param text  字符串内容
 *  @param color 字符串颜色
 *  @param font  字符串字体
 */
-(void)startScrollWithText:(NSString * )text textColor:(UIColor *)color font:(UIFont *)font;



/**
 *  设置字符串移动的速度
 *
 *  @param speed         移动速度 取值越小速度越快 取值范围：0.001~0.1
 */
-(void)setMoveSpeed:(CGFloat)speed;

@end
