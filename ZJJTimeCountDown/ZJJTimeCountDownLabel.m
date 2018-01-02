//
//  ZJJTimeCountDownLabel.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJTimeCountDownLabel.h"
#import "UIImage+ZJJTimeCountDown.h"
#import "ZJJTimeCountDownLabelTextStlyeTool.h"

static NSString *const kZJJTimeCountDownLabelDescription = @"活动已经结束！";


@interface ZJJTimeCountDownLabel (){

    CGFloat _dayTextWidth;
    CGFloat _hourTextWidth;
    CGFloat _minuteTextWidth;
    CGFloat _secondTextWidth;
    NSMutableArray *_textWidthArray;
}

@end

@implementation ZJJTimeCountDownLabel


- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefultProperty];
        [self setupProperty];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupDefultProperty];
        [self setupProperty];
    }
    return self;
}

- (void)setupDefultProperty{
    
    _jj_description = kZJJTimeCountDownLabelDescription;
    _textIntervalSymbol = @":";
    _textBackgroundColor = [UIColor orangeColor];
    _textIntervalSymbolColor = [UIColor blackColor];
    _textBackgroundRadius = 5;
    _textBackgroundBorderWidth = 1;
    _textBackgroundInterval = 10;
    _textHeight = 25;
    _textWidth = 25;
    _textIntervalSymbolFont = self.font;
    self.textAdjustsWidthToFitFont = NO;
    self.textAdjustsWidthLeftRightSide = 5;
    self.dayAddString = @"";
    self.hourAddString = @"";
    self.minuteAddString = @"";
    self.secondAddString = @"";
    self.textLeftDeviation = 0;
    self.textTopDeviation = 0;
    self.textHollowWidth = 4;
}



- (void)setupProperty{
    
}

/**
 设置Cell数据
 
 @param model 数据模型
 @param indexPath 设置文本所在位置在位置
 */
- (void)setupCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.model = model;
}

- (void)setupDateChineseAddString{

    self.dayAddString = @"天";
    self.hourAddString = @"时";
    self.minuteAddString = @"分";
    self.secondAddString = @"秒";
}


- (CGFloat)setupAdaptiveWidthWithText:(NSString *)text{

    CGSize size = [self textBackgroundSizeWithText:text];
    return size.width+self.textAdjustsWidthLeftRightSide*2;
}

