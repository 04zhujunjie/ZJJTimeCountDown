//
//  ZJJTimeCountDownLabel.h
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger ,ZJJTextStlye){

    ZJJTextStlyeNormal = 0,
    ZJJTextStlyeCustom,
    ZJJTextStlyeDDHHMMSSBox,
    ZJJTextStlyeHHMMSSBox,
    ZJJTextStlyeMMSSBox,
    ZJJTextStlyeSSBox,
    ZJJTextStlyeDDHHMMSSChineseBox,
    ZJJTextStlyeHHMMSSChineseBox,
    ZJJTextStlyeMMSSChineseBox,
    ZJJTextStlyeSSChineseBox,
    
};


typedef NS_ENUM(NSUInteger, ZJJTextEffectStlye) {
    ZJJTextEffectStlyeNone                     = 0,
    /**
     描边效果  配合textHollowWidth和textHollowColor两个属性使用，textHollowWidth默认是4  textHollowColor 默认是字体颜色
     注意：⚠️ 如果设置textHollowWidth > 0 时为空心效果，全部字体颜色都为描边颜色 如果设置textHollowWidth < 0 时，描边颜色为textHollowColor，中间的颜色为字体颜色
     */
    ZJJTextEffectStlyeHollow,

};


//文本对齐方式
typedef NS_ENUM(NSInteger ,ZJJTextAlignmentStlye){
    
    ZJJTextAlignmentStlyeLeftCenter = 0,
    ZJJTextAlignmentStlyeLeftTop,
    ZJJTextAlignmentStlyeLeftBottom,
    ZJJTextAlignmentStlyeCenterTop,
    ZJJTextAlignmentStlyeCenter,
    ZJJTextAlignmentStlyeCenterBottom,
    ZJJTextAlignmentStlyeRightTop,
    ZJJTextAlignmentStlyeCenterRight,
    ZJJTextAlignmentStlyeRightBottom,
    //自定义位置，配合textLeftDeviation和textTopDeviation属性值来使用
    ZJJTextAlignmentStlyeCustom,
    //水平居中，配合textLeftDeviation属性值来使用
    ZJJTextAlignmentStlyeHorizontalCenter,
    //垂直居中 配合textTopDeviation属性值来使用
    ZJJTextAlignmentStlyeVerticalCenter,

};


@interface ZJJTimeCountDownLabel : UILabel

/**
 label显示样式：默认样式：55天05时30分10秒
 如果要自定义样式，需要设置样式为ZJJTextStlyeCustom，并实现ZJJTimeCountDownDelegate自定义文本方法
 */
@property (nonatomic ,assign) ZJJTextStlye textStyle;

/**
 单个文本框的对齐方式
 */
@property (nonatomic ,assign) ZJJTextAlignmentStlye jj_textAlignment;

/**
 文字效果
 */
@property (nonatomic ,assign) ZJJTextEffectStlye effectStlye;

/**
 时间过时，显示的文字
 */
@property (nonatomic ,strong) NSString *jj_description;

/**
 对应模型中要显示的倒计时的属性字符串（必须要设置,在初始化视图时设置）
 */
@property (nonatomic ,strong)  NSString *timeKey;

/**
 对应模型
 */
@property (nonatomic ,strong) id model;

/**
 设置文本所在位置在（动态的UITableViewCell或UICollectionViewCell上使用）
 */
@property (nonatomic ,strong) NSIndexPath *indexPath;
/**
 是否将过时的数据进行删除（在动态的UITableViewCell或UICollectionViewCell上使用）
 */
@property (nonatomic ,assign) BOOL isAutomaticallyDeleted;

/**
 过时的数据是否保留最后格式 
 默认为NO，不保留格式，显示jj_description值，如果设置为YES ，那么设置jj_description就会失效
 例如显示格式为：8天8时8分8秒 ，过时的时间会一值保留为：0天0时0分0秒
 */
@property (nonatomic ,assign) BOOL isRetainFinalValue;

/**
 保留过时的值，对ZJJTextStlyeNormal和ZJJTextStlyeCustom有效
 */
@property (nonatomic ,strong) NSAttributedString *textFinalValue;
/**
 天数
 */
@property (nonatomic ,assign) NSInteger days;

/**
 小时数
 */
@property (nonatomic ,assign) NSInteger hours;

/**
 分数
 */
@property (nonatomic ,assign) NSInteger minutes;

/**
 秒数
 */
@property (nonatomic ,assign) NSInteger seconds;

