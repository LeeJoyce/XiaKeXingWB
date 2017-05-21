//
//  XiaKeTabBar.m
//  XiaKeXing
//
//  Created by JOY on 17/5/19.
//  Copyright © 2017年 JOY. All rights reserved.
//

#import "XiaKeTabBar.h"
#import "XiaKeNav.h"
#import "XiaKeUserVC.h"
#import "XiaKeScenicVC.h"
#import "XiaKeMainPage.h"
#import "XiaKeReleaseVC.h"
#import "SearchResultController.h"

@interface XiaKeTabBar ()

@end

@implementation XiaKeTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildNav];
    [self setUpFont];
    self.selectedIndex = 0;
    self.tabBar.barTintColor =[UIColor whiteColor];
}

- (void)addChildNav {
    [self setUpOneChildVC:[[XiaKeNav alloc] initWithRootViewController:[[XiaKeMainPage alloc] init]] title:@"首页" imageName:@"main" selImageName:@"main_sel"];
    [self setUpOneChildVC:[[XiaKeNav alloc] initWithRootViewController:[[XiaKeScenicVC alloc] init]] title:@"景点" imageName:@"place" selImageName:@"place_sel"];
    [self setUpOneChildVC:[[XiaKeNav alloc] initWithRootViewController:[[XiaKeReleaseVC alloc] init]] title:@"发布" imageName:@"sent" selImageName:@"sent_sel"];
    [self setUpOneChildVC:[[XiaKeNav alloc] initWithRootViewController:[[XiaKeUserVC alloc] init]] title:@"我的" imageName:@"mine" selImageName:@"mine_sel"];
}

- (void)setUpOneChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName {
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    if (VC) {
        [self addChildViewController:VC];
    }
}

- (void)setUpFont {
    NSMutableDictionary *normalA = [NSMutableDictionary dictionary];
    normalA [NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalA [NSForegroundColorAttributeName] = ZYGray(94);
    
    NSMutableDictionary *selA = [NSMutableDictionary dictionary];
    selA [NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selA [NSForegroundColorAttributeName] = WBMainColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalA forState:UIControlStateNormal];
    [item setTitleTextAttributes:selA forState:UIControlStateSelected];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    NSLog(@"%@", item.title);
//    
//    if ([item.title isEqualToString:@"发布"]) {
//        XiaKeReleaseVC *release = [XiaKeReleaseVC new];
//        release.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self presentViewController:release animated:YES completion:nil];
//    }
}
@end
