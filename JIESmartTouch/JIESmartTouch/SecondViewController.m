//
//  SecondViewController.m
//  20170315Jeff
//
//  Created by 管宇杰 on 17/3/17.
//  Copyright © 2017年 管宇杰. All rights reserved.
//

#import "SecondViewController.h"
#import "TableViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    //因为我们项目之前后面都是有一个nil的。所以这里nil也保留着。
    label.text = LBDynamic(@"Battery", nil);
    label.font = [UIFont fontWithName:@"Courier" size:30];
//    label.text = NSLocalizedString(@"Battery", nil);
    
    
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
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
}



@end