- (BOOL)isNillWithString:(NSString *)str{

    if (!str || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (void)drawRect:(CGRect)rect{
    
    [self drawBackgroundImageWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    if ([self.attributedText.string isEqualToString:self.jj_description]) {
        
        if (self.isRetainFinalValue) {
            
            if ([ZJJTimeCountDownLabelTextStlyeTool isBoxStyleWithLabel:self]) {
               
                //这里大小不能使用rect大小，要使用self.frame.size大小，如果使用rect的高度会发生变化
                CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
                [self drawBoxWithRext:labelRect];
                
            }else{
            
                self.attributedText = [self addTextEffectWithAttributedString:self.textFinalValue];
                
                [super drawRect:rect];
            }
            
        }else{
            self.attributedText =  [self addTextEffectWithAttributedString:[[NSAttributedString alloc] initWithString:self.jj_description]];
           [super drawRect:rect];
        }
        
        return;
    }
    
    if (![ZJJTimeCountDownLabelTextStlyeTool isBoxStyleWithLabel:self]) {
        self.attributedText = [self addTextEffectWithAttributedString:self.attributedText];
        [super drawRect:rect];
        return;
    }
    //这里大小不能使用rect大小，要使用self.frame.size大小，如果使用rect的高度会发生变化
    CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self drawBoxWithRext:labelRect];

    
}

- (NSAttributedString *)addTextEffectWithAttributedString:(NSAttributedString *)att{

    NSMutableAttributedString *muAtt = [[NSMutableAttributedString alloc] initWithAttributedString:att];
    //扁平化
    if (self.textFlatModulus) {
        [muAtt addAttributes:@{NSExpansionAttributeName:@(self.textFlatModulus)} range:NSMakeRange(0, att.string.length)];
    }
    //设置阴影
    if (self.textShadow) {
         [muAtt addAttributes:@{NSShadowAttributeName:self.textShadow} range:NSMakeRange(0, att.string.length)];
    }
    
    if (self.effectStlye == ZJJTextEffectStlyeHollow) {
        
        [muAtt addAttributes:[self addTextHollowDic] range:NSMakeRange(0, att.string.length)];
        return muAtt;
    }
    return att;
}

- (void)drawBoxWithRext:(CGRect)rect{

    NSArray *textArray = [ZJJTimeCountDownLabelTextStlyeTool getTextArrayWithLabel:self];
    //保存单个文本宽度
    [self setupTextWidthWithTexts:textArray];
    //获取整体文本的宽度
    CGFloat labelWidth = [self drawRect:rect texts:textArray isGetLabelWidth:YES originX:0];
    CGRect newRect = [ZJJTimeCountDownLabelTextStlyeTool textBoxAlignmentRectWithLabel:self boxWidth:labelWidth rect:rect];
    [self drawRect:newRect texts:textArray isGetLabelWidth:NO originX:newRect.origin.x];
}

- (void)drawBackgroundImageWithRect:(CGRect)rect{

    if (self.backgroundImage) {
        self.backgroundImage = [self.backgroundImage resizableImageWithCapInsets:self.resizableBackgroundImageWithCapInsets resizingMode:UIImageResizingModeStretch];
        [self.backgroundImage drawInRect:rect];
    }
   
}


- (CGFloat)drawRect:(CGRect)rect texts:(NSArray *)texts isGetLabelWidth:(BOOL)isGetLabelWidth originX:(NSInteger)origin_x{

    CALayer *textLayer = [CALayer layer];
    [self.layer addSublayer:textLayer];
     CGFloat originX= origin_x;
    for (int i = 0; i < texts.count; i ++) {
        
        NSString *text = texts[i];
        
        CGFloat textWidth = [_textWidthArray[i] floatValue];
        CGFloat width = 0;
        //说明是间隔符
        if ([text isEqualToString:self.textIntervalSymbol]) {
            //设置为间隔符宽度
            width = self.textBackgroundInterval;
        }else{
            //文本自适应
            if (self.textAdjustsWidthToFitFont) {
                //说明不是第一单文本，直接使用缓存单文本的宽度
                if (i) {
                    width = textWidth;
                }else{//说明是第一单文本
                    //说明对应数字时间小于100，使用缓存单文本的宽度
                    if ([text integerValue] < 100) {
                        width = textWidth;
                    }else{
                        //计算文本宽度
                        width = [self setupAdaptiveWidthWithText:text];
                    }
                }
            }else{//不是自适应文本
                width = textWidth-self.textAdjustsWidthLeftRightSide*2;
            }
            
        }
        CGRect textRect = CGRectMake(originX, rect.origin.y, width, _textHeight);
        textLayer.frame = textRect;
        if (!isGetLabelWidth) {
           [self drawTextRect:textRect text:text];
        }
       
        originX = originX+width;
        
    }
    return originX;
}



- (void)drawTextRect:(CGRect)textRect text:(NSString *)text{

    UIImage *image = self.textBackgroundImage;
    //不是间隔符
    if (![text isEqualToString:self.textIntervalSymbol]) {
        //没有图片
        if (!image) {
             image = [UIImage imageWithColor:self.textBackgroundColor size:textRect.size radius:self.textBackgroundRadius borderWidth:self.textBackgroundBorderWidth borderColor:self.textBackgroundBorderColor];
        }else{
            //绘制图片
            image = [UIImage circleImage:image radius:self.textBackgroundRadius borderWidth:self.textBackgroundBorderWidth borderColor:self.textBackgroundBorderColor];
            
            if (image.size.width < textRect.size.width) {
                //设置图片拉伸， 指定为拉伸模式，伸缩后重新赋值
                image = [image resizableImageWithCapInsets:self.resizableImageWithCapInsets resizingMode:UIImageResizingModeStretch];
            }
            
        }
        //绘制单个文本背景图
        [image drawInRect:textRect];
    }
    
    
    if ([text isEqualToString:self.textIntervalSymbol]) {
    
        CGSize size1 = [self textIntervalSizeWithText:text];
        CGRect rect1 = textRect;
        rect1.size = CGSizeMake(size1.width, size1.height+4);
        CGRect newTextRect = [self textRect:textRect boundingRect:rect1];
        [text drawInRect:newTextRect withAttributes:[self textIntervalAttributes]];
        return;
    }
    
    CGSize size1 = [self textBackgroundSizeWithText:text];
    CGRect rect1 = textRect;
    rect1.size = size1;
    CGRect newTextRect = [self textRect:textRect boundingRect:rect1];
    [text drawInRect:newTextRect withAttributes:[self textBackgroundAttributes]];
}


- (NSDictionary *)textIntervalAttributes{

    return @{NSFontAttributeName:self.textIntervalSymbolFont == nil?self.font:self.textIntervalSymbolFont,NSForegroundColorAttributeName:self.textIntervalSymbolColor == nil?self.textColor:self.textIntervalSymbolColor};
}

- (CGSize)textIntervalSizeWithText:(NSString *)text{
    
    NSDictionary *dic = [self textIntervalAttributes];
    
    return[self textBackgroundSizeWithText:text size:CGSizeMake(self.textBackgroundInterval, _textHeight) dic:dic];
}

- (NSDictionary *)textBackgroundAttributes{

    NSDictionary *dic = @{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor,NSExpansionAttributeName:@(self.textFlatModulus)};
    return [self addTextEffect:dic];
}



- (NSDictionary *)addTextEffect:(NSDictionary *)dic{

   
    if (self.effectStlye == ZJJTextEffectStlyeHollow) {
        
      NSMutableDictionary * newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [newDic addEntriesFromDictionary:[self addTextHollowDic]];
        return newDic;
    }
    
    if (self.textShadow) {
        NSMutableDictionary * newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [newDic addEntriesFromDictionary:@{NSShadowAttributeName:self.textShadow}];
        return newDic;
    }
    
    return dic;
}

- (NSDictionary *)addTextHollowDic{

    return @{NSStrokeWidthAttributeName:@(self.textHollowWidth),NSStrokeColorAttributeName:self.textHollowColor == nil ?self.textColor:self.textHollowColor};
}

- (CGSize)textBackgroundSizeWithText:(NSString *)text{

    NSDictionary *dic = [self textBackgroundAttributes];
    CGSize size = [self textBackgroundSizeWithText:text size:CGSizeMake(1000, _textHeight) dic:dic];
    return size;
}

- (CGSize)textBackgroundSizeWithText:(NSString *)text size:(CGSize)size dic:(NSDictionary *)dic{

   return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}


- (CGRect)textRect:(CGRect)rect boundingRect:(CGRect)boundingRect{

    CGFloat widthDiff = rect.size.width - boundingRect.size.width;
    CGFloat heightDiff = rect.size.height - boundingRect.size.height;
    CGRect newTextRect = CGRectMake(rect.origin.x+(widthDiff)/2.0,rect.origin.y+(heightDiff)/2.0,boundingRect.size.width, boundingRect.size.height);
    return newTextRect;
}

- (void)setupTextWidthWithTexts:(NSArray *)texts{

    //存储每个文本的宽度
    if (!_textWidthArray) {
        _textWidthArray = [NSMutableArray array];
        [self setupDayTextWidth];
        [self setupHourTextWidth];
        [self setupMinuteTextWidth];
        [self setupSecondTextWidth];
        NSMutableArray *newTexts = [NSMutableArray arrayWithArray:texts];
        //如果有间隔符，去掉间隔符
        if (self.textIntervalSymbol) {
           [newTexts removeObject:self.textIntervalSymbol]; 
        }
        
        switch (newTexts.count) {
            case 4:
            {

                if (self.textIntervalSymbol) {
                    [_textWidthArray addObject:@(_dayTextWidth)];
                    [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_hourTextWidth)];
                     [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_minuteTextWidth)];
                     [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                    
                }else{
                
                    [_textWidthArray addObject:@(_dayTextWidth)];
                    [_textWidthArray addObject:@(_hourTextWidth)];
                    [_textWidthArray addObject:@(_minuteTextWidth)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                }
              
            }
                break;
            case 3:
            {
               
                if (self.textIntervalSymbol) {
                    [_textWidthArray addObject:@(_hourTextWidth)];
                    [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_minuteTextWidth)];
                    [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                    
                }else{
                    [_textWidthArray addObject:@(_hourTextWidth)];
                    [_textWidthArray addObject:@(_minuteTextWidth)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                }
            }
                break;
            case 2:
            {
                if (self.textIntervalSymbol) {

                    [_textWidthArray addObject:@(_minuteTextWidth)];
                    [_textWidthArray addObject:@(_textBackgroundInterval)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                    
                }else{
                    [_textWidthArray addObject:@(_minuteTextWidth)];
                    [_textWidthArray addObject:@(_secondTextWidth)];
                }
            }
                break;
                
            case 1:
            {
                 [_textWidthArray addObject:@(_secondTextWidth)];
            }
                break;
                
                
            default:
                break;
        }
        
    }
}

- (void)setupDayTextWidth{

    _dayTextWidth = _textWidth;
    if (self.textAdjustsWidthToFitFont) {
        
        NSString *dayString = [NSString stringWithFormat:@"00%@",_dayAddString];
        _dayTextWidth = [self setupAdaptiveWidthWithText:dayString];
    }
}

- (void)setupHourTextWidth{

    _hourTextWidth = _textWidth;
    if (self.textAdjustsWidthToFitFont) {
        NSString *hourString = [NSString stringWithFormat:@"00%@",_hourAddString];
        _hourTextWidth = [self setupAdaptiveWidthWithText:hourString];
    }
}

- (void)setupMinuteTextWidth{
    
    _minuteTextWidth = _textWidth;
    if (self.textAdjustsWidthToFitFont) {
        NSString *minuteString = [NSString stringWithFormat:@"00%@",_minuteAddString];
        _minuteTextWidth = [self setupAdaptiveWidthWithText:minuteString];
    }
}

- (void)setupSecondTextWidth{
    
    _secondTextWidth = _textWidth;
    if (self.textAdjustsWidthToFitFont) {
        NSString *secondString = [NSString stringWithFormat:@"00%@",_secondAddString];
        _secondTextWidth = [self setupAdaptiveWidthWithText:secondString];
    }
}

#pragma mark ===================Setter=================

- (void)setJj_description:(NSString *)jj_description{
    
    _jj_description = jj_description;
    if ([self isNillWithString:jj_description]) {
        self.jj_description = kZJJTimeCountDownLabelDescription;
    }
}

- (void)setTextStyle:(ZJJTextStlye)textStyle{
    
    _textStyle = textStyle;
    
    switch (textStyle) {
        case ZJJTextStlyeDDHHMMSSChineseBox:
        {
            [self setupDateChineseAddString];
        }
            break;
        case ZJJTextStlyeHHMMSSChineseBox:
        {
            [self setupDateChineseAddString];
        }
            break;
        case ZJJTextStlyeMMSSChineseBox:
        {
            [self setupDateChineseAddString];
        }
            break;
        case ZJJTextStlyeSSChineseBox:
        {
            [self setupDateChineseAddString];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{

    [super setTextAlignment:textAlignment];
    self.jj_textAlignment = ZJJTextAlignmentStlyeLeftCenter;
    [self setNeedsDisplay];
    switch (textAlignment) {
        case NSTextAlignmentCenter:
        {
            self.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
        }
            break;
        case NSTextAlignmentRight:
        {
            self.jj_textAlignment = ZJJTextAlignmentStlyeCenterRight;
        }
            break;
        default:
            break;
    }
}

//重新父类方法，自定义对齐方式
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch (self.jj_textAlignment) {
        case ZJJTextAlignmentStlyeLeftCenter:{
        
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            textRect.origin.x = bounds.origin.x;
        }
            break;
        case ZJJTextAlignmentStlyeCenter:{
            
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0;
        }
            break;
        case ZJJTextAlignmentStlyeCenterRight:{
            textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/2.0;
            
        }
            break;
        case ZJJTextAlignmentStlyeCustom:{
            textRect.origin.y = bounds.origin.y+self.textTopDeviation;
            textRect.origin.x = bounds.origin.x+self.textLeftDeviation;
        }
            break;
        case ZJJTextAlignmentStlyeLeftTop:{
            textRect.origin.y = bounds.origin.y;
            textRect.origin.x = bounds.origin.x;
        }
            break;
        
        case ZJJTextAlignmentStlyeLeftBottom:{
            
           textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
             textRect.origin.x = bounds.origin.x;
        }
            break;
        case ZJJTextAlignmentStlyeCenterTop:{
            
            textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0;
            textRect.origin.y = bounds.origin.y;
        }
            break;
            
        case ZJJTextAlignmentStlyeCenterBottom:{
            
            textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0;
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
        }
            break;
        case ZJJTextAlignmentStlyeRightTop:{
            textRect.origin.y = bounds.origin.y;
            textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
        }
            break;
      
        case ZJJTextAlignmentStlyeRightBottom:{
             textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
             textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
        }
            break;
            
        case ZJJTextAlignmentStlyeHorizontalCenter:{
           
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/2.0;
            textRect.origin.x = bounds.origin.x+self.textLeftDeviation;
        }
            break;
            
        case ZJJTextAlignmentStlyeVerticalCenter:{
            
            textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width)/2.0;
            textRect.origin.y = bounds.origin.y + self.textTopDeviation;
        }
            break;

        default:
            break;
            
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
