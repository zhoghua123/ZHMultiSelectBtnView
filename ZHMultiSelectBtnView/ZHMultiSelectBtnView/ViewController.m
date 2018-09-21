//
//  ViewController.m
//  ZHMultiSelectBtnView
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 chinamobile. All rights reserved.
//

#import "ViewController.h"
#import "ZHMultiSelectBtnView.h"
#import "ZHViewController.h"
@interface ViewController ()
@property (nonatomic,strong) ZHMultiSelectBtnView * VView ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    ZHMultiSelectBtnView * VView = [[ZHMultiSelectBtnView alloc] init];
    VView.contentArray =@[@"希望是本无所谓有",@"无所谓无的",@"这正如地上的路",@"其实地上本没有路",@"走的人多了",@"便成了路",@"抱歉！",@"我是周树人，我为自己代言"];
    [self.view addSubview:VView];
    VView.frame = CGRectMake(0, 200, 300, 300);
    VView.isSingleSelect = YES;
    [VView setDefineIndex:5];
    //    [VView setDefineIndexArray:@[@"0",@"2",@"4"]];
    self.VView = VView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",self.VView.fechSelectedResult);
    [self.navigationController pushViewController:ZHViewController.new animated:YES];
}

@end
