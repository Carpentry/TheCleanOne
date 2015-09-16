//
//  ARSegmentPageController.m
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARSegmentPageController.h"
#import "ARSegmentView.h"
#import "UIImageView+WebCache.h"
#import "ImageBean.h"
//#define  kImageCount 5

const void* _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;

@interface ARSegmentPageController ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger kImageCount;
@property (nonatomic, strong) ImageBean *imgBean;
@property (nonatomic, strong) NSArray *imgArr;

@property (nonatomic, strong) UIView<ARSegmentPageControllerHeaderProtocol> *headerView;


@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) ARSegmentView *segmentView;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) CGFloat segmentToInset;
@property (nonatomic, weak) UIViewController<ARSegmentControllerDelegate> *currentDisplayController;
@property (nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;

@end

@implementation ARSegmentPageController


#pragma mark - ScrollView懒加载
//- (UIScrollView *)headerScrollView
//{
//    
//    if (_headerScrollView == nil) {
//
//        _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150)];
//        [self.view addSubview:_headerScrollView];
//        _headerScrollView.pagingEnabled = YES;
//        _headerScrollView.clipsToBounds = YES;
//        _headerScrollView.bounces = NO;
//        _headerScrollView.delegate =self;
//        _headerScrollView.contentSize = CGSizeMake(_kImageCount * _headerScrollView.bounds.size.width, 0);
//        
//    }
//
//
//    return _headerScrollView;
//}
#pragma mark - UIPageControl懒加载
//- (UIPageControl *)pageControl
//{
//    if (_pageControl == nil) {
//        //加上进度点
//        _pageControl = [[UIPageControl alloc] init];
//        _pageControl.numberOfPages = _kImageCount;
//        //最适合的大小
//        CGSize size = [_pageControl sizeForNumberOfPages:_kImageCount];
//        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
//        _pageControl.center = CGPointMake(self.view.center.x, 130 + 64);
//        [self.view addSubview:_pageControl];
//        //添加监听方法
//        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _pageControl;
//}

#pragma mark - ScrollView的代理方法
//滚动视图停下来，修改页面控件的小点
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算页数
    int page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
}

- (void)pageChanged:(UIPageControl *)page
{
    CGFloat x = page.currentPage * self.headerScrollView.bounds.size.width;
    [self.headerScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}


#pragma mark - life cycle methods

-(instancetype)initWithControllers:(UIViewController<ARSegmentControllerDelegate> *)controller, ...
{
    self = [super init];
    if (self) {
        NSAssert(controller != nil, @"the first controller must not be nil!");
        [self _setUp];
        UIViewController<ARSegmentControllerDelegate> *eachController;
        va_list argumentList;
        if (controller)
        {
            [self.controllers addObject: controller];
            va_start(argumentList, controller);
            while ((eachController = va_arg(argumentList, id)))
            {
                [self.controllers addObject:eachController];
            }
            va_end(argumentList);
        }
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setUp];
    }
    return self;
}


//对 图的高度，分页栏 的尺寸进行设置
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本配置项
    [self _baseConfigs];
    //基本布局
    [self _baseLayout];

}


- (void)viewWillAppear:(BOOL)animated
{

    
    //画个scrollview，初始化
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150)];
    [self.view addSubview:_headerScrollView];
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.clipsToBounds = YES;
    _headerScrollView.bounces = NO;
    _headerScrollView.delegate =self;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.contentSize = CGSizeMake(_kImageCount * _headerScrollView.bounds.size.width, 0);
    
    
    
    //这是在头上又盖了一层 他妹的··
    //加上首部滚动视图
        for (int i = 0; i < _kImageCount; i++) {
        _imgBean = _imgArr[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.headerScrollView.bounds];
        [imageView sd_setImageWithURL:(NSURL *)_imgBean.uri placeholderImage:[UIImage imageNamed:@"icon"]];
        //imageView.image = image;
        
        [self.headerScrollView addSubview:imageView];
    }
    [self.headerScrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        imageView.frame = frame;
    }];
    
    
    
    //进度点初始化
    //加上进度点
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _kImageCount;
    //最适合的大小
    CGSize size = [_pageControl sizeForNumberOfPages:_kImageCount];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.view.center.x, 130 + 64);
    [self.view addSubview:_pageControl];
    //添加监听方法
    [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    self.pageControl.currentPage = 0;
}


#pragma mark - public methods
//将分页栏的控制器加入 控制器数组
-(void)setViewControllers:(NSArray *)viewControllers
{
    [self.controllers removeAllObjects];
    [self.controllers addObjectsFromArray:viewControllers];
}

#pragma mark - override methods
//自定义头部图像
-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView
{

    
    return [[ARSegmentPageHeader alloc] init];
}

