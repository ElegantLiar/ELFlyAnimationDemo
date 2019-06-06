# ELFlyAnimationDemo
高仿飞聊红包打赏动画

效果图如下
![animation.gif](https://upload-images.jianshu.io/upload_images/1770896-45c4fadc37584a4b.gif?imageMogr2/auto-orient/strip)

## 原理
动画主要分为几部分

- 散射粒子动画 （CAEmitterLayer + 金币图画）
- 循环滚动的RMB动画 （Timer） 
- 到达某几个档位时的LOTTIE动画 （对应档位的LOTTIE json动画）
- 持续的震动效果 AudioServicesPlaySystemSound


## 注意

- 散射动画的具体散射形状 角度 速率 自转 重力等效果自己在CAEmitterLayer 和 CAEmitterCell 设置
- 飞聊动画在会话cell上，为节省资源开销，全局使用一份动画
- 长按手势的几个状态处理，当长按时，push下一个页面可能会有问题，注意UIGestureRecognizerStateCancelled的处理
- AudioServicesDisposeSystemSoundID(1519) 为短振，注意在iPhone6 以上机型是没有震动效果的

### [demo地址](https://github.com/Abeautifulliar/ELFlyAnimationDemo)
有不明白的在评论中回复即可，对你有帮助的话麻烦star一下哦
