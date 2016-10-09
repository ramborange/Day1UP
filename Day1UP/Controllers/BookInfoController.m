//
//  BookInfoController.m
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "BookInfoController.h"
#import "WebviewController.h"
@interface BookInfoController ()<TTTAttributedLabelDelegate>
{

}
@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *tagsLabel;

@property (nonatomic, strong) TTTAttributedLabel *sub2Label;
@property (nonatomic, strong) TTTAttributedLabel *onlineLabel;

@property (nonatomic, strong) UILabel *bytimeLabel;

@end

@implementation BookInfoController
-(void)dealloc {
    [_scrollview removeFromSuperview];
    _scrollview = nil;
    _titleLabel = nil;
    _imageview = nil;
    _tagsLabel = nil;
    _sub2Label = nil;
    _onlineLabel = nil;
    _bytimeLabel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Book Detail";
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollview.showsVerticalScrollIndicator = NO;
    [self.scrollview setContentSize:CGSizeMake(self.view.bounds.size.width, 1200)];
    [self.view addSubview:self.scrollview];
    
    self.imageview = [[UIImageView alloc] init];
    [self.imageview setContentMode:UIViewContentModeScaleAspectFit];
    [self.scrollview addSubview:self.imageview];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:20];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollview addSubview:self.titleLabel];
    
    self.tagsLabel = [[UILabel alloc] init];
    self.tagsLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:13];
    self.tagsLabel.textColor = [UIColor lightGrayColor];
    self.tagsLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollview addSubview:self.tagsLabel];
    
    self.sub2Label = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.sub2Label.numberOfLines = 0;
//    self.sub2Label.backgroundColor = [UIColor lightGrayColor];
    [self.scrollview addSubview:self.sub2Label];
    
    self.onlineLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.onlineLabel.delegate = self;
    self.onlineLabel.numberOfLines = 0;
    self.onlineLabel.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes;
    self.onlineLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self.scrollview addSubview:self.onlineLabel];
    
    self.bytimeLabel = [[UILabel alloc] init];
    self.bytimeLabel.textColor = [UIColor brownColor];
    self.bytimeLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    [self.scrollview addSubview:self.bytimeLabel];
    
    [self reloadData];
}

#pragma mark - TTTAttributedLabel Delegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
//    NSLog(@"url:%@",url);
    WebviewController *vc = [[WebviewController alloc] init];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark- end

- (void)reloadFrame {
    UIScrollView *view = self.scrollview;
    float sub2Height = [TTTAttributedLabel sizeThatFitsAttributedString:_sub2Label.attributedText withConstraints:CGSizeMake(self.view.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0].height;
    float onlineHeight = [TTTAttributedLabel sizeThatFitsAttributedString:_onlineLabel.attributedText withConstraints:CGSizeMake(self.view.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0].height;
    [view setContentSize:CGSizeMake(self.view.bounds.size.width, (260+sub2Height+10+onlineHeight+20+20)+20)];
    
    _imageview.sd_layout
    .topSpaceToView(view,20)
    .centerXEqualToView(view)
    .heightIs(160.0)
    .widthIs(160.0);
    
    _titleLabel.sd_layout
    .topSpaceToView(_imageview,20)
    .widthRatioToView(view,1.0)
    .heightIs(20.0);
    
    _tagsLabel.sd_layout
    .topSpaceToView(_titleLabel,5)
    .widthRatioToView(view,1.0)
    .heightIs(20.0);
    
    _sub2Label.sd_layout
    .topSpaceToView(_tagsLabel,20)
    .leftSpaceToView(view,10)
    .rightSpaceToView(view,10)
    .heightIs(sub2Height);
    [_sub2Label sizeToFit];
    
    _onlineLabel.sd_layout
    .topSpaceToView(_sub2Label,20)
    .leftSpaceToView(view,10)
    .rightSpaceToView(view,10)
    .heightIs(onlineHeight);
    
    _bytimeLabel.sd_layout
    .topSpaceToView(_onlineLabel,10)
    .rightSpaceToView(view,20)
    .leftSpaceToView(view,20)
    .heightIs(20.0);
    
}

- (NSString *)adjustString:(NSString *)str {
    NSArray *strArray = [str componentsSeparatedByString:@" "];
    NSMutableString *string = [NSMutableString stringWithCapacity:strArray.count];
    for (NSString *str in strArray) {
        if (str!=nil&&![str isEqualToString:@""]) {
            [string appendString:[NSString stringWithFormat:@"%@\n",str]];
        }
    }
    return [NSString stringWithString:string];
}

- (void)reloadData {
    self.titleLabel.text = self.currentBookInfo.title;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:self.currentBookInfo.img] placeholderImage:[UIImage imageNamed:@"book_default.png"]];
    self.tagsLabel.text = self.currentBookInfo.tags;
    
    NSMutableAttributedString *sub2As = [[NSMutableAttributedString alloc] initWithString:self.currentBookInfo.sub2];
    NSMutableParagraphStyle *sub2Parag = [[NSMutableParagraphStyle alloc] init];
    [sub2Parag setLineSpacing:5.0];
    [sub2Parag setParagraphSpacing:5.0];
    [sub2As addAttribute:NSParagraphStyleAttributeName value:sub2Parag range:NSMakeRange(0, [self.currentBookInfo.sub2 length])];
    [sub2As addAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:15]} range:NSMakeRange(0, [self.currentBookInfo.sub2 length])];
    [self.sub2Label setAttributedText:sub2As];
    
    NSMutableAttributedString *onlineAs = [[NSMutableAttributedString alloc] initWithString:[self adjustString:self.currentBookInfo.online]];
    NSMutableParagraphStyle *onlineParag = [[NSMutableParagraphStyle alloc] init];
    [onlineParag setLineSpacing:2.0];
    [onlineParag setParagraphSpacing:4.0];
    [onlineAs addAttribute:NSParagraphStyleAttributeName value:onlineParag range:NSMakeRange(0, [self.currentBookInfo.online length])];
    [onlineAs addAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:15]} range:NSMakeRange(0, [[self adjustString:self.currentBookInfo.online] length])];
    [self.onlineLabel setText:[self adjustString:self.currentBookInfo.online]];
    [self.onlineLabel setAttributedText:onlineAs];
    
    self.bytimeLabel.text = [NSString stringWithFormat:@"上架日期：%@",self.currentBookInfo.bytime];
    
    [self reloadFrame];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self reloadData];
//}

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
