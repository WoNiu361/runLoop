//
//  NSTimerViewController.m
//  RunLoop
//
//  Created by LYH on 2018/10/21.
//  Copyright © 2018年 LYH-1140663172@qq.com. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()

@end

@implementation NSTimerViewController

- (IBAction)buttonClick:(id)sender {
    //下句代码打印断点，你会看到这个方法的函数调用栈，就在日志打印上面，这个项目名称边
    //函数调用栈，你会看到这个函数的执行顺序和所经历的方法，有助于你理解runLoop
    NSLog(@"button  click");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSRunLoop";
    NSLog(@"view did load ");
    [self timer2];
}

- (void)timer2 {
    //这种方法创建timer,系统会自动会自动添加到当前runLoop中，而且是NSDefaultRunLoopMode，所以定时器就会立马工作
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    //修改timer的模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}

- (void)timer1 {
   
    /*
     通过这种方式创建的NSTimer，是不能启动定时器的，必须把它加入到runLoop中。
     在NSDefaultRunLoopMode模式下，定时器就可以开始工作了。
     定时器只运行在NSDefaultRunLoopMode下，一旦RunLoop进入其他模式，这个定时器就不会工作
     runLoop的运行模式有俩中：NSDefaultRunLoopMode 和 NSRunLoopCommonModes，还有一个模式UITrackingRunLoopMode，只不过它是在UIApplication中的。
     
     这种情况下，滑动textView,定时器就会停止工作，因为此时此刻，RunLoop进入了UITrackingRunLoopMode模式。
     */
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //定时器只运行在NSDefaultRunLoopMode下，一旦RunLoop进入其他模式，这个定时器就不会工作
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //UITrackingRunLoopMode模式,是滑动时RunLoop所在的模式，并不是NSDefaultRunLoopMode，所以定时器不会工作，除非你滑动控制器上的textVeiw.
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // 定时器会跑在标记为common modes的模式下
    // 标记为common modes的模式：UITrackingRunLoopMode和NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)run {
    NSLog(@"qi dong le ---");
}

@end
