//
//  ViewController.m
//  ZQLTopSegmentController
//
//  Created by 臧其龙 on 15/12/20.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "ZQLTopSegmentViewController.h"

@interface ViewController ()
{
    ZQLTopSegmentViewController *vc;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray = @[[UIImage imageNamed:@"icon1"], [UIImage imageNamed:@"icon2"], [UIImage imageNamed:@"icon3"], [UIImage imageNamed:@"icon4"]];
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor grayColor];
    
    vc = [[ZQLTopSegmentViewController alloc] initWithTopIcons:imageArray WithViewController:@[vc1, vc2, vc3, vc4]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonDidClick:(id)sender
{
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
