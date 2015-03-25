//
//  CommonUI.h
//  iHaiGo
//
//  Created by kc09 on 14-6-11.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    OffsetYZero, //不调整
    OffsetYNormal,//没有navigationbar
    OffsetYNavigationBar,//有navigationbar
}OffsetY_IOS6;

typedef enum {
    NavigationBarTitleViewAlignmentLeft,//左边有按钮
    NavigationBarTitleViewAlignmentCenter,//中间
    NavigationBarTitleViewAlignmentRight,//右边有按钮
} NavigationBarTitleViewAlignment;

#pragma mark - Font
//#define DEFAULT_FONT_NAME       @"HiraKakuProN-W3"
#define DEFAULT_FONT_NAME       @"HelveticaNeue"
//#define DEFAULT_FONT_NAME       @"MicrosoftYaHei"
#define DEFAULT_FONT            [UIFont fontWithName:DEFAULT_FONT_NAME size:15.0]
#define FONT_WITH_SIZE(a)       [UIFont fontWithName:DEFAULT_FONT_NAME size:a]

#pragma mark - Color
#define S_PINK                  [UIColor colorWithRed:0/255.0f green:75/255.0f blue:196/255.0f alpha:1]
#define S_LIGHT_PINK            [UIColor colorWithRed:254/255.0f green:167/255.0f blue:189/255.0f alpha:1]
#define S_GRAY_BG               [UIColor colorWithRed:244/255.0f green:245/255.0f blue:246/255.0f alpha:1]
#define S_GRAY_LINE             [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1]
#define S_LIGHT_BLUE            [UIColor colorWithRed:153/255.0f green:204/255.0f blue:255/255.0f alpha:1]
#define S_LIGHT_BLUE_2          [UIColor colorWithRed:106/255.0f green:177/255.0f blue:250/255.0f alpha:1]
#define S_RED                   [UIColor colorWithRed:250/255.0f green:65/255.0f blue:72/255.0f alpha:1]
#define S_GREEN                 [UIColor colorWithRed:1/255.0f green:197/255.0f blue:153/255.0f alpha:1]
#define S_FONT_BLACK            [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1]
#define S_FONT_GRAY             [UIColor colorWithRed:107/255.0f green:107/255.0f blue:107/255.0f alpha:1]
#define S_FONT_DARK_GRAY       [UIColor colorWithRed:63/255.0f green:68/255.0f blue:70/255.0f alpha:1]

#define S_GRAY_LINE_(a)          [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:a]
#define S_PINK_(a)                  [UIColor colorWithRed:255/255.0f green:64/255.0f blue:112/255.0f alpha:a]

#define STRING_UP(f)            [NSString stringWithFormat:@"%.2f↑",f]
#define STRING_DOWN(f)          [NSString stringWithFormat:@"%.2f↓",f]
#define STRING_ADD(f)           [NSString stringWithFormat:@"+%.2f",f]
#define STRING_MINUS(f)         [NSString stringWithFormat:@"-%.2f",f]

#define STRING_UP_PERCENT(f)            [NSString stringWithFormat:@"%.2f%%↑",f]
#define STRING_DOWN_PERCENT(f)          [NSString stringWithFormat:@"%.2f%%↓",f]
#define STRING_ADD_PERCENT(f)           [NSString stringWithFormat:@"+%.2f%%",f]
#define STRING_MINUS_PERCENT(f)         [NSString stringWithFormat:@"-%.2f%%",f]

#define STRING_UP_STRING(string)            [NSString stringWithFormat:@"%@↑",string]
#define STRING_DOWN_STRING(string)          [NSString stringWithFormat:@"%@↓",string]

@interface CommonUI : NSObject
#pragma mark - Font
/**
 *  设置某视图上的字体为默认字体
 *
 *  @param viewAll 将该视图上的字体设置为默认字体
 */
+ (void)setFontsWithView:(UIView *)viewAll;

#pragma mark - NavigationBar
/**
 *  导航栏返回按钮
 *
 *  @param target   一般为self
 *  @param selector 按钮点击方法
 *
 *  @return 导航栏返回按钮
 */
+ (UIBarButtonItem *)setBackBarButtonItemWithTarget:(id)target withSelector:(SEL)selector;
/**
 *  导航栏图片按钮
 *
 *  @param target         一般为self
 *  @param selector       按钮点击方法
 *  @param imagename      按钮的图片名称
 *  @param highlightimage 按钮的高亮图片名称
 *
 *  @return 导航栏图片按钮
 */
+ (UIBarButtonItem *)setNavigationBarButtonItemWithTarget:(id)target withSelector:(SEL)selector withImage:(NSString *)imagename withHighlightImage:(NSString *)highlightimage;
/**
 *  导航栏文字按钮
 *
 *  @param target   一般为self
 *  @param selector 按钮点击方法
 *  @param title    按钮的标题
 *
 *  @return 导航栏文字按钮
 */
+ (UIBarButtonItem *)setNavigationBarButtonItemWithTarget:(id)target withSelector:(SEL)selector withTitle:(NSString *)title;
/**
 *  导航栏标题view
 *
 *  @param title      导航栏标题
 *  @param aAlignment 导航栏是否有按钮
 *
 *  @return 导航栏标题view
 */
+ (UIView *)setNavigationTitleLabelWithTitle:(NSString *)title withAlignment:(NavigationBarTitleViewAlignment)aAlignment;

/**
 *  导航栏标题带副标题
 *
 *  @param title      导航栏标题
 *  @param aAlignment 导航栏是否有按钮
 *  @param subtitle   副标题
 *
 *  @return 导航栏标题view
 */
+ (UIView *)setNavigationTitleLabelWithTitle:(NSString *)title subtitle:(NSString *)subtitle withAlignment:(NavigationBarTitleViewAlignment)aAlignment;

/**
 *  可伸展图片
 *
 *  @param imgName    可伸展图片的名字
 *  @param edgeinsets 需要缩放的区块
 *
 *  @return 伸展后的图片
 */
+ (UIImage *)stretchImageWithName:(NSString *)imgName edgeInsets:(UIEdgeInsets)edgeinsets;

/**
 *  画上下有灰色边框，底色为白色的image
 *
 *  @param rect image的frame
 *
 *  @return 上下有灰色边框，底色为白色的image
 */
+ (UIImage *)grayEdgeImage:(CGRect)rect;

/**
 *  画有圆角的长方形实心框，圆角为5
 *
 *  @param color 填充色
 *  @param frame 框的frame
 *
 *  @return 有圆角的长方形实心框
 */
+ (UIImage *)roundRectImageFromColor:(UIColor *)color frame:(CGRect)frame;
/**
 *  根据数据返回是涨还是跌，涨为红色，跌为绿色
 *
 *  @param data 需要判断颜色的数据
 *
 *  @return 绿色或红色
 */
+ (UIColor *)textColorByData:(NSString *)data;

+ (void)moveInWithType:(NSString *)type withsubType:(NSString *)subtype withTime:(float)time withView:(UIView *)aView;
@end
