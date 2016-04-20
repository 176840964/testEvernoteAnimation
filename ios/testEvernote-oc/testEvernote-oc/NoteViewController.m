//
//  NoteViewController.m
//  testEvernote-oc
//
//  Created by Dragonet on 16/4/21.
//  Copyright © 2016年 zhongqinglongtu. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.totalView.layer.masksToBounds = YES;
    self.totalView.layer.cornerRadius = 5.0;
    self.totalView.backgroundColor = self.domainColor;
    self.titleLabel.text = self.titleName;
    self.textView.contentOffset = CGPointZero;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.totalView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 
- (void)handleTapGesture:(UITapGestureRecognizer*)gesture {
    [self.view endEditing:YES];
}

- (IBAction)goback:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickGoBack)]) {
        [self.delegate didClickGoBack];
    }
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
