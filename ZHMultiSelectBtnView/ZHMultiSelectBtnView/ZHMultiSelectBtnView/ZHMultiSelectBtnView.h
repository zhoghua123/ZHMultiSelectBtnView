//
//  ZHMultiSelectBtnView.h
//  LZH_BtnSelect
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 刘中华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMultiSelectBtnView;
@protocol ZHMultiSelectBtnViewDelegate <NSObject>

@optional
-(void)multiSelectBtnView:(ZHMultiSelectBtnView *)multiSelectBtnView andMultiSelectBtnViewHeight:(CGFloat)height;

@end


@interface ZHMultiSelectBtnView : UIView

@property (nonatomic, assign) id<ZHMultiSelectBtnViewDelegate> delegate;
/**
 设置数据源
 */
@property (nonatomic, strong) NSArray *contentArray;

/**
 设置默认选中第几个

 @param index 第几个
 */
-(void)setDefineIndex:(NSInteger)index;

/**
  设置默认选中哪几个

 @param indexArray 必须是字符串：@[@"0",@"5"]
 */
-(void)setDefineIndexArray:(NSArray *)indexArray;

/**
 设置为单选，默认为多选
 */
@property (nonatomic, assign) BOOL isSingleSelect;


/**
 获取选择的所有结果

 */
-(NSArray *)fechSelectedResult;

@end

