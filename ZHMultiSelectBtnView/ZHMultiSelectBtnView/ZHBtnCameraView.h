//
//  ZHBtnCameraView.h
//  ZHMultiSelectBtnView
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 chinamobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHBtnCameraView : UIView
+(instancetype)btnCameraView;
@property (nonatomic,copy) void(^makeSureBlock)(NSArray *);
@end
