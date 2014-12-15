//
//  CPAboutVC.m
//  competitionwork
//
//  Created by hjj on 14-12-15.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPAboutVC.h"
#import "CPUtil.h"
#import "GJCommonWidgetHelper.h"

@interface CPAboutVC ()

@property(nonatomic,retain) UITableView * tableView ;
@property (nonatomic,retain) UIActivityIndicatorView *loadingView;

@end

@implementation CPAboutVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBackColor;
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 186, 20, 20)];

}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    }
    return _tableView;
}

-(void)creatTheUIView{
    
    UIImageView * titleBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 135)];
    titleBackImage.backgroundColor = [UIColor whiteColor];
    
    UIImageView * LogoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 184, 40)];
    [titleBackImage addSubview:LogoView];
    LogoView.image = [UIImage imageNamed:@"环球竞赛网"];
    [[LogoView.po_frameBuilder alignToTopInSuperviewWithInset:40]centerHorizontallyInSuperview];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"专注于竞赛的社交网站";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor orangeColor];
    [titleLabel sizeToFit];
    [titleBackImage addSubview:titleLabel];
    [[titleLabel.po_frameBuilder alignToBottomOfView:LogoView offset:20]centerHorizontallyInSuperview];
    
    [self.view addSubview:titleBackImage];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"AboutCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = RGBCOLOR(229, 229, 229);
    cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    UILabel* keyLabel =  [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 57,cell.frame.size.height)];
    keyLabel.font = [UIFont systemFontOfSize:14];
    keyLabel.textColor = RGBCOLOR(153, 153, 153);
    keyLabel.backgroundColor = [UIColor clearColor];
    
    UILabel* valueLabel =  [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 180, cell.frame.size.height)];
    valueLabel.font = [UIFont systemFontOfSize:14];
    valueLabel.textColor = RGBCOLOR(38, 38, 38);;
    valueLabel.backgroundColor = [UIColor clearColor];
    
    [cell addSubview:keyLabel];
    [cell addSubview:valueLabel];
    keyLabel.hidden = YES;
    valueLabel.hidden = YES;
    
    UIImage *grayArrow = [CPUtil getRightGrayArrowImage];
    UIImageView *pointView = [[UIImageView alloc] initWithImage:grayArrow];
    [cell addSubview:pointView];
    [[[pointView.po_frameBuilder setX:MainScreenWidth - 13] setWidth:grayArrow.size.width] setHeight:grayArrow.size.height];
    [pointView.po_frameBuilder centerVerticallyInSuperview];
    pointView.hidden = YES;
    
    UIView *downBorder = [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
    [cell addSubview:downBorder];
    [downBorder.po_frameBuilder setWidth:MainScreenWidth];
    [downBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0];
    if (indexPath.section == 0) {
        UIImage *image = [UIImage imageNamed:@"环球竞赛网"];
        UIImageView *lvImageView = [[UIImageView alloc] initWithImage:image];
        [cell addSubview:lvImageView];
        lvImageView.tag = 1115;
        [[[[lvImageView.po_frameBuilder setWidth:184] setHeight:40] alignToTopInSuperviewWithInset:40]centerHorizontallyInSuperview];
        lvImageView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [downBorder.po_frameBuilder alignToBottomInSuperviewWithInset:0];
        downBorder.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    else if (indexPath.section == 1){
        keyLabel.hidden = NO;
        valueLabel.hidden = NO;
        [[downBorder.po_frameBuilder setWidth:MainScreenWidth-13] alignLeftInSuperviewWithInset:13];
        
        if (indexPath.row == 0) {
            UIView *upBorder =   [[GJCommonWidgetHelper sharedGJCommonWidgetHelper] createNormalBorderView];
            [cell addSubview:upBorder];
            [upBorder.po_frameBuilder alignToTopInSuperviewWithInset:0];
            
            keyLabel.text = @"软件版本";
            valueLabel.text = @"1.0.0";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 1){
//            pointView.hidden = NO;
            keyLabel.text = @"地址访问" ;
            valueLabel.text = @"www.worldjingsai.com";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 2){
            keyLabel.text = @"关注QQ";
            valueLabel.text = @"2228968703";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 3){
            keyLabel.text = @"微       信" ;
            valueLabel.text = @"worldjingsai";
//            pointView.hidden = NO;
            [[downBorder.po_frameBuilder setWidth:MainScreenWidth] alignLeftInSuperviewWithInset:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 135;
    }
    else if (indexPath.section == 1){
        return 44;
    }
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
//    NSInteger heightOffset = IOS7?64:20;
    if (indexPath.section == 1 && indexPath.row == 1) {
        UIWebView *ganjiweb = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, MainScreenWidth, MainScreenHeight)];
        
        ganjiweb.tag = 9349;
        [self.loadingView setFrame:CGRectMake(150, 186, 20, 20)];
        NSString *url = @"http://www.worldjingsai.com";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [ganjiweb loadRequest:request];
        [ganjiweb setDelegate:self];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        animation.removedOnCompletion = YES;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        
        [self.view addSubview:ganjiweb];
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        UIWebView *weiBoweb = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, MainScreenWidth, MainScreenHeight)];
        weiBoweb.tag = 9249;
        [self.loadingView setFrame:CGRectMake(150, 186, 20, 20)];
        
        NSString *url = @"";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [weiBoweb loadRequest:request];
        [weiBoweb setDelegate:self];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        
        [self.view addSubview:weiBoweb];
        [self.view.layer addAnimation:animation forKey:@"animation"];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0;
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView{
    UIView *blackLoading = [self.view viewWithTag:3478];
    if (!blackLoading) {
        UIView *blackLoading = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        blackLoading.backgroundColor = [UIColor blackColor];
        blackLoading.alpha = 0.6;
        blackLoading.tag = 3478;
        [blackLoading addSubview:self.loadingView];
        [self.view addSubview:blackLoading];
    }
    
    [self.loadingView startAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL* url = [request URL];
    NSString* str = [url absoluteString];
    
    if ([str rangeOfString:@"itms-apps"].length > 0)
    {
        [[UIApplication sharedApplication] openURL:url];
        return NO;
    }
    
    return YES;
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[self.view viewWithTag:3478] removeFromSuperview];
    [self.loadingView stopAnimating];
    [CPSystemUtil showAlertViewWithAlertString:@""];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[self.view viewWithTag:3478] removeFromSuperview];
    [self.loadingView stopAnimating];
}


