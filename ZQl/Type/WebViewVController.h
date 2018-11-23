//
//  WebViewVController.h
//  thwj
//
//  Created by yudc on 2018/11/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

@interface WebViewVController : UIViewController

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) NSString *goStr;

@end
