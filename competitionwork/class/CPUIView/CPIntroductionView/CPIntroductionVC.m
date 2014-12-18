//
//  CPIntroductionVC.m
//  competitionwork
//
//  Created by hjj on 14-12-18.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPIntroductionVC.h"

@interface CPIntroductionVC ()
@property(nonatomic,strong) UIImageView *backImage;
@end

@implementation CPIntroductionVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backImage.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     _backImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _backImage.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_backImage];
    if (self.imageIndex == 3) {
        _backImage.image = [UIImage imageNamed:@"引导排名.jpg"];
    }else if(self.imageIndex == 4){
        _backImage.image = [UIImage imageNamed:@"引导发布.jpg"];

    }else if (self.imageIndex == 5){
        _backImage.image = [UIImage imageNamed:@"引导发布.jpg"];

    }
    // Do any additional setup after loading the view.
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
