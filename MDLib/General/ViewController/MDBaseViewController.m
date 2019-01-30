//
//  MDBaseViewController.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDUtility.h"

@interface MDBaseViewController ()

@property (nonatomic, strong) NSMutableArray *pi_observers;

@end

@implementation MDBaseViewController

- (void)setupQueryData:(id)queryData {
    _pageQueryData = queryData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setupUIElements)]) {
        [self setupUIElements];
    }
    if ([self respondsToSelector:@selector(setupObservers)]) {
        [self setupObservers];
    }
    if ([self respondsToSelector:@selector(setupData)]) {
        [self setupData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MDUtility sharedInstance].currentTopViewController = self;
    if (self.navigationController) {
        [MDUtility sharedInstance].currentNavigationController = self.navigationController;
    }
}

- (void)onBackAction:(id)sender {
    if ([self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (id obs in self.pi_observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:obs];
    }
    self.pi_observers = nil;
}

- (NSMutableArray *)pi_observers {
    if (!_pi_observers) {
        _pi_observers = [[NSMutableArray alloc] init];
    }
    return _pi_observers;
}

- (void)pi_addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block {

    id obsObj = [[NSNotificationCenter defaultCenter] addObserverForName:name object:obj queue:queue usingBlock:block];

    if (obsObj) {
        [self.pi_observers addObject:obsObj];
    }
}

@end
