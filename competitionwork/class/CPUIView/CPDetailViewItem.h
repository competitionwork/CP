//
//  CPDetailViewItem.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GJPostDetailNoParamBlock)(void) ;
typedef void (^GJPostDetailStringParamBlock)(NSString *str);

@interface CPDetailViewItem : UIView

@end
/**
 *  二手headerview
 */
@interface GJPostDetailHeaderView : UIView
@property NSString* puid;

- (instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc;

@end

/**
 *  二手车headerview
 */
@interface GJPostDetailHeader1View : UIView

- (instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc userWifi:(BOOL)useWifi;

@end



/**
 *  二手属性view的headerview
 */
@interface GJPostDetailAttrHeaderView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict referBlock:(GJPostDetailNoParamBlock)referBlock;

@end

/**
 *  服务headerview
 */

@interface GJPostDetailFuwuHeaderView : UIButton

-(instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc;

@end

/**
 *  二手房属性view的headerview
 */
@interface GJPostDetailAttrHeaderView1 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict loanBlock:(GJPostDetailNoParamBlock)loanBlock;

@end



/**
 *  属性view的headerview，无参数版
 */
@interface GJPostDetailAttrHeaderView2 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  宠物属性view的header视图
 */
@interface GJPostDetailAttrHeaderView3 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  票务属性view的header视图
 */
@interface GJPostDetailAttrHeaderView4 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  小区属性view的header视图
 */
@interface GJPostDetailAttrHeaderView5 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end


/**
 *  薪资带有区间的view
 */

@interface GJPostDetailAttrHeaderView6 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  二手属性view，分列版
 */
@interface GJPostDetailAttrsView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  详细信息view调用需要实现的代理方法
 */
@protocol GJPostDetailContentDelegate <NSObject>

- (void)showAllAttrContent;

@end

/**
 *  5.1.0出租房配置视图
 */
@interface GJPostDetailAttrsView1 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

@interface GJPostDetailContentView : UIView

@property (nonatomic,readonly) float fullHeight;
/**
 *  构建详细信息view
 *
 *  @param strContent 详细信息
 *  @param isShow     是否展示全部
 *  @param showBlock     展开全部按钮对应事件的block
 *
 *  @return 视图
 */
- (instancetype)initWithData:(NSMutableDictionary *)dataDict isShow:(BOOL)isShow showBlock:(GJPostDetailNoParamBlock)showBlock;
@end

typedef void(^GJPostDetailDictBlock)(NSDictionary *data);
/**
 *  写字楼名称
 */
@interface GJPostDetailOfficeNameView : UIView

- (instancetype)initWithData:(NSString *)nameString;

@end

/**
 *  地址view
 */
@interface GJPostDetailAddressView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict mapBlock:(GJPostDetailDictBlock)mapBlock;

@end

/**
 *  服务属性view的可点击的headerView
 */

@interface GJPostDetailAttrFuwuHeaderView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict selectBlock:(GJPostDetailDictBlock)selectBlock;


@end

/**
 *  可选择的cellview，详见5.1.0版本的二手房小区cell
 */
@interface GJPostDetailAttrCellView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict selectBlock:(GJPostDetailDictBlock)selectBlock;

@end



/**
 *  可选择的cellview，详见5.1.0版本的二手房发布cell
 */
@interface GJPostDetailNoTitleCellView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict selectBlock:(GJPostDetailDictBlock)selectBlock;

@end

/**
 *  二手房，房价走势view
 */
@interface GJPostDetailAttrHousePriceView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  服务内容view
 */

@interface GJPostContentlFuwuView : UIView

-(instancetype)initWithData:(NSMutableDictionary *)dataDict callBlock:(GJPostDetailNoParamBlock)callBlock messageBlock:(GJPostDetailNoParamBlock)messageBlock;

@end

/**
 *  服务公司大图+图片view
 */

@interface GJPostCompanyFuwuContentView : UIView

- (instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc;

@end

@interface GJPostDetailContactView : UIView<UIAlertViewDelegate>
@property (nonatomic,retain)NSString* userid;
@property (nonatomic,retain)NSString* phoneNumber;
@property (nonatomic,assign)BOOL showPhoneText;
@property (nonatomic, strong)UILabel * nameLabel;
//绘制联系人等 的view
- (instancetype)initWithData:(NSMutableDictionary *)dataDict copyBlock:(GJPostDetailStringParamBlock)copyBlock callBlock:(GJPostDetailNoParamBlock)callBlock messageBlock:(GJPostDetailNoParamBlock)messageBlock;

-(void) checkPhone:(id) sender;

//二手车要在联系人上面增加店铺 字段 by whm 14-09-05
- (instancetype)initWithData:(NSMutableDictionary *)dataDict copyBlock:(GJPostDetailStringParamBlock)copyBlock callBlock:(GJPostDetailNoParamBlock)callBlock messageBlock:(GJPostDetailNoParamBlock)messageBlock shopBlock:(GJPostDetailStringParamBlock)shopBlock;


@end

/**
 *  普通分享view
 */
@interface GJPostDetailShareView : UIView

- (instancetype)initWithBlock:(GJPostDetailNoParamBlock)block;

@end

/**
 *  节日特殊分享view
 */
@interface GJPostDetailShareView1 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict selectblock:(GJPostDetailNoParamBlock)selectblock imageBlock:(GJPostDetailNoParamBlock)imageBlock;

@end

typedef void(^GJPostDetailRecSeletBlock)(int puid,NSString * d_sign);
/**
 *  推荐视图
 */
@interface GJPostDetailRecView : UIView<UITableViewDataSource,UITableViewDelegate>

- (instancetype)initWithData:(NSMutableDictionary *)dataDict otherBlock:(GJPostDetailNoParamBlock)otherBlock selectBlock:(GJPostDetailRecSeletBlock)selectBlock ;
- (void)loadImage;
@end

/**
 *  定向推荐视图
 */

@interface GJPostDetailDirectionalView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict otherBlock:(GJPostDetailStringParamBlock)otherBlock selectBlock:(GJPostDetailRecSeletBlock)selectBlock ;
@end


/**
 *  显示更多view
 */

@interface GJPostShowmoreLabelView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict isShowMore:(BOOL)showMore callBlock:(GJPostDetailNoParamBlock)callBlock;

@end

@interface GJPostDetailLvTipView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict reportBlock:(GJPostDetailNoParamBlock)block;

@end

/**
 *  运营视图 纯文字版本
 */
@interface GJPostDetailBusiness : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict otherBlock:(GJPostDetailNoParamBlock)otherBlock;

@end

/**
 *  运营视图 大图版本
 */
@interface GJPostDetailBusiness1 : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict otherBlock:(GJPostDetailNoParamBlock)otherBlock;

@end

/**
 *  报价view
 */

@interface GJPostBaojiaView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end


@interface GJHaoPingView : UIView

-(instancetype)initWithData:(NSMutableDictionary *)dataDict callBlock:(GJPostDetailNoParamBlock)callBlock;

@end



/**
 *  服务商家推荐
 */

typedef void(^GJPostDetailTwoParamsBlock)(NSDictionary *dataDic, NSInteger index, NSString* puid,NSString *dsign);


@interface GJPostDirectionView : UIView

- (instancetype) initwithData:(NSArray *)dataArr callBlock:(GJPostDetailTwoParamsBlock)callBlock;

@end

//==========================================================================================================

/**
 *  可选择的小区详情页cellview，
 */
@interface GJXiaoquDetailAttrCellView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict selectBlock:(GJPostDetailDictBlock)selectBlock;

@end

/**
 *  小区headerview
 */
@interface GJXiaoquDetailHeaderView : UIView

- (instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc;

@end
/**
 *  小区headerview
 */
@interface GJXiaoquAttrsView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  小区关注推荐视图
 */
typedef void(^GJXiaoquRecSeletBlock)(NSDictionary * xiaoquDict);

@interface GJXiaoquRecView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict otherBlock:(GJPostDetailNoParamBlock)otherBlock selectBlock:(GJXiaoquRecSeletBlock)selectBlock ;
- (void)loadImage;
@end

@interface GJXiaoquContentView : UIView

@property (nonatomic,readonly) float fullHeight;
/**
 *  构建详细信息view
 *
 *  @param strContent 详细信息
 *  @param isShow     是否展示全部
 *  @param showBlock     展开全部按钮对应事件的block
 *
 *  @return 视图
 */
- (instancetype)initWithData:(NSMutableDictionary *)dataDict isShow:(BOOL)isShow showBlock:(GJPostDetailNoParamBlock)showBlock;
@end

/**
 *  小区其他属性view，分列版
 */
@interface GJXiaoquDetailAttrsView : UIView

- (instancetype)initWithData:(NSMutableDictionary *)dataDict;

@end

/**
 *  小区关注推荐视图无图模式
 */

// 更多高薪急招block
typedef void (^GJXiaoquRecViewBlock)(void);
// cell 点击
typedef void (^GJXiaoquRecViewCellBlock)(NSDictionary *cellContent,NSInteger index);
typedef void (^GJXiaoquRecViewCellClickBlock)(NSDictionary *cellContent);
@interface GJXiaoquRecViewNoImage : UIView

- (id)initWithContent:(NSDictionary *)content withMoreHighSalary:(GJXiaoquRecViewBlock)aBlock withCellBlock:(GJXiaoquRecViewCellBlock)aCellBlock;

+ (CGFloat)heightForView:(NSDictionary *)content;

@end

//************************************* Cell
@interface GJXiaoquRecViewNoImageCell : UIView

@property (nonatomic, copy) GJXiaoquRecViewCellClickBlock cellClickBlock;

- (id)initWithCellInfo:(NSDictionary *)cellInfo;

+ (CGFloat)heightForCell;
@end
