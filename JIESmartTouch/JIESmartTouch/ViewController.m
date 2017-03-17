//
//  ViewController.m
//  20170315Jeff
//
//  Created by 管宇杰 on 17/3/15.
//  Copyright © 2017年 管宇杰. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //用法语展示这个语种
    //fr_FR: français (France)
    //en_US: anglais (États-Unis)
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    NSLog(@"fr_FR: %@", [frLocale displayNameForKey:NSLocaleIdentifier value:@"fr_FR"]);
    NSLog(@"en_US: %@", [frLocale displayNameForKey:NSLocaleIdentifier value:@"en_US"]);
}

- (void)pushNext{
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}


@end
