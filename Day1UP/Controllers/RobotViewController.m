//
//  RobotViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "RobotViewController.h"
#import <iflyMSC/iflyMSC.h>

@interface RobotViewController ()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    UITextView *_speechTextView;
    
    //不带界面的识别对象
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    NSMutableString *curResult;

}

@end

@implementation RobotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"smart robot";
    
    //1.语音合成
    //    1.1在线合成
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
    //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //    [_iFlySpeechSynthesizer startSpeaking: @"你好,我是科大讯飞的小燕"];
    _speechTextView = [[UITextView alloc] init];
    _speechTextView.editable = NO;
    //    WithFrame:CGRectMake(10, 100, self.view.bounds.size.width-20, 100)
    _speechTextView.backgroundColor = [UIColor blackColor];
    _speechTextView.tintColor = [UIColor whiteColor];
    [self.view addSubview:_speechTextView];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paraStyle.lineSpacing = 5.0;
    paraStyle.paragraphSpacing = 10.0;
    paraStyle.firstLineHeadIndent = 30.0;
    paraStyle.headIndent = 5.0;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributeDic = @{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:15],NSForegroundColorAttributeName:[UIColor whiteColor],NSKernAttributeName:@2};
    _speechTextView.typingAttributes = attributeDic;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(sendData)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [toolbar setItems:@[space,space,done] animated:YES];
    _speechTextView.inputAccessoryView = toolbar;
    
    _speechTextView.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view,80)
    .rightSpaceToView(self.view,10)
    .heightIs(100);
    
    
    //2. 语音识别
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iFlySpeechRecognizer.delegate = self;
    //设置听写模式
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //2.设置听写参数
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //3.启动识别服务
    //    [_iFlySpeechRecognizer startListening];
    

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"按住说话" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    btn.layer.cornerRadius = 50.0;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.2 green:0.8 blue:0.5 alpha:1.0]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pStartSpeaking:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(pStopSpeaking:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIView *view = self.view;
    btn.sd_layout.centerXEqualToView(view).topSpaceToView(_speechTextView,50).heightIs(100).widthIs(100);
    
    TTTAttributedLabel *descLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.lineSpacing = 10.0;
    descLabel.kern = 2.0;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    descLabel.text = @"Hi,你好，我是问答机器人。问答数据由“聚合数据”提供，数据供应商为“图灵机器人”。更多免费API请前往www.juhe.cn，探索你喜欢的数据吧~";
    [self.view addSubview:descLabel];
    
    descLabel.sd_layout
    .topSpaceToView(btn,20)
    .leftSpaceToView(view,20)
    .rightSpaceToView(view,20)
    .heightIs(200);
}

#pragma mark - 发送文本信息
- (void)sendData {
    [_speechTextView resignFirstResponder];
}


//结束代理
- (void) onCompleted:(IFlySpeechError *) error{
    NSLog(@"%@",error);
//    [SVProgressHUD showInfoWithStatus:@"合成完毕"];
}
//合成开始
- (void) onSpeakBegin{
    NSLog(@"onSpeakBegin");
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    //    [SVProgressHUD showProgress:progress status:msg];
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
    //    [SVProgressHUD showProgress:progress/10.0];
}



/*识别结果返回代理
 @param :results识别结果
 @ param :isLast 表示是否最后一次结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSLog(@"result:%@  \n%i",results,isLast);
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSMutableString * resultString = [[NSMutableString alloc]init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        
        [result appendFormat:@"%@",key];
        
        NSString * resultFromJson =  [self stringFromJson:result];
        [resultString appendString:resultFromJson];
        
    }
    if (isLast) {
        
        NSLog(@"result is:%@",curResult);
        if (curResult!=nil&&![curResult isEqualToString:@""]) {
            [self requestRobotDataWithInfo:curResult];
            
            [_iFlySpeechRecognizer stopListening];
        }
    }
    
    [curResult appendString:resultString];
    _speechTextView.text = curResult;
    
}

- (NSString *)stringFromJson:(NSString*)params {
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}
/*识别会话结束返回代理
 @ param error 错误码,error.errorCode=0表示正常结束,非0表示发生错误。
 */
- (void)onError: (IFlySpeechError *) error {
    NSLog(@"error:%@",error);
}
/**
 停止录音回调
 ****/
- (void) onEndOfSpeech {
}
/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech {}
/**
 音量回调函数 volume 0-30
 ****/
- (void) onVolumeChanged: (int)volume {}



- (void)speakOut {
    if (_speechTextView.text!=nil&&![_speechTextView.text isEqualToString:@""]) {
//        [SVProgressHUD showInfoWithStatus:@"开始合成"];
        
        [_iFlySpeechSynthesizer startSpeaking: _speechTextView.text];
    }
}


- (void)pStartSpeaking:(UIButton *)btn {
    NSLog(@"startSpeaking");
    [_iFlySpeechRecognizer stopListening];

    [btn setTitle:@"松开停止" forState:UIControlStateNormal];
    curResult = [NSMutableString stringWithString:@""];
    [_iFlySpeechRecognizer startListening];
}

- (void)pStopSpeaking:(UIButton *)btn {
    NSLog(@"stopSpeaking");
    [btn setTitle:@"按住说话" forState:UIControlStateNormal];
//    [_iFlySpeechRecognizer stopListening];
}


- (void)requestRobotDataWithInfo:(NSString *)strInfo {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[strInfo,app_key4] forKeys:@[@"info",@"key"]];
  
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:robot_api param:dic successed:^(NSDictionary *responseDic) {
        NSLog(@"success: %@",responseDic);
        if (![responseDic[@"error_code"] integerValue]) {
            NSDictionary *result = responseDic[@"result"];
            NSString *responseString = result[@"text"];
            _speechTextView.text = responseString;
            [weakself speakOut];
        }
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
