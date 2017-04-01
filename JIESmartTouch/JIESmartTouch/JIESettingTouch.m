//
//  JIESettingTouch.m
//  20170315Jeff
//
//  Created by 管宇杰 on 17/3/15.
//  Copyright © 2017年 管宇杰. All rights reserved.
//

#import "JIESettingTouch.h"


@interface JIESettingTouch ()

@property (nonatomic, weak)     UIView    *centerCircle;
@property (nonatomic, weak)     UIView    *grayView;
@property (nonatomic, strong)   UIView    *nineView;

@property (nonatomic, assign)   CGRect    startFrame;
@property (nonatomic, assign)   CGPoint    viewCenter;

@property (nonatomic, copy)     NSString    *language;

@end

@implementation JIESettingTouch

static CGFloat dTouchWidth = 200;
static CGFloat animatedTime = 0.5;

+ (instancetype)shareTouch{
    static JIESettingTouch *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JIESettingTouch alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *grayV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        grayV.backgroundColor = [UIColor lightGrayColor];
        grayV.layer.cornerRadius = 10;
        grayV.layer.masksToBounds = YES;
        grayV.userInteractionEnabled = YES;
        _grayView = grayV;
        [self addSubview:grayV];
        
        UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        whiteV.backgroundColor = [UIColor whiteColor];
        whiteV.center = self.center;
        whiteV.layer.cornerRadius = 20;
        whiteV.layer.masksToBounds = YES;
        whiteV.userInteractionEnabled = NO;
        _centerCircle = whiteV;
        [grayV addSubview:whiteV];
        
        //show language select view
        UITapGestureRecognizer *tapGray = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu)];
        [_grayView addGestureRecognizer:tapGray];
        
        //回到原来touch状态
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapMainView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToStartFrame)];
        [self addGestureRecognizer:tapMainView];
        
        //可随意移动touch
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMoveTouch:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)showMenu{
    _centerCircle.hidden = YES;

    //先缓存frame，用于恢复
    self.startFrame = self.frame;
    
    [UIView animateWithDuration:animatedTime animations:^{
        UIView *superView = self.superview;
        self.bounds = superView.bounds;
        self.center = superView.center;
        
        _grayView.bounds = CGRectMake(0, 0, dTouchWidth, dTouchWidth);
        _grayView.center = self.center;
    } completion:nil];
    
    [_grayView addSubview:self.nineView];
}

- (void)setSystemLanguage:(UIButton *)button{
    if (button.titleLabel.text) {
        _language = button.titleLabel.text;
//        NSLog(@"--%@",_language);
    }
    [self backToStartFrame];
}

- (void)backToStartFrame{

    [UIView animateWithDuration:animatedTime animations:^{
        [self.nineView removeFromSuperview];
        
        self.frame = self.startFrame;
        _grayView.frame = CGRectMake(0, 0, 60, 60);
        _centerCircle.hidden = NO;
        [self setNeedsLayout];
    } completion:^(BOOL finished) {
    }];
}

//-----pan手势
- (void)panMoveTouch:(UIPanGestureRecognizer *)sender{
    if (self.bounds.size.width > dTouchWidth) {
        return;
    }
    CGPoint poIN = [sender translationInView:self.superview];
    switch (sender.state) {
        case UIGestureRecognizerStateChanged:
            [self iconMove:poIN];
            break;
        case UIGestureRecognizerStateEnded:
            [self moveCenter];
            break;
        default:
            break;
    }
}

- (void)iconMove:(CGPoint)poIN{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeTranslation(poIN.x, poIN.y);
        [self setNeedsLayout];
    }];
}

- (void)moveCenter{
    self.viewCenter = CGPointApplyAffineTransform(self.center, self.transform);
    [UIView animateWithDuration:0.2 animations:^{
        self.center = self.viewCenter;
        self.transform = CGAffineTransformIdentity;
    }];
}

/*
 language = zh-Hans-CN: 请稍候
 language = es-CN: Espera un momento...
 language = zh-Hant-HK: 請稍候
 language = fr-CN: VEUILLEZ PATIENTER
 language = de-CN: BITTE WARTEN
 language = en-CN: PLEASE WAIT
 language = ja: しばらくお待ちください
 */

- (UIView *)nineView{
    if (!_nineView) {
        
        CGFloat w =dTouchWidth/3 - 10;
        CGFloat h =w;
        int count =3;

        CGFloat marginX = (dTouchWidth - count * w) / (count +1);
        CGFloat marginY = (dTouchWidth - count * h) / (count +1);
        
        _nineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, dTouchWidth, dTouchWidth)];
        
        NSDictionary *stringDic = [NSDictionary dictionaryWithObjectsAndKeys:@"zh-Hans",@"简体",@"zh-Hant",@"繁体",@"ja",@"日语",@"es",@"西班牙语",@"fr",@"法语",@"de",@"德语",@"en",@"英语", nil];
        NSArray *stringArr = [NSArray arrayWithObjects:@"简体",@"繁体",@"日语",@"西班牙语",@"法语",@"德语",@"英语", nil];
        
        for(int i =0; i <9; i++) {
            
            int row = i / count;           // => Y
            int col = i % count;           // => X
            
            CGFloat x = marginX + (marginX + w) * col;
            CGFloat y = marginY + (marginY + h) * row;
            
            UIButton*btn = [UIButton new];
            btn.frame=CGRectMake(x, y, w, h);
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 20;
            btn.layer.masksToBounds = YES;
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_nineView addSubview:btn ];
            
            if ((stringArr.count) > i) {
                NSString *name = stringArr[i];
                [btn setTitle:stringDic[name]  forState:UIControlStateNormal];
            }
            
            [btn addTarget:self action:@selector(setSystemLanguage:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _nineView;
}

//---------------
-(NSString *)LBdynamic:(NSString *)key{
    if (!_language) {
        
        NSString *localName = [[NSLocale currentLocale]localeIdentifier];
        if ([localName hasPrefix:@"zh-Hans"] || [localName isEqualToString:@"zh_CN"]) {
            _language = @"zh-Hans";
        } else if ([localName hasPrefix:@"zh-Hant"]) {
            _language = @"zh-Hant";
        } else {
            _language = [localName componentsSeparatedByString:@"_"].firstObject;
        }
    }
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:_language ofType:@"lproj"]];
    return NSLocalizedStringFromTableInBundle(key, @"Localizable", bundle, nil);
}

@end
