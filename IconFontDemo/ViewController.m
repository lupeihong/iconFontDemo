//
//  ViewController.m
//  IconFontDemo
//
//  Created by luph on 2018/11/23.
//  Copyright © 2018年 yy. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+YYIconFont.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    [self.view sendSubviewToBack:_scrollView];
    
//    UIFont *font = [self fontWithSize:20];
//    self.label.font = font;
    NSString *code = @"\U0000e6f5";
//    self.label.text = code;
    
//    self.imageview.image = [UIImage yy_iconWithText:code                                               fontSize:self.imageview.bounds.size.width color:[UIColor redColor]];


}

- (IBAction)test:(id)sender {
    NSDate *beginDate = [NSDate date];
    CGFloat size = 32;
    NSString *code = @"clock";
    for (int i=0; i < 1000; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * size, size, size)];
        UIColor *color = [UIColor colorWithRed:0.2 green:0.7 blue:0.3 alpha:1];
        
        imageView.image = [UIImage yy_iconWithText:code fontSize:imageView.bounds.size.width color:color];
//        imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"clock" ofType:@"png"]];
//        imageView.image = [UIImage imageNamed:@"clock"];
//        [self.view addSubview:imageView];
        
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, size*1000);
    NSTimeInterval timeCost = -[beginDate timeIntervalSinceNow];
    NSLog(@"Time Cost: %f Size: %@", timeCost, @(size));
}


@end
