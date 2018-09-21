//
//  ZHBtnCameraView.m
//  ZHMultiSelectBtnView
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 chinamobile. All rights reserved.
//

#import "ZHBtnCameraView.h"
#import "ZHMultiSelectBtnView.h"
#import "UIImage+Helper.h"
#define  ZHScreen_WWW UIScreen.mainScreen.bounds.size.width
#define  ZHScreen_HHH UIScreen.mainScreen.bounds.size.height
#define BtnMargn 15
#define ItemWH ZHScreen_WWW *0.33-20
@interface ZHBtnCameraView()<ZHMultiSelectBtnViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnCameraViewConsH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *multiViewConsH;
@property (weak, nonatomic) IBOutlet ZHMultiSelectBtnView *multiView;
@property (weak, nonatomic) IBOutlet UIView *imagesBGView;
@property (weak, nonatomic) IBOutlet UIView *contentViewvv;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic, assign) CGFloat currentH;
@property (nonatomic,weak) UIButton *cameraBtn;
@property (nonatomic,strong) NSMutableArray *imageUrlArray;
@end
@implementation ZHBtnCameraView
- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray ;
}
- (NSMutableArray *)imageUrlArray{
    if (!_imageUrlArray) {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray ;
}
+(instancetype)btnCameraView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.btnCameraViewConsH.constant = 0.7 * ZHScreen_HHH;
    self.multiView.contentArray =@[@"希望是本",@"无所谓无",@"这正如地",@"其实地上",@"走的人了",@"也便成路",@"抱歉！",@"我是周树",@"我是周树",@"我是周树",@"我是周树",@"我是周树"];
    self.multiView.delegate = self;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(BtnMargn, BtnMargn, ItemWH, ItemWH);
    [cameraBtn setImage:[UIImage imageNamed:@"cameraaa"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraAction) forControlEvents:UIControlEventTouchUpInside];
    [self.imagesBGView addSubview:cameraBtn];
    self.cameraBtn = cameraBtn;
}

-(void)multiSelectBtnView:(ZHMultiSelectBtnView *)multiSelectBtnView andMultiSelectBtnViewHeight:(CGFloat)height{
     self.multiViewConsH.constant = height;
    self.currentH = 160+height+ItemWH;
    self.btnCameraViewConsH.constant = self.currentH;
}
-(void)cameraAction{
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectPhoto];
    }];
    [alert addAction:action];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    [alert addAction:action2];
    // 弹出对话框
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
}
- (IBAction)startCamera:(id)sender {
    
}
#pragma mark - 选择图片
//拍照
- (void)takePhoto {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
}

//从相册选择
- (void)selectPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerController Delegate
//选中或使用照片
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (picker.allowsEditing) {//上传头像
        UIImage * editedImg = [info objectForKey:UIImagePickerControllerEditedImage];
        [self.imagesArray addObject:editedImg];
        [self layoutImageWithImage:editedImg];
        NSData * iconData = UIImageJPEGRepresentation([UIImage fixOrientation:editedImg] , 0.5);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)layoutImageWithImage:(UIImage *)image{
    int i = (int)self.imagesArray.count-1;
    CGFloat wh = ItemWH;
    int culumns = 3;
    //行号:index/列数
    int row = i / culumns;
    //列号:index%/列数
    int culumn = i % culumns;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = image;
    imageView.frame = CGRectMake(culumn *(wh + BtnMargn), row *(BtnMargn + wh), wh,wh);
    [self.imagesBGView addSubview:imageView];
    if (i == 5) {
        self.cameraBtn.hidden = YES;
    }else{
        //行号:index/列数
        int row2 = (i+1) / culumns;
        //列号:index%/列数
        int culumn2 = (i+1) % culumns;
        self.cameraBtn.frame = CGRectMake(culumn2 *(wh + BtnMargn), row2 *(BtnMargn + wh), wh,wh);
    }
    if (i==2) {
        self.btnCameraViewConsH.constant = self.currentH + wh;
        self.currentH = self.currentH + wh;
    }
    
}
- (IBAction)makeSure:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
       self.contentViewvv.transform = CGAffineTransformMakeTranslation(0, self.currentH);
    } completion:^(BOOL finished) {
        if (self.makeSureBlock) {
            self.makeSureBlock(self.multiView.fechSelectedResult);
        }
        [self removeFromSuperview];
    }];
}

@end
