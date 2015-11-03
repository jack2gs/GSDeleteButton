//
//  ViewController.m
//  GSDeleteButton
//
//  Created by Gao Song on 11/2/15.
//  Copyright © 2015 Gao Song. All rights reserved.
//

#import "ViewController.h"
#import "GSDeleteButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GSDeleteButton *button=[[GSDeleteButton alloc] initWithFrame:CGRectMake(100, 100, 21, 21)];
    
    button.backgroundColor=[UIColor lightGrayColor];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
