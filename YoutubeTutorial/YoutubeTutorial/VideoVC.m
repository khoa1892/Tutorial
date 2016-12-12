//
//  VideoVC.m
//  YoutubeTutorial
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "VideoVC.h"
#import "Video.h"

@interface VideoVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    self.titleLabel.text = self.video.videoTitle;
    self.descLabel.text = self.video.videoDescription;
    
    [self.webView loadHTMLString:self.video.videoiFrame baseURL:nil];
}

- (void)dealloc
{
    self.titleLabel = nil;
    self.descLabel = nil;
    self.webView = nil;
}

- (IBAction)doneBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *css = @".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%; } .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%;}";
    NSString* js = [NSString stringWithFormat:
                    @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

@end
