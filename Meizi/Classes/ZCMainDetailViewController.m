//
//  ZCMainDetailViewController.m
//  Meizi
//
//  Created by 朱立焜 on 16/1/10.
//  Copyright © 2016年 朱立焜. All rights reserved.
//

#import "ZCMainDetailViewController.h"
#import "NSString+ZCHtmlBodyString.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "ZCMoreDefines.h"

@interface ZCMainDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZCMainDetailViewController

- (NSMutableArray *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[NSMutableArray alloc] init];
    

    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getPicWithUrlString:self.contentUrl picNumber:60];
    });
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
        
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 500)];
    [image sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row]]];
    [cell addSubview:image];
        
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)getPicWithUrlString:(NSString *)urlString picNumber:(NSInteger)picNumber {
    
    NSString *str = @"";
    
    for (int i = 1; i < picNumber + 1; i++) {
        str = [NSString getHtmlBodyStringWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%d", urlString, i]]];
        if (![str isEqualToString:@""]) {
            NSArray *arr = [str getFeedBackArrayWithSubstringByRegular:@"[a-zA-z]+://[^\\s]*jpe?g"];
            NSString *string = [arr objectAtIndex:0];
//            NSLog(@"%@", string);
            [_dataSource addObject:string];
        }
    }
    
    [self.tableView reloadData];
    
    NSLog(@"%ld", _dataSource.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end