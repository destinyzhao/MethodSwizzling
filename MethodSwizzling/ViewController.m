//
//  ViewController.m
//  MethodSwizzling
//
//  Created by Alex on 16/2/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self print:@"viewWillAppear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    // 利用Method Swizzling NSMutableArray addObject 为nil时候程序不会崩溃
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSInteger i=0; i < 9; i++) {
//        [array addObject:nil];
//    }
//    NSLog(@"array is :%@",array);
//
//    // 利用Method Swizzling 设置NSMutableDictionary object 为nil时候程序不会崩溃
//    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
//    [mutableDic setObject:nil forKey:@"key"];
//    NSLog(@"mutableDic is :%@",mutableDic);
    
    NSArray *testArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    
    
    // 结果
    NSLog(@"%@", [testArray objectAtIndex:8]);
    
}

- (void)print:(NSString *)aStr
{
    NSLog(@"print:%@",aStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
