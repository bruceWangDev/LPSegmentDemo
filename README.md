# LPSegmentDemo

不忘初心，方得始终

因为有朋友需要，并且Segment控件确实自定义的比较方便，再加上我很想给它来一个淡入淡出的效果。于是就有了 LPSegmentView

![LPMultiSelectDemo展示](https://github.com/EizoiOS/LPSegmentDemo/blob/master/LPSegmentGIF.gif)

1.获取当前下标
 ```	
 - (void)lpSegmentView:(LPSegmentView *)lpSegment selectAtIndex:(NSInteger)index;
 ```

2.初始化 - 第一个参数是Y值 第二个是标签数组 第三个是self
 ```
 - (instancetype)initWithOrginY:(CGFloat)y TitleArr:(NSArray *)titleArr delegate:(id)delegate;
 ```

3.改变下标的方法 - changeIndex
 ```
 - (void)changLPSegemntViewWithIndex:(NSInteger)index;
 ```

## Release
### Version 1.0.0 

## 联系 Support

* 发现问题请 Issues 我，谢谢:-)
* Email: eizoios@126.com
* Blog: http://eizoios.com

## 授权 License

本项目采用 [MIT license](http://opensource.org/licenses/MIT) 开源，你可以利用采用该协议的代码做任何事情，只需要继续继承 MIT 协议即可。