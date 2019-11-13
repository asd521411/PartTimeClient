//
//  YUXPWkWebViewController.m
//  YUXPing
//
//  Created by edz on 2019/10/21.
//  Copyright © 2019 YUX. All rights reserved.
//

#import "YUXPWkWebViewController.h"
#import <WebKit/WebKit.h>

@interface YUXPWkWebViewController ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *  webView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation YUXPWkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个UIButton
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(10, 0, 40, 40);
    //设置UIButton的图像
    [self.backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (self.adaptiveNaviHeight == YES) {
        self.backButton.hidden = NO;
    }else {
        self.backButton.hidden = YES;
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.adaptiveNaviHeight == YES) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([self.webView canGoBack]) {
                       [self.webView goBack];
                   }else{
                       [self.view resignFirstResponder];
                   }
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [SVProgressHUD show];
    _webView = [[WKWebView alloc]init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
//            if (self.adaptiveNaviHeight == YES) {
//                make.top.mas_equalTo(self.view).mas_offset([ECStyle navigationbarHeight]);
//            }else {
                make.top.mas_equalTo(self.view);
//            }
            make.bottom.equalTo(self.view);
        }];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urls]]];

    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"send"];
    
    if(self.titleStr.length >0){
         self.title = self.titleStr;
    }
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
 
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
 
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.adaptiveNaviHeight == NO) {
        if ([self.webView canGoBack] && self.backButton.hidden == YES) {
            [self.backButton setHidden:NO];
        }else{
            [self.backButton setHidden:YES];
        }
    }
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
 
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
 
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
 
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
 
     NSLog(@"a%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    //该方法是说不需要新建,我只需要在我自己的上加载界面
      WKFrameInfo *frameInfo = navigationAction.targetFrame;
      if (![frameInfo isMainFrame]) {
          [webView loadRequest:navigationAction.request];
      }
      return nil;
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    NSLog(@"%@",message);
    completionHandler();
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"send"]) {
        //做处理 do something
        NSLog(@"捕获到点击事件");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
