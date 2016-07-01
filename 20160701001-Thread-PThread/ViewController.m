//
//  ViewController.m
//  20160701001-Thread-PThread
//
//  Created by Rainer on 16/7/1.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)runButtonClickAction:(id)sender {
    // 如果这里直接调用这个耗时的操作的话那么界面将被卡死，等待此操作完成后才回刷新界面，因为这里是在主线程（UI线程）中
    // 那么要解决这个问题我们可以把这个操作放在异步线程中去解决
//    runLoopSomething();
    
    // 方案一：使用PThread开辟子线程
    // 1.声明一个线程变量
    pthread_t thread;
    
    // 2.创建一个pthread线程并且掉用一个函数执行某些操作
    pthread_create(&thread, NULL, pthreadRunAction, NULL);
}

void * pthreadRunAction(void *param) {
    runLoopSomething();
    
    return NULL;
}

void runLoopSomething() {
    for (NSInteger i = 0; i < 50000; i++) {
        // 获取当前线程的方法：[NSThread currentThread]
        NSLog(@"runLoopSomething:运行至第[%ld]个数，当前线程为:[%@]", i, [NSThread currentThread]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
