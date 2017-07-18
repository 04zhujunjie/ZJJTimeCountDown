//
//  ZJJRegularlyViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/15.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJRegularlyViewController.h"
#import "ZJJTimeCountDown.h"
#import "ZJJTimeCountDownDateTool.h"

@interface ZJJRegularlyViewController ()<ZJJTimeCountDownDelegate>
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *oneTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *twoTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *threeTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *fourTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *fiveTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *sixTimeLabel;
@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *sevenTimeLabel;

@property (nonatomic ,strong) ZJJTimeCountDown *countDown;

@property (weak, nonatomic) IBOutlet ZJJTimeCountDownLabel *eighthTimeLabel;

@end

@implementation ZJJRegularlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //时间样式为时间戳
    self.countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    self.countDown.delegate = self;
    [self setupOneTimeLabelP];
    [self setupTwoTimeLabelP];
    [self setupThreeTimeLabelP];
    [self setupFourTimeLabelP];
    [self setupFiveTimeLabelP];
    [self setupSixTimeLabelP];
    [self setupSevenTimeLabelP];
    [self setupEighthTimeLabelP];
    [self addTimeLabel];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupOneTimeLabelP{
    self.oneTimeLabel.jj_description = @"活动已经结束!😄😄";
    //设置垂直方向居中
     self.oneTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeVerticalCenter;
    //设置偏顶部距离
    self.oneTimeLabel.textTopDeviation = 15;
    //整体背景图片
    self.oneTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground1"];

}



- (void)setupTwoTimeLabelP{

    //自定义模式，
    self.twoTimeLabel.textStyle = ZJJTextStlyeCustom;
    //设置水平方向居中
    self.twoTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeHorizontalCenter;
    //设置偏左距离
    self.twoTimeLabel.textLeftDeviation = 20;
    //过时后保留最终的样式
    self.twoTimeLabel.isRetainFinalValue = YES;
    //整体背景图片
    self.twoTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground2"];
    
    
   
}
- (void)setupThreeTimeLabelP{
    
    //边框模式
    self.threeTimeLabel.textStyle = ZJJTextStlyeHHMMSSBox;
    self.threeTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeRightTop;
    self.threeTimeLabel.hourAddString = @"小时";
    self.threeTimeLabel.minuteAddString = @"MMM";
    self.threeTimeLabel.secondAddString = @"S";
    self.threeTimeLabel.textHeight = 30;
    //设置文本距离背景左右边距
    self.threeTimeLabel.textAdjustsWidthLeftRightSide = 10;
    self.threeTimeLabel.textBackgroundBorderColor = [UIColor greenColor];
    //设置间隔符颜色
    self.threeTimeLabel.textIntervalSymbolColor = [UIColor redColor];
    //设置间隔符文字大小
    self.threeTimeLabel.textIntervalSymbolFont = [UIFont boldSystemFontOfSize:25];
    //设置自适应文本
    self.threeTimeLabel.textAdjustsWidthToFitFont = YES;
    
    //整体背景图片
    self.threeTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground1"];
   
}
- (void)setupFourTimeLabelP{
    
    //边框模式
    self.fourTimeLabel.textStyle = ZJJTextStlyeHHMMSSChineseBox;
    //设置字体效果为描边效果
    self.fourTimeLabel.effectStlye = ZJJTextEffectStlyeHollow;
    //设置描边效果颜色，默认是字体颜色，空心字体颜色优先与字体颜色
    self.fourTimeLabel.textHollowColor = [UIColor whiteColor];
    //设置描边效果宽度
    self.fourTimeLabel.textHollowWidth = -5;
    //设置扁平化系数，一般系数值在0～0.5;
    self.fourTimeLabel.textFlatModulus = 0.2;
    //过时后保留最终的样式
    self.fourTimeLabel.isRetainFinalValue = YES;
    //字体颜色
    self.fourTimeLabel.textColor = [UIColor redColor];
    //单个文本背景颜色
    self.fourTimeLabel.textBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //设置单个文本宽度
    self.fourTimeLabel.textHeight = 30;
    //设置单个文本宽度是否自适应文字大小
    self.fourTimeLabel.textAdjustsWidthToFitFont = YES;
    //每个文本背景间隔
    self.fourTimeLabel.textBackgroundInterval = 8;
    //设置文本距离背景左右边距
    self.fourTimeLabel.textAdjustsWidthLeftRightSide = 10;
    //设置圆角
    self.fourTimeLabel.textBackgroundRadius = 5;
    //文本边宽颜色
    self.fourTimeLabel.textBackgroundBorderColor = [UIColor blueColor];
    //文本边框宽度
    self.fourTimeLabel.textBackgroundBorderWidth = 2;
    
    //整体背景图片
    self.fourTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground2"];
}

