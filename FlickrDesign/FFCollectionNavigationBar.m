//
//  FFCollectionNavigationBar.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCollectionNavigationBar.h"
#import "Masonry.h"

@implementation FFCollectionNavigationBar

-(instancetype) initWithFrame: (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.searchBar = [UISearchBar new];
        self.searchBar.barStyle = UISearchBarStyleMinimal;
        self.searchBar.placeholder = @"Поиск";
        self.searchBar.backgroundImage = [UIImage imageNamed:@"rectangle121"];
        [self.searchBar setSearchFieldBackgroundImage: [UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
        [self addSubview:self.searchBar];
        
        self.settingsButton = [UIButton new];
        [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"icSettings"] forState:UIControlStateNormal];
        [self addSubview:self.settingsButton];
        
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@29);
            make.top.equalTo(self.mas_top).with.offset(6);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-42);
        }];
        
        [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@24);
            make.width.equalTo(@24);
            make.top.equalTo(self.mas_top).with.offset(8);
            make.left.equalTo(self.searchBar.mas_right).with.offset(12);
        }];
    }
    return self;
}

-(UIView *) createNavigationBarForSearchBar {
    CGRect frame = self.frame;
    UIView *myNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 44)];
    
    self.searchBar = [UISearchBar new];
    self.searchBar.barStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"Поиск";
    self.searchBar.backgroundImage = [UIImage imageNamed:@"rectangle121"];
    [self.searchBar setSearchFieldBackgroundImage: [UIImage imageNamed:@"rectangle121"] forState:UIControlStateNormal];
    [myNavigationView addSubview:self.searchBar];
    
    self.settingsButton = [UIButton new];
    [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"icSettings"] forState:UIControlStateNormal];
    [myNavigationView addSubview:self.settingsButton];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@29);
        make.top.equalTo(myNavigationView.mas_top).with.offset(6);
        make.left.equalTo(myNavigationView.mas_left).with.offset(0);
        make.right.equalTo(myNavigationView.mas_right).with.offset(-42);
    }];
    
    [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.width.equalTo(@24);
        make.top.equalTo(myNavigationView.mas_top).with.offset(8);
        make.left.equalTo(self.searchBar.mas_right).with.offset(12);
    }];
    
    return myNavigationView;
}

@end
