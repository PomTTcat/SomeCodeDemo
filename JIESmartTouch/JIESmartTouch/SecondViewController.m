//
//  SecondViewController.m
//  20170315Jeff
//
//  Created by 管宇杰 on 17/3/17.
//  Copyright © 2017年 管宇杰. All rights reserved.
//

#import "SecondViewController.h"

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
//    label.text = NSLocalizedString(@"Battery", nil);
}

@end
