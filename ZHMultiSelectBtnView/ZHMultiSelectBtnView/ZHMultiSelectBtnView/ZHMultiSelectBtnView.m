//
//  ZHMultiSelectBtnView.m
//  
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 中华. All rights reserved.
//
#define NeedWidth   self.frame.size.width  // 需求总宽度
#define NeedHeight  self.frame.size.height // 需求总高度
#define NeedFont 14   // 需求文字大小
#define NeedClumMargin 12  //列间距
#define NeedRowMargin 12  //行间距
#define NeedBtnHeight 33   // 按钮高度
#define NeedBtnMargin 24  //实际算出文字宽度加上这个间距，为按钮宽度
#define NeedSelectedColor [UIColor colorWithRed:29.0/255.0 green:210.0/255.0 blue:92.0/255.0 alpha:1.0]
#define NeedDefaultColor [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0]
#define NeedDefaultTitleColor [UIColor blackColor]

#import "ZHMultiSelectBtnView.h"

@interface ZHMultiSelectBtnView()

@property (nonatomic , strong) UIButton * currentSelectedBtn ;
@property (nonatomic,strong) NSMutableArray *btnArray;
@end

@implementation ZHMultiSelectBtnView
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray ;
}

-(void)setContentArray:(NSArray *)contentArray{
    _contentArray = contentArray;
    if (self.btnArray.count) {
        for (UIButton *BTN in self.btnArray) {
            [BTN removeFromSuperview];
        }
    }
    [self.btnArray removeAllObjects];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor] ;
    for(int i = 0; i < self.contentArray.count; i++){
        //设置计算好的位置数值
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setHighlighted:NO];
        //设置内容
        [btn setTitle:self.contentArray[i] forState:UIControlStateNormal];
        //设置文字状态颜色UIColorFromRGB(252, 114, 34)]
        [btn setTitleColor:NeedDefaultTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:NeedSelectedColor forState:UIControlStateSelected];
        //文字大小
        btn.titleLabel.font = [UIFont systemFontOfSize:NeedFont];
        //裁圆角
        btn.layer.cornerRadius = NeedBtnHeight/2;
        btn.clipsToBounds = YES ;
        //设置边框
        btn.layer.borderWidth = 1 ;
        btn.layer.borderColor = NeedDefaultColor.CGColor ;
        //设置角标
        btn.tag = i;
        //添加事件
        [btn addTarget:self action:@selector(SelBtn:) forControlEvents:UIControlEventTouchUpInside];
        //添加按钮
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self test];
}
- (void)test {
    
    NSMutableArray *caculateArray = [NSMutableArray array];
    for(int i = 0; i < self.btnArray.count; i++){

        //1. 拿到将要添加按钮的内容，计算出宽高
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
        CGRect frame_W = [self.contentArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        //将要按钮的宽度/高度
        CGFloat btnW = frame_W.size.width + NeedBtnMargin;
        CGFloat btnH = NeedBtnHeight;
        
        //2. 拿到当前布局的最后一个按钮的最大X值
        CGFloat lastBtnX = 0;
        UIButton *lastBtn = caculateArray.lastObject;
        if (!lastBtn) {
            lastBtnX = 0;
        }else{
            lastBtnX = CGRectGetMaxX(lastBtn.frame);
        }
        //3. 计算剩下的宽度是否大于当前将要添加的按钮宽度,然后获取出将要添加按钮的x，y
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat xxx = NeedWidth - lastBtnX;
        if (xxx > btnW + NeedClumMargin *2) {
            btnX = lastBtnX + NeedClumMargin;
            btnY = lastBtn.frame.origin.y;
        }else{
            btnX = NeedClumMargin;
            btnY = CGRectGetMaxY(lastBtn.frame) + NeedRowMargin;
        }
        //4. 拿到将要添加的按钮，设置frame
        UIButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [caculateArray addObject:btn];
    }
    if ([self.delegate respondsToSelector:@selector(multiSelectBtnView:andMultiSelectBtnViewHeight:)]) {
        UIButton *btn = self.btnArray.lastObject;
        [self.delegate multiSelectBtnView:self andMultiSelectBtnViewHeight:CGRectGetMaxY(btn.frame)+10];
    }
}
-(CGFloat)multiSelectBtnViewHeight{
    UIButton *btn = self.btnArray.lastObject;
    return CGRectGetMaxY(btn.frame)+10;
}
-(void)setDefineIndex:(NSInteger)index{
    UIButton *btn = self.btnArray[index];
    if (btn) {
        [self SelBtn:btn];
    }
}
-(void)setDefineIndexArray:(NSArray *)indexArray{
    if (self.isSingleSelect) {
        NSLog(@"当前为单选，不能默认多个选择");
        return;
    }
    for (NSString *index in indexArray) {
        UIButton *btn = self.btnArray[[index intValue]];
        if (btn) {
            [self SelBtn:btn];
        }
    }
}
-(NSArray *)fechSelectedResult{
    NSMutableArray *array = [NSMutableArray array];
    for (UIButton *btn  in self.btnArray) {
        if (btn.selected) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        }
    }
    return array;
}

-(void)SelBtn:(UIButton *)sender{
    
    if (self.isSingleSelect) {
        self.currentSelectedBtn.selected = NO ;
        sender.selected = YES ;
        self.currentSelectedBtn.layer.borderColor = NeedDefaultColor.CGColor ;
        [self.currentSelectedBtn setTitleColor: NeedDefaultTitleColor forState:UIControlStateSelected];
        self.currentSelectedBtn = sender ;
    }else{
        sender.selected = !sender.selected;
    }
    if (sender.isSelected) {
        sender.layer.borderColor = NeedSelectedColor.CGColor ;
        [sender setTitleColor:NeedSelectedColor forState:UIControlStateSelected];
    }else{
        sender.layer.borderColor = NeedDefaultColor.CGColor ;
        [sender setTitleColor: NeedDefaultTitleColor forState:UIControlStateSelected];
    }
}

@end