#pragma mark - private methdos
//初始化设置
-(void)_setUp
{
    self.headerHeight = 150;
    self.segmentHeight = 44;
//    self.segmentToInset = 200;
//    self.segmentMiniTopInset = 0;
    self.controllers = [NSMutableArray array];
}

//基础设置
-(void)_baseConfigs
{

    //自适应滚动视图内嵌 关
    self.automaticallyAdjustsScrollViewInsets = NO;
    //保持父视图布局页边的空白
    if ([self.view respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.view.preservesSuperviewLayoutMargins = YES;   
    }
    
    //是否包含不透明的栏扩展布局
    //头视图
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.headerView = [self customHeaderView];
    self.headerView.clipsToBounds = YES;
    [self.view addSubview:self.headerView];
    
    //分页栏视图
    self.segmentView = [[ARSegmentView alloc] init];
    [self.segmentView.segmentControl addTarget:self action:@selector(segmentControlDidChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentView];
    
    //all segment title and controllers
    //分页的标题和控制器
    [self.controllers enumerateObjectsUsingBlock:^(UIViewController<ARSegmentControllerDelegate> *controller, NSUInteger idx, BOOL *stop) {
        NSString *title = [controller segmentTitle];
        
        [self.segmentView.segmentControl insertSegmentWithTitle:title
                                                        atIndex:idx
                                                       animated:NO];
    }];
    
    //defaut at index 0
    self.segmentView.segmentControl.selectedSegmentIndex = 0;
    UIViewController<ARSegmentControllerDelegate> *controller = self.controllers[0];
    //移动到父视图
    [controller willMoveToParentViewController:self];
    //插入子视图
    [self.view insertSubview:controller.view atIndex:0];
    //添加子视图
    [self addChildViewController:controller];
    //移动到了父视图
    [controller didMoveToParentViewController:self];
    
    
    //布局控制器
    [self _layoutControllerWithController:controller];
    //给页面控制器添加观察者
//    [self addObserverForPageController:controller];
    
    self.currentDisplayController = self.controllers[0];
    
    
//    NSLog(@"#####################################");
//    //这是在头上又盖了一层 他妹的··
//    //加上首部滚动视图
//    for (int i = 0; i < _kImageCount; i++) {
//        
//        
//        //NSString *imageName = [NSString stringWithFormat:@"Assassin%d.jpg",i+1];
//        //UIImage *image = [UIImage imageNamed:imageName];
//        
//        _imgBean = _imgArr[i];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.headerScrollView.bounds];
//        [imageView sd_setImageWithURL:(NSURL *)_imgBean.uri placeholderImage:[UIImage imageNamed:@"icon"]];
//        //imageView.image = image;
//        
//        [self.headerScrollView addSubview:imageView];
//    }
//    [self.headerScrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
//        
//        CGRect frame = imageView.frame;
//        frame.origin.x = idx * frame.size.width;
//        imageView.frame = frame;
//    }];
//
//    
//    self.pageControl.currentPage = 0;
}


//基础布局
-(void)_baseLayout
{
    
//    self.headerScrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerHeight];
//    [self.headerScrollView addConstraint:self.headerHeightConstraint];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerScrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerScrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    
    
    
    //header 头
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerHeight];
    [self.headerView addConstraint:self.headerHeightConstraint];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    //segment 分页栏
    self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.segmentHeight]];
}


//布局控制器
-(void)_layoutControllerWithController:(UIViewController<ARSegmentControllerDelegate> *)pageController
{
    UIView *pageView = pageController.view;
    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
//    UIScrollView *scrollView = [self scrollViewInPageController:pageController];
//    if (scrollView) {
/*准备删除
        //        scrollView.alwaysBounceVertical = YES;
//        CGFloat topInset = self.headerHeight+self.segmentHeight;
//        //fixed bootom tabbar inset
//        CGFloat bottomInset = 0;
//        if (self.tabBarController.tabBar.hidden == NO) {
//            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
//        }
//        
//        [scrollView setContentInset:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
*/
        //fixed first time don't show header view
//        [scrollView setContentOffset:CGPointMake(0, -self.headerHeight-self.segmentHeight)];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:258]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//    }else{
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.segmentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:-self.segmentHeight]];
//    }
    
}

//-(UIScrollView *)scrollViewInPageController:(UIViewController <ARSegmentControllerDelegate> *)controller
//{
//    if ([controller respondsToSelector:@selector(streachScrollView)]) {
//        return [controller streachScrollView];
//    }else if ([controller.view isKindOfClass:[UIScrollView class]]){
//        return (UIScrollView *)controller.view;
//    }else{
//        return nil;
//    }
//}

