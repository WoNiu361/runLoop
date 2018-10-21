//
//  ResidentThreadViewController.m
//  RunLoop
//
//  Created by LYH on 2018/10/21.
//  Copyright © 2018年 LYH-1140663172@qq.com. All rights reserved.
//

#import "ResidentThreadViewController.h"
#import "LYHThread.h"

@interface ResidentThreadViewController ()
@property (nonatomic, strong) LYHThread *thread;

@end

@implementation ResidentThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常驻线程";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.thread = [[LYHThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.thread start];
}

- (void)run1 {
    
    NSLog(@"----------run----%@", [NSThread currentThread]);
    //一直进进出出，并不好
    // RunLoop先判断模式为不为空，或者有没有 source,timer,observer,如果没有则退出。
    
        while (1) {
            [[NSRunLoop currentRunLoop] run];
        }
    
    //    [NSThread exit];//退出RunLoop
    //    NSLog(@"---------");
    
    
    // RunLoop 里面其实是个外循环，只不过这个外循环高级点
    // do {
    // 检测外面的一些事件
    // [self test];
    // } while(1);
}

//这种方式虽然能保住线程的名，但是这条线程就无法处理其他行为（事件）
- (void)run2 {
   
    NSLog(@"----------run----%@", [NSThread currentThread]);
    while (1);// 当前线程永远在处理这行代码，在处理你的分号
    
}

- (void)run {
    
        NSLog(@"----------run----%@", [NSThread currentThread]);
    //  addPort 相当于添加了 source
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"------");
    //    调用run方法，其实 和下面俩句话差不多
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    //一个子线程，一直在后台监听用户的某些行为
    //线程一旦消亡，就不能重新在开启，
}

/*
 线程开启后，完成任务后就会立即销毁，没办法保住它的命。
 线程一旦消亡，就不能重新在开启，
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)test {
    
    NSLog(@"----------test----%@", [NSThread currentThread]);
}

@end
