//
//  ZHViewController.m
//  LZH_BtnSelect
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 刘中华. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHMultiSelectBtnView.h"
#import "ZHBtnCameraView.h"
@interface ZHViewController ()
@property (weak, nonatomic) IBOutlet ZHMultiSelectBtnView *selectView;

@end

@implementation ZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.selectView.contentArray =@[@"希望是本无所谓有",@"无所谓无的",@"这正如地上的路",@"其实地上本没有路",@"走的人多了",@"也便成了路",@"抱歉！",@"我是周树人，我为自己代言"];
//    [self.selectView setDefineIndexArray:@[@"0",@"2",@"4"]];
//    ZHBtnCameraView *vvv = [ZHBtnCameraView btnCameraView];
//    vvv.frame = self.view.bounds;
//    [self.view addSubview:vvv];
//    UIView *bgView = [[UIView alloc] init];
//    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];;
//    bgView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
//    [self.view addSubview:bgView];
//    NSLog(@"%@",self.selectView.fechSelectedResult);
//    ZHBtnCameraView *vvv = [ZHBtnCameraView btnCameraView];
//    vvv.frame = self.view.bounds;
//    vvv.makeSureBlock = ^{
//        [bgView removeFromSuperview];
//    };
//    [self.view addSubview:vvv];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];;
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    NSLog(@"%@",self.selectView.fechSelectedResult);
    ZHBtnCameraView *vvv = [ZHBtnCameraView btnCameraView];
    vvv.frame = self.view.bounds;
    vvv.makeSureBlock = ^(NSArray *array) {
         [bgView removeFromSuperview];
    };
    [self.view addSubview:vvv];
}

@end
