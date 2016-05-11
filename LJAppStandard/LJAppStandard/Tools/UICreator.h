//
//  UICretator.h
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于按钮中，文字和图片相对方向
typedef NS_ENUM(NSInteger,BtnImgDirectionType)
{
    BtnImgDirectionDefault, //默认：图片居左，文字居右。整体左右结构
    BtnImgDirectionRight,   //图片居右，文字居左。整体左右机构
    BtnImgDirectionTop,     //图片居上，文字居下。整体上下机构
    BtnImgDirectionBottom,  //图片居下，文字居上。整体上下机构
};

@interface UICreator : NSObject

//For UIView
/**
 *  创建一个UIView
 *
 *  @param bgColor      背景色
 *  @param cornerRadius 圆角
 */
+ (UIView *)createUIViewWithBgColor:(UIColor *)bgColor
                             Corner:(float)cornerRadius;
/**
 *  创建一个UIView
 *
 *  @param bgColor      背景色
 *  @param cornerRadius 圆角
 *  @param gesture      手势
 */
+ (UIView *)createUIViewWithBgColor:(UIColor *)bgColor
                             Corner:(float)cornerRadius
                      actionGesture:(UIGestureRecognizer *)gesture;


//For UILabel
+ (UILabel *)createLabel:(NSString *)text
                fontSize:(int)fontSize;
+ (UILabel *)createLabel:(NSAttributedString *)aText
                 bgColor:(UIColor *)bgColor;
+ (UILabel *)createLabel:(NSString *)text
                   color:(UIColor *)color
                    font:(UIFont *)font;
+ (UILabel *)createLabel:(NSString *)text
                   color:(UIColor *)color
                 bgColor:(UIColor *)bgColor
                    font:(UIFont *)font;

//For UIButton
/**
 *  创建一个按钮
 *
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param font       字体
 *  @param target     接受者
 *  @param action     行为
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                             target:(id)target
                             action:(SEL)action;

/**
 *  创建一个按钮
 *
 *  @param title        标题
 *  @param titleColor   标题颜色
 *  @param font         字体
 *  @param buttonType   按钮类型
 *  @param bgColor      背景色
 *  @param cornerRadius 圆角
 *  @param target       接受者
 *  @param action       行为
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                         buttonType:(UIButtonType)buttonType
                            bgColor:(UIColor *)bgColor
                             corner:(float)cornerRadius
                             target:(id)target
                             action:(SEL)action;

/**
 *  创建一个按钮
 *
 *  @param title     标题
 *  @param imageName 图片
 *  @param titleEdge 标题内边距
 *  @param imageEdge 图片内边距
 *  @param target    接受者
 *  @param action    行为
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(NSString *)imageName
                          titleEdge:(UIEdgeInsets)titleEdge
                          imageEdge:(UIEdgeInsets)imageEdge
                             target:(id)target
                             action:(SEL)action;

/**
 *  创建一个按钮
 *
 *  @param normalImageName      正常图片
 *  @param highlightedImageName 高亮图片
 *  @param target               接受者
 *  @param action               行为
 */
+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                         highlightedImage:(NSString *)highlightedImageName
                                   target:(id)target
                                   action:(SEL)action;

/**
 *  创建一个按钮
 *
 *  @param title       标题
 *  @param imageName   图片
 *  @param titleColor  标题颜色
 *  @param font        字体
 *  @param type        按钮的排布类型（请看枚举）
 *  @param hAlign      水平对齐类型
 *  @param vAlign      垂直对齐类型
 *  @param contentEdge 内边距
 *  @param span        间隔
 *  @param target      接受者
 *  @param action      行为
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(NSString *)imageName
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                      directionType:(BtnImgDirectionType)type
         contentHorizontalAlignment:(UIControlContentHorizontalAlignment)hAlign
           contentVerticalAlignment:(UIControlContentVerticalAlignment)vAlign
                  contentEdgeInsets:(UIEdgeInsets)contentEdge
                               span:(CGFloat)span
                             target:(id)target
                             action:(SEL)action;


//For UIImageView（会造成离屏渲染，待优化）
+ (UIImageView *)createImageViewFromImagename:(NSString *)imagename round:(BOOL)round;


//For UITextFiled
/**
 *  创建一个UITextField
 *
 *  @param font            字号
 *  @param textColor       文字颜色
 *  @param backgroundColor 背景色
 *  @param borderStyle     边框类型
 *  @param placeholder     占位文字
 *  @param delegate        代理
 */
+ (UITextField *)createTextFieldWithFont:(UIFont *)font
                               textColor:(UIColor *)textColor
                         backgroundColor:(UIColor *)backgroundColor
                             borderStyle:(UITextBorderStyle)borderStyle
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate;

/**
 *  创建一个UITextField
 *
 *  @param aTitle          标题
 *  @param font            字体
 *  @param textColor       文字颜色
 *  @param backgroundColor 背景色
 *  @param placeholder     占位文字
 *  @param keyboardType    键盘类型
 *  @param returnKeyType   返回按钮类型
 *  @param delegate        代理
 */
+ (UITextField *)createTextFieldWithLeftAttrTitle:(NSAttributedString *)aTitle
                                             font:(UIFont*)font
                                        textColor:(UIColor*)textColor
                                  backgroundColor:(UIColor*)backgroundColor
                                      placeholder:(NSString*)placeholder
                                     keyboardType:(UIKeyboardType)keyboardType
                                    returnKeyType:(UIReturnKeyType)returnKeyType
                                         delegate:(id<UITextFieldDelegate>)delegate;


//For UITextView
/**
 *  返回一个UITextView
 *
 *  @param aString 富文本的文字
 *  @param eEnable 能否编辑
 *  @param sEnable 能否滚动 */
+ (UITextView *)createTextViewWithAttrString:(NSAttributedString *)aString
                                  editEnable:(BOOL)eEnable
                                scroolEnable:(BOOL)sEnable;


//For UITableView
/**
 *  返回一个UITableView
 *
 *  @param style              样式
 *  @param seporatorLineColor 分隔线颜色
 *  @param headerView         头部视图
 *  @param footerView         尾部视图
 *  @param delegate           代理
 */
+ (UITableView *)createTableWithStyle:(UITableViewStyle)style
                   seporatorLineColor:(UIColor *)seporatorLineColor
                           headerView:(UIView *)headerView
                           footerView:(UIView *)footerView
                             delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;

//For UIWebView
/**
 *  返回一个UIWebView
 *
 *  @param webUrl   url地址
 *  @param sEnable  是否滚动
 *  @param delegate 代理
 */
+ (UIWebView *)createWebViewWithUrl:(NSString *)webUrl
                       scroolEnable:(BOOL)sEnable
                           delegate:(id<UIWebViewDelegate>)delegate;


@end