- (void)setupFiveTimeLabelP{
    
    //边框模式
    self.fiveTimeLabel.textStyle = ZJJTextStlyeDDHHMMSSChineseBox;
    //对齐方式
    self.fiveTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeLeftBottom;
    self.fiveTimeLabel.font = [UIFont systemFontOfSize:15];
    //设置单个文本宽度是否自适应文字大小
    self.fiveTimeLabel.textAdjustsWidthToFitFont = YES;
    //设置自适应后，单个文本中的字体距离单个文本的左右距离，默认是5
    self.fiveTimeLabel.textAdjustsWidthLeftRightSide = 10;
    //每个文本背景间隔
    self.fiveTimeLabel.textBackgroundInterval = 20;
    //设置间隔符
    self.fiveTimeLabel.textIntervalSymbol = @"&";
    //间隔符大小
    self.fiveTimeLabel.textIntervalSymbolFont = [UIFont boldSystemFontOfSize:20];
    //间隔符颜色
    self.fiveTimeLabel.textIntervalSymbolColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
    //单个文本背景颜色
    self.fiveTimeLabel.textBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    self.fiveTimeLabel.textColor = [UIColor blackColor];
    
    //设置单个文本背景图片
    self.fiveTimeLabel.textBackgroundImage = [UIImage imageNamed:@"money_bg_mask"];
    
    //整体背景图片
    self.fiveTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground1"];
    
    //设置字体效果为描边效果
    self.fiveTimeLabel.effectStlye = ZJJTextEffectStlyeHollow;
    //设置描边效果颜色，默认是字体颜色，空心字体颜色优先与字体颜色
    self.fiveTimeLabel.textHollowColor = [UIColor whiteColor];
    //设置描边效果宽度，大于0为空心效果
    self.fiveTimeLabel.textHollowWidth = 6;
    
}

- (void)setupSixTimeLabelP{
    
    //边框模式
    self.sixTimeLabel.textStyle = ZJJTextStlyeHHMMSSChineseBox;
    //设置对齐方式
    self.sixTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeRightBottom;
    //固定单个文本宽度
    self.sixTimeLabel.textWidth = 80;
    self.sixTimeLabel.textHeight = 35;
    //设置间隔符
    self.sixTimeLabel.textIntervalSymbol = @"  ";

    //整体背景图片
    self.sixTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground2"];
    self.sixTimeLabel.font = [UIFont systemFontOfSize:15];
    self.sixTimeLabel.textColor = [UIColor whiteColor];
    //设置单个文本背景图片
    self.sixTimeLabel.textBackgroundImage = [UIImage imageNamed:@"textBackground"];
    
    //设置单个文本背景图片拉伸参数
    self.sixTimeLabel.resizableImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //设置圆角
    self.sixTimeLabel.textBackgroundRadius = 5;
    //文本边宽颜色
    self.sixTimeLabel.textBackgroundBorderColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.9];
    //文本边框宽度
    self.sixTimeLabel.textBackgroundBorderWidth = 3;
    
  
}

- (void)setupSevenTimeLabelP{
    

    //边框模式
    self.sevenTimeLabel.textStyle = ZJJTextStlyeDDHHMMSSBox;
     self.sevenTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
    self.sevenTimeLabel.dayAddString = @"天";
    self.sevenTimeLabel.hourAddString = @"小时";
    self.sevenTimeLabel.minuteAddString = @"分钟";
    self.sevenTimeLabel.secondAddString = @"秒";
    //设置文本高度
    self.sevenTimeLabel.textHeight = 30;
    //设置间隔符
    self.sevenTimeLabel.textIntervalSymbol = @" ";
    //每个文本间隔
    self.sevenTimeLabel.textBackgroundInterval = 5;
    //设置自适应文本
    self.sevenTimeLabel.textAdjustsWidthToFitFont = YES;
    //设置单个文本背景色为透明色
    self.sevenTimeLabel.textBackgroundColor = [UIColor clearColor];
    self.sevenTimeLabel.font = [UIFont systemFontOfSize:19];
    self.sevenTimeLabel.textColor = [UIColor darkGrayColor];
    //设置单个文本背景图片
    self.sevenTimeLabel.textBackgroundImage = [UIImage imageNamed:@"money_bg_mask"];
    //设置文本背景图片拉伸参数
    self.sevenTimeLabel.resizableImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //整体背景图片
    self.sevenTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground1"];
    //设置整体背景图片拉伸参数
    self.sevenTimeLabel.resizableBackgroundImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.5;//模糊度
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    //设置阴影
    self.sevenTimeLabel.textShadow = shadow;
}

