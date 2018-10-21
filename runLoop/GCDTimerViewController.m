//
//  GCDTimerViewController.m
//  RunLoop
//
//  Created by LYH on 2018/10/21.
//  Copyright © 2018年 LYH-1140663172@qq.com. All rights reserved.
//

#import "GCDTimerViewController.h"

@interface GCDTimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation GCDTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"GCD定时器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //GCD定时器不受RunLoop的Model的影响
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2 * NSEC_PER_SEC);
    dispatch_after(start, dispatch_get_main_queue(), ^{
        
    });
    //上下俩句代码意思一样
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
}
NSInteger count = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"hahah ------");
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器（dispatch_source_t本质还是个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    //GCD定时器要比NSTimer精确的多。
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
//        NSLog(@"------------%@", [NSThread currentThread]);
        NSLog(@"begin timer ");
        count ++;
        self.lab.text = [NSString stringWithFormat:@"开始%ld",count];
//        if (count == 4) {
//            //取消定时器
//            dispatch_cancel(self.timer);
//            self.timer = nil;
//        }
    });
    
    //启动定时器
    dispatch_resume(self.timer);
    //你随便滑动控制器上的textView，GCD定时器依然工作
    
}
@end
