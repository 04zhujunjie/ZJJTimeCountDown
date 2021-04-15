# ZJJTimeCountDown    

## 效果图
![image](https://github.com/04zhujunjie/ZJJTimeCountDown/blob/master/Screenshot/ZJJCountDown.gif)

## 特点：
1、已封装，支持自定义     
2、支持文本各种对齐模式        
3、各种效果都可以通过设置ZJJTimeCountDownLabel类属性来实现        
4、支持背景图片设置      
5、分文本显示时间时，支持设置文字大小，来动态设置每个文本宽度   
6、动态的每个Cell中可支持多个倒计时
## 支持pod导入
pod 'ZJJTimeCountDown', '~> 1.0.3'

## 使用注意事项：      
1、显示倒计时的label要使用ZJJTimeCountDownLabel类或者继承ZJJTimeCountDownLabel类       
2、要在使用label前设置label属性,动态Cell上使用一定要设置timeKey属性值，非动态Cell上使用不需要设置timeKey属性值，因为内部实现已经设置好  
3、在动态的UITableViewCell或UICollectionViewCell上使用倒计时label，需要调用以下两个方法        
```
- (void)setupCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)countDownWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel;

```
4、设置textAdjustsWidthToFitFont属性值为YES，要确保label宽度够长  


ZJJTimeCountDownLabel 支持对齐方式
```
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
```

ZJJTimeCountDown 支持时间格式:
```
typedef NS_ENUM(NSInteger , ZJJCountDownTimeStyle) {

    //时间格式：2017-7-12 18:06:22
    ZJJCountDownTimeStyleNormal = 0,
    //时间戳：1591881249
    ZJJCountDownTimeStyleTamp,
    //时间格式 20170712180622
    ZJJCountDownTimeStylePureNumber
    
};
```

## 如何使用   

### 一、使用ZJJTimeCountDownLabel类或继承ZJJTimeCountDownLabel类来创建倒计时label ，        并在初始化视图时设置label属性,动态Cell上的label的timeKey属性一定要设置，推荐以下三种设置方式

1)、如果是使用继承ZJJTimeCountDownLabel类，在该类的.m文件中重写以下方法        

```
- (void)setupProperty{
    //对应模型中要显示的倒计时的属性字符串（动态Cell中，必须要设置timeKey）
    self.timeKey = @"endTime";
     //边框模式
    self.textStyle = ZJJTextStlyeDDHHMMSSBox;
    //居中对齐
    self.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
}
```

2）、直接使用ZJJTimeCountDownLabel类，如果非xib形式，初始化时进行设置     

```
    self.timeLabel = [[ZJJTimeCountDownLabel alloc] init];
    //对应模型中要显示的倒计时的属性字符串（动态Cell中，必须要设置timeKey）
    self.timeLabel.timeKey = @"endTime";
     //边框模式
    self.timeLabel.textStyle = ZJJTextStlyeDDHHMMSSBox;
    //居中对齐
    self.timeLabel.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
    //过时后，显示的文字
    self.timeLabel.jj_description = @"活动结束了！😄😄";
```

3）、直接使用ZJJTimeCountDownLabel类，如果是xib形式，在ZJJTimeCountDownLabel的父视图初始化时设置 
```
  - (void)awakeFromNib {
    [super awakeFromNib];
      //对应模型中要显示的倒计时的属性字符串（动态Cell中，必须要设置timeKey）
    self.timeLabel.timeKey = @"endTime";
    //居中对齐
    self.timeLabel.jj_textAlignment = ZJJTextAlignmentStlyeCenter;
    //过时后，显示的文字
    self.timeLabel.jj_description = @"活动结束了！😄😄";
}

```

### 二、创建ZJJTimeCountDown对象，不同的使用场景，创建ZJJTimeCountDown对象的方法也有所不同，以下两种使用场景

#### 1、在动态的UITableViewCell或UICollectionViewCell上使用
1)、创建JJTimeCountDown对象的方法
```
_countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.dataList];
```
2）、在代理方法中设置label的indexPath和attributedText属性
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    ZJJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZJJTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    TimeModel *model = self.dataList[indexPath.row];
    //一定要设置，设置时间数据
    [cell.timeLabel setupCellWithModel:model indexPath:indexPath];
    //在不设置为过时自动删除情况下 设置该方法后，滑动过快的时候时间不会闪情况
    cell.timeLabel.attributedText = [self.countDown countDownWithTimeLabel:cell.timeLabel];
    
    return cell;
}
```
3）、在Cell的区头或区尾上使用，返回的区头或区尾视图代理方法中，要先调用以下方法，对视图进行处理
```
- (UIView *)dealWithHeaderView:(UIView *)view viewForHeaderInSection:(NSInteger)section;

- (UIView *)dealWithFooterView:(UIView *)view viewForFooterInSection:(NSInteger)section;

```
#### 2 非动态的UITableViewCell或UICollectionViewCell上使用

 1）创建JJTimeCountDown对象并添加label
 ```
    _countDown = [[ZJJTimeCountDown alloc] init];
    //时间格式为时间戳
    _countDown.timeStyle = ZJJCountDownTimeStyleTamp;
    //设置代理
    _countDown.delegate = self;
    //添加数据， time：时间戳
    [_countDown addTimeLabel:self.timeLabel time:@"1591881249"];
 ```

### 三、ZJJTimeCountDown代理方法
```
/**
 过时的数据自动删除回调方法， 针对UITableView 或者 UICollectionView上的倒计时视图

 @param model 数据模型
 */
- (void)scrollViewWithAutomaticallyDeleteModel:(id)model;
/**
 过时的数据回调方法,回调的数据调用addTimeLabel:(ZJJTimeCountDownLabel *)timeLabel time:(NSString *)time方法所添加数据

 @param timeLabel 倒计时视图
 @param timeCountDown self
 */
- (void)outDateTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;

/**
 每次执行倒计时，回调方法
 @param timeLabel 倒计时Label
 @param timeCountDown self
 */
- (void)dateWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;


/**
 自定义时间格式方法 ，需要设置timeLabel的textStyle为ZJJTextStlyeCustom，自定义时间样式才会生效
 如果返回值为nil或者@“”，自定义时间格式失败，失败后显示原来时间格式
 @param timeLabel 时间label
 @param timeCountDown self
 @return 自定义时间格式字符
 */
- (NSAttributedString *)customTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;
```
### 四、销毁定时器
```
- (void)dealloc{
    [self.countDown destoryTimer];
}

```    