- (void)setupEighthTimeLabelP{
    
    //边框模式
    self.eighthTimeLabel.textStyle = ZJJTextStlyeDDHHMMSSChineseBox;
    //设置对齐方式
    self.eighthTimeLabel.jj_textAlignment = ZJJTextAlignmentStlyeCustom;
    self.eighthTimeLabel.textLeftDeviation = 30;
    self.eighthTimeLabel.textTopDeviation = 6;
    self.eighthTimeLabel.textHeight = 43;
    self.eighthTimeLabel.textAdjustsWidthToFitFont = YES;
    //设置间隔符
    self.eighthTimeLabel.textIntervalSymbol = @"  ";
    
    //整体背景图片
    self.eighthTimeLabel.backgroundImage = [UIImage imageNamed:@"timeBackground2"];
    self.eighthTimeLabel.textColor = [UIColor whiteColor];
    //设置单个文本背景图片
    self.eighthTimeLabel.textBackgroundImage = [UIImage imageNamed:@"timeBackground1"];
    
    //设置单个文本背景图片拉伸参数
//    self.eighthTimeLabel.resizableImageWithCapInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //设置圆角
//    self.eighthTimeLabel.textBackgroundRadius = 5;
//    //文本边宽颜色
//    self.eighthTimeLabel.textBackgroundBorderColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.9];
//    //文本边框宽度
//    self.eighthTimeLabel.textBackgroundBorderWidth = 3;
    
    
}

- (void)addTimeLabel{

    [self.countDown addTimeLabel:self.oneTimeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:5 timeStyle:self.countDown.timeStyle]];
    [self.countDown addTimeLabel:self.twoTimeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:20 timeStyle:self.countDown.timeStyle]];
    [self.countDown addTimeLabel:self.threeTimeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:50 timeStyle:self.countDown.timeStyle]];
    [self.countDown addTimeLabel:self.fourTimeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:105 timeStyle:self.countDown.timeStyle]];
    [self.countDown addTimeLabel:self.fiveTimeLabel time:@"1566666666"];
    
    [self.countDown addTimeLabel:self.sixTimeLabel time:[ZJJTimeCountDownDateTool dateByAddingSeconds:6668888 timeStyle:self.countDown.timeStyle]];
    [self.countDown addTimeLabel:self.sevenTimeLabel time:@"1596889949"];
    [self.countDown addTimeLabel:self.eighthTimeLabel time:@"1666666666"];
    

}

//过时回调方法
- (void)outDateTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{
    
    if ([timeLabel isEqual:self.oneTimeLabel]) {
        self.oneTimeLabel.textColor = [UIColor redColor];
     
    }

}

- (NSAttributedString *)customTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{

    if ([timeLabel isEqual:self.twoTimeLabel]) {
       
        NSArray *textArray = @[[NSString stringWithFormat:@"%.2ld",timeLabel.days],
                               @" 天",
                               [NSString stringWithFormat:@"  %.2ld",timeLabel.hours],
                               @" 小时",
                               [NSString stringWithFormat:@"  %.2ld",timeLabel.minutes],
                               @" 分",
                               [NSString stringWithFormat:@"  %.2ld",timeLabel.seconds],
                               @" 秒"];
        
        return [self dateAttributeWithTexts:textArray];
    }
    return nil;
}

- (NSAttributedString *)dateAttributeWithTexts:(NSArray *)texts{

    NSDictionary *datedic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor orangeColor],NSStrokeWidthAttributeName:@(-5),NSStrokeColorAttributeName:[UIColor whiteColor]};
    NSMutableAttributedString *dateAtt = [[NSMutableAttributedString alloc] init];
    
    [texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *text = (NSString *)obj;
        //说明是时间字符串
        if ([text integerValue] || [text rangeOfString:@"0"].length) {
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:datedic]];
        }else{
        
            
            UIColor *color = (idx+1)%4?[UIColor greenColor]:[UIColor blueColor];
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color}]];
        }
        
    }];
    return dateAtt;
}


- (ZJJTimeCountDown *)countDown{
    
    if (!_countDown) {
        
        _countDown = [[ZJJTimeCountDown alloc] init];
    }
    return _countDown;
}

- (void)dealloc{
    [self.countDown destoryTimer];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