#pragma mark -
#pragma mark Memory management




- (void)dealloc {

}

- (IBAction)returnPressed:(id)sender {
    UIWebView *weiBoweb = (UIWebView *)[self.view viewWithTag:9249];
    UIWebView *ganjiBowb = (UIWebView *)[self.view viewWithTag:9349];
    int tag;
    if (weiBoweb || ganjiBowb) {
        if (weiBoweb) {
            tag = 9249;
        }
        else {
            tag = 9349;
        }
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        
        [self.view.layer addAnimation:animation forKey:@"animation"];
        [self performSelector:@selector(removeWebView:) withObject:[NSNumber numberWithInt:tag] afterDelay:0.2];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)removeWebView:(NSNumber *)number {
    [[self.view viewWithTag:[number intValue]] removeFromSuperview];
    [[self.view viewWithTag:3478] removeFromSuperview];
    [self.loadingView stopAnimating];
}


-(void)OpenAppURL:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)gotoItunes:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //708
    NSString* customIdAssist = @"708";
    NSArray* paras = [NSArray arrayWithObject:customIdAssist];
    NSString *appUrl = @"";
//    if (btn.tag == LanRenZhaoFangBtnTag) {
//        appUrl = @"";//@"https://itunes.apple.com/cn/app/gan-ji-lan-ren-zhao-fang-zu/id717596972?mt=8";
//    }
//    else{
//        appUrl = @"";//@"https://itunes.apple.com/cn/app/ju-jia-bi-bei-bao-jie-yue/id794916120?mt=8";
//    }
    [self performSelector:@selector(OpenAppURL:) withObject:appUrl];
}

-(IBAction)callUs
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telNum_Value]]];
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