/**
 总秒数
 */
@property (nonatomic ,assign) NSInteger totalSeconds;

/**
 天数后面添加的字符串
 */
@property (nonatomic ,strong) NSString *dayAddString;

/**
 针对Box风格
 小时后面添加字符串
 */
@property (nonatomic ,strong) NSString *hourAddString;

/**
 针对Box风格
 分数后面添加字符串
 */
@property (nonatomic ,strong) NSString *minuteAddString;

/**
 针对Box风格
 秒数后面添加字符串
 */
@property (nonatomic ,strong) NSString *secondAddString;


/**
 针对Box风格
 单个文本背景图片
 */
@property (nonatomic ,strong) UIImage *textBackgroundImage;

/**
 整体文本背景图片
 */
@property (nonatomic ,strong) UIImage *backgroundImage;

/**
 整体文本背景图片的拉伸参数
 */
@property (nonatomic ,assign) UIEdgeInsets resizableBackgroundImageWithCapInsets;

/**
 最左边单个文本左偏移量 ，对ZJJTextAlignmentStlyeCustom和ZJJTextAlignmentStlyeHorizontalCenter对齐样式有效
 */
@property (nonatomic ,assign) CGFloat textLeftDeviation;

/**
 针对Box风格
 单个文本顶部偏移量，对ZJJTextAlignmentStlyeCustom和ZJJTextAlignmentStlyeVerticalCenter对齐样式有效
 */
@property (nonatomic ,assign) CGFloat textTopDeviation;

/**
 针对Box风格
 设置单个文本背景图片的拉伸参数
 */
@property (nonatomic ,assign) UIEdgeInsets resizableImageWithCapInsets;

/**
 针对Box风格
 单个文本背景色
 */
@property (nonatomic ,strong) UIColor *textBackgroundColor;

/**
 针对Box风格
 单个文本背景圆角
 */
@property (nonatomic ,assign) CGFloat textBackgroundRadius;
/**
 针对Box风格
 单个文本背景边框颜色
 */
@property (nonatomic ,strong) UIColor *textBackgroundBorderColor;

/**
 针对Box风格
 单个文本之间的间隔
 */
@property (nonatomic ,assign) CGFloat textBackgroundInterval;


/**
 针对Box风格
 单个文本背景框的宽度
 */
@property (nonatomic ,assign) CGFloat textBackgroundBorderWidth;

/**
 针对Box风格
 单个文本间的间隔符
 */
@property (nonatomic ,strong) NSString *textIntervalSymbol;

/**
 针对Box风格
 单个文本间隔符字体大小
 */
@property (nonatomic ,strong) UIFont *textIntervalSymbolFont;

/**
 针对Box风格
 单个文本间的间隔符颜色
 */
@property (nonatomic ,strong) UIColor *textIntervalSymbolColor;

/**
 针对Box风格
 单个文本宽
 */
@property (nonatomic ,assign) CGFloat textWidth;

/**
 针对Box风格
 单个文本高
 */
@property (nonatomic ,assign) CGFloat textHeight;

/**
 针对Box风格
 是否根据文字大小来自动调节宽度
 默认为NO
 如果设置为YES，那么textWidth属性值就会失效 ，一般是配合textAdjustsWidthLeftRightSide属性值来使用
 */
@property (nonatomic ,assign) BOOL textAdjustsWidthToFitFont;

/**
 单文本字体距离单个文本背景左右偏距
 默认值为5，需要将textAdjustsWidthToFitFont设置为YES该值才会生效
 */
@property (nonatomic ,assign) CGFloat textAdjustsWidthLeftRightSide;

/**
 描边效果的宽度，文字效果设置为ZJJTextEffectStlyeNoneHollow风格才有效
 */
@property (nonatomic ,assign) CGFloat textHollowWidth;

/**
 描边效果的颜色，文字效果设置为ZJJTextEffectStlyeNoneHollow风格才有效
 */
@property (nonatomic ,strong) UIColor *textHollowColor;

/**
 扁平化系数，一般是设置在0～0.5之间 ，默认是0
 */
@property (nonatomic ,assign) CGFloat textFlatModulus;

/**
 设置阴影
 */
@property (nonatomic ,strong) NSShadow *textShadow;

/**
 继承该类后，可重新设置属性值
 */
- (void)setupProperty;

/**
 设置Cell数据

 @param model 数据模型
 @param indexPath 设置文本所在位置在位置
 */
- (void)setupCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

@end
