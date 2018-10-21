//
//  ShowImageViewController.m
//  RunLoop
//
//  Created by LYH on 2018/10/21.
//  Copyright © 2018年 LYH-1140663172@qq.com. All rights reserved.
//


#import "ShowImageViewController.h"

@interface ShowImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"展示图片";
    NSLog(@"show image");
    [self observer];
}

- (void)observer {
    // 创建observer,监听RunLoop的状态
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----监听到RunLoop状态发生改变---%zd",activity);
       // 你会发现 CFRunLoopObserverRef 的运行机理
        //如果不做任何操作，这个打印一会就不打印了，线程睡觉了（休眠）
        //如果想在按钮点击之前做一些事情，可以在 activity= 4时处理
    });
    
    // 添加观察者：监听RunLoop的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放Observer
    CFRelease(observer);
    
    /* Run Loop Observer Activities */
    /*
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL <&lt; 0), //即将进入Loop   //1
     kCFRunLoopBeforeTimers = (1UL <&lt; 1),//即将处理Timer   //2
     kCFRunLoopBeforeSources = (1UL <&lt; 2),//即将处理Source  //4
     kCFRunLoopBeforeWaiting = (1UL <&lt; 5),//即将进入休眠  //32
     kCFRunLoopAfterWaiting = (1UL <&lt; 6),//刚从休眠中唤醒   //64
     kCFRunLoopExit = (1UL <&lt; 7),//即将推出Loop  //128
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };  */
}

/*
 现在ARC模式开发，我们创建的OC对象，不需要我们管理内存释放，
 CF的内存管理（Core Foundation），不是OC对象，是C语言层面的东西，不受ARC控制
 1.凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
 * 比如CFRunLoopObserverCreate
 2.release函数：CFRelease(对象);
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     有时我们正在滚动tableView上，会把图片显示出来，但是图片如果比较大，就会渲染，渲染就会比较耗时。
     在ScrollView滑动时展示一堆图片，可能会有点卡，有些人可能会推迟显示
     1：监听ScrollView的滚动，当手松开，ScrollView停止滚动时，让图片显示出来
     滑动时，runLoop进入UITrackingRunLoopMode模式
     */
    //2：  只在NSDefaultRunLoopMode模式下显示图片，滑动停止时，才会显示图片
    [self.showImageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"showImage"] afterDelay:2.0 inModes:@[UITrackingRunLoopMode]];
    NSLog(@"op----");
}

@end