#pragma mark - add / remove obsever for page scrollView
//
//-(void)addObserverForPageController:(UIViewController <ARSegmentControllerDelegate> *)controller
//{
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (scrollView != nil) {
//        [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET];
//    }
//}
//
//-(void)removeObseverForPageController:(UIViewController <ARSegmentControllerDelegate> *)controller
//{
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (scrollView != nil) {
//        @try {
//        [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"exception is %@",exception);
//        }
//        @finally {
//                
//        }
//    }
//}

#pragma mark - obsever delegate methods

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (context == _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET) {
//        NSLog(@"offset: %@\nheader: %f\nmini inset = %f", change, self.headerHeightConstraint.constant, self.segmentToInset);
//        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
//        CGFloat offsetY = offset.y;
//        CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
//        CGFloat oldOffsetY = oldOffset.y;
//        CGFloat deltaOfOffsetY = offset.y - oldOffsetY;
//        CGFloat offsetYWithSegment = offset.y + self.segmentHeight;
//        
//        if (deltaOfOffsetY > 0) {
//            // 当滑动是向上滑动时
//            // 跟随移动的偏移量进行变化
//            // NOTE:直接相减有可能constant会变成负数，进而被系统强行移除，导致header悬停的位置错乱或者crash
//            if (self.headerHeightConstraint.constant - deltaOfOffsetY <= 0) {
//                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
//            } else {
//                self.headerHeightConstraint.constant -= deltaOfOffsetY;
//            }
//            // 如果到达顶部固定区域，那么不继续滑动
//            if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
//                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
//            }
//        } else {
//            // 当向下滑动时
//            // 如果列表已经滚动到屏幕上方
//            // 那么保持顶部栏在顶部
//            if (offsetY > 0) {
//                if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
//                    self.headerHeightConstraint.constant = self.segmentMiniTopInset;
//                }
//            } else {
//                // 如果列表顶部已经进入屏幕
//                // 如果顶部栏已经到达底部
//                if (self.headerHeightConstraint.constant >= self.headerHeight) {
//                    // 如果当前列表滚到了顶部栏的底部
//                    // 那么顶部栏继续跟随变大，否这保持不变
//                    if (-offsetYWithSegment > self.headerHeight) {
//                        self.headerHeightConstraint.constant = -offsetYWithSegment;
//                    } else {
//                        self.headerHeightConstraint.constant = self.headerHeight;
//                    }
//                } else {
//                    // 在顶部拦未到达底部的情况下
//                    // 如果列表还没滚动到顶部栏底部，那么什么都不做
//                    // 如果已经到达顶部栏底部，那么顶部栏跟随滚动
//                    if (self.headerHeightConstraint.constant < -offsetYWithSegment) {
//                        self.headerHeightConstraint.constant -= deltaOfOffsetY;
//                    }
//                }
//            }
//        }
//        // 更新 `segmentToInset` 变量，让外部的 kvo 知道顶部栏位置的变化
//        self.segmentToInset = self.headerHeightConstraint.constant;
//    }
//}

#pragma mark - event methods
//分页栏切换的动作
-(void)segmentControlDidChangedValue:(UISegmentedControl *)sender
{
    //remove obsever 删除观察者控制器
//    [self removeObseverForPageController:self.currentDisplayController];
    
    //add new controller 添加新的控制器
    NSUInteger index = [sender selectedSegmentIndex];
    UIViewController<ARSegmentControllerDelegate> *controller = self.controllers[index];
    
    
    [self.currentDisplayController willMoveToParentViewController:nil];
    [self.currentDisplayController.view removeFromSuperview];
    [self.currentDisplayController removeFromParentViewController];
    [self.currentDisplayController didMoveToParentViewController:nil];
    
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    // reset current controller 重置当前控制器
    self.currentDisplayController = controller;
    //layout new controller 布局新的控制器
    [self _layoutControllerWithController:controller];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
/*准备删除
 
 //trigger to fixed header constraint
//    UIScrollView *scrollView = [self scrollViewInPageController:controller];
//    if (self.headerHeightConstraint.constant != self.headerHeight) {
//        if (scrollView.contentOffset.y >= -(self.segmentHeight + self.headerHeight) && scrollView.contentOffset.y <= -self.segmentHeight) {
//            [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight - self.headerHeightConstraint.constant)];
//        }
//    }*/
    
    //add obsever  加了个观察者
//    [self addObserverForPageController:self.currentDisplayController];
}



#pragma mark --ProjectIntroDelegate
- (void)projectDetailInfo:(ProjectInfo *)projectInfo andImages:(NSArray *)imgArr
{
    _imgBean = [[ImageBean alloc] init];
    _kImageCount = imgArr.count;
    _imgArr = imgArr;
    
}

@end
