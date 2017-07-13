# ZJJTimeCountDown    
![image](https://github.com/04zhujunjie/ZJJTimeCountDown/blob/master/Screenshot/ZJJCountDown.gif)

如何使用   

1、要显示倒计时的Label要继承ZJJTimeCountDownLabel类，该类有以下属性方法：    
```/**
 时间过时，显示的文字（可选）
 */
@property (nonatomic ,strong) NSString *jj_description;

/**
 对应模型中要显示的倒计时的属性字符串 （必须要设置,在初始化视图时设置）
 */
@property (nonatomic ,strong) NSString *timeKey;

/**
 设置文本所在位置在（动态的UITableViewCell或UICollectionViewCell上使用）
 */
@property (nonatomic ,strong) NSIndexPath *indexPath;

/**
 是否将过时的数据进行删除（可选，在动态的UITableViewCell或UICollectionViewCell上使用）
 */
@property (nonatomic ,assign) BOOL isAutomaticallyDeleted;

/**
 继承该类后，重新设置属性值
 */
- (void)setupProperty;
```
2、创建继承ZJJTimeCountDownLabel类，初始化视图时设置该类的属性

1)、在继承ZJJTimeCountDownLabe类的.m文件中重写以下方法

```
- (void)setupProperty{
    self.timeKey = @"endTime";
    //设置过时数据自动删除
    self.isAutomaticallyDeleted = YES;
}
```

使用场景1   

在动态的UITableViewCell或UICollectionViewCell上使用
