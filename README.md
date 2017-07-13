# ZJJTimeCountDown    
![image](https://github.com/04zhujunjie/ZJJTimeCountDown/blob/master/Screenshot/ZJJCountDown.gif)

## 使用注意事项：      
1、显示倒计时的label要使用ZJJTimeCountDownLabel类或者继承ZJJTimeCountDownLabel类       
2、要在初始化视图时设置倒计时label的属性,timeKey属性必须设置       
3、在动态的UITableViewCell或UICollectionViewCell上使用倒计时label，要在UITableView或UICollectionView显示数据的代理中设置label的IndexPath属性
和调用ZJJTimeCountDown类中的以下方法，滑动过快出现闪情况        
```
- (NSString *)countDownWithModel:(id)model timeLabel:(ZJJTimeCountDownLabel *)timeLabel;

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

### 一、使用ZJJTimeCountDownLabel类或继承ZJJTimeCountDownLabel类来创建倒计时label ，        并在初始化视图时设置label属性,label的timeKey属性一定要设置，提倡以下三种设置方式

1)、在继承ZJJTimeCountDownLabel类的.m文件中重写以下方法        

```
- (void)setupProperty{
    self.timeKey = @"endTime";
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
}
```

2）、直接使用ZJJTimeCountDownLabel类，如果非xib形式，初始化时进行设置     

```
    self.timeLabel = [[ZJJTimeCountDownLabel alloc] init];
    self.timeLabel.timeKey = @"endTime";
    self.timeLabel.jj_description = @"活动结束了！😄😄";
```

3）、直接使用ZJJTimeCountDownLabel类，在ZJJTimeCountDownLabel的父视图初始化时设置 ，这里父视图是xib形式
```
  - (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.timeKey = @"startTime";
    self.twoTimeLabel.timeKey = @"endTime";
    self.timeLabel.jj_description = @"活动已经开始";
    self.twoTimeLabel.jj_description = @"活动结束了！😄😄";
}

```

### 二、创建ZJJTimeCountDown对象，不同的使用场景，创建ZJJTimeCountDown对象的方法也有所不同，以下两种使用场景

#### 1、在动态的UITableViewCell或UICollectionViewCell上使用
1)、创建JJTimeCountDown对象的方法
```
_countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.dataList];
```
2）、在代理方法中设置label的indexPath和text属性
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    ZJJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZJJTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    TimeModel *model = self.dataList[indexPath.row];
    //必须设置所显示的行
    cell.timeLabel.indexPath = indexPath;
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.timeLabel.text = [self.countDown countDownWithModel:model timeLabel:cell.timeLabel];
    
    return cell;
}
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

 @param seconds 倒计秒数
 @param timeLabel 倒计时Label
 @param timeCountDown self
 */
- (void)dateWithSeconds:(NSInteger)seconds timeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown;
```
### 四、销毁定时器
```
- (void)dealloc{
    [self.countDown destoryTimer];
}

```
