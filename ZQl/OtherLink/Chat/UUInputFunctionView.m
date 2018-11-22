//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUInputFunctionView.h"
#import "UUProgressHUD.h"
#import "PrefixHeader.pch"
@interface UUInputFunctionView ()<UITextViewDelegate>
{
    BOOL isbeginVoiceRecord;
    NSInteger playTime;
    NSTimer *playTimer;
    
    UILabel *placeHold;
}
@end

@implementation UUInputFunctionView

- (id)initWithSuperVC:(UIViewController *)superVC
{
    self.superVC = superVC;
    CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, 40);
    
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = MainColor;
        //发送消息
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSendMessage.frame = CGRectMake(VIEW_WIDTH-60, 5, 50, 30);
        self.isAbleToSendTextMessage = NO;
        [self.btnSendMessage setTitle:@"发送" forState:UIControlStateNormal];
        self.btnSendMessage.backgroundColor = [UIColor whiteColor];
        [self.btnSendMessage setTitleColor:MainColor forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        
        self.btnSendMessage.layer.masksToBounds = YES;
        self.btnSendMessage.layer.cornerRadius = 3;
        
        [self addSubview:self.btnSendMessage];
        
        //输入框
        self.TextViewInput = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, VIEW_WIDTH-10-65, 30)];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.font = [UIFont systemFontOfSize:15.0f];
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        self.TextViewInput.returnKeyType = UIReturnKeySend;
        [self addSubview:self.TextViewInput];
        
        //输入框的提示语
        placeHold = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
        placeHold.text = @"请输入评论";
        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        placeHold.font = [UIFont systemFontOfSize:15.0f];
        [self.TextViewInput addSubview:placeHold];
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (void)changeRotate:(NSNotification*)noti {
    
    CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, 40);
    self.frame = frame;
    self.btnSendMessage.frame = CGRectMake(VIEW_WIDTH-60, 5, 50, 30);
    self.TextViewInput.frame = CGRectMake(10, 5, VIEW_WIDTH-10-65, 30);
    
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
    } else {
        //横屏
        self.frame = [UIScreen mainScreen].bounds;
    }
    
}

#pragma mark - 录音touch事件


#pragma mark - Mp3RecorderDelegate

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
//    [self.delegate UUInputFunctionView:self sendVoice:voiceData time:playTime+1];
//    [UUProgressHUD dismissWithSuccess:@"成功"];
//   
//    //缓冲消失时间 (最好有block回调消失完成)
//    self.btnVoiceRecord.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.btnVoiceRecord.enabled = YES;
//    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"时间太短"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

//改变输入与录音状态
- (void)voiceRecord:(UIButton *)sender
{
    [self.delegate approveAdd];
}

//发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
    if (self.TextViewInput.text.length == 0) {
        [ProgressHUD showError:@"请输入评论"];
        return;
    }
    
    NSString *resultStr = [self.TextViewInput.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.delegate UUInputFunctionView:self sendMessage:resultStr];
    self.TextViewInput.text = @"";
    [self.TextViewInput resignFirstResponder];
}


#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    placeHold.hidden = self.TextViewInput.text.length > 0;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self changeSendBtnWithPhoto:textView.text.length>0?NO:YES];
    placeHold.hidden = textView.text.length>0;
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    self.isAbleToSendTextMessage = !isPhoto;
//    [self.btnSendMessage setTitle:isPhoto?@"":@"发送" forState:UIControlStateNormal];
//    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
//    UIImage *image = [UIImage imageNamed:isPhoto?@"icon_fs":@"icon_fs"];
//    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    placeHold.hidden = self.TextViewInput.text.length > 0;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if (self.TextViewInput.text.length == 0) {
            [ProgressHUD showError:@"请输入评论"];
            return NO;
        }
        NSString *resultStr = [self.TextViewInput.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.delegate UUInputFunctionView:self sendMessage:resultStr];
        self.TextViewInput.text = @"";
        [self.TextViewInput resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark - Add Picture
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1){
        [self openPicLibrary];
    }
}

-(void)addCarema{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.superVC presentViewController:picker animated:YES completion:^{}];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)openPicLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.superVC presentViewController:picker animated:YES completion:^{
        }];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self.superVC dismissViewControllerAnimated:YES completion:^{
////        [self.delegate UUInputFunctionView:self sendPicture:editImage];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.superVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)removedealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
