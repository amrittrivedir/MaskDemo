//
//  ViewController.m
//  MaskDemo
//
//  Created by Amrit on 05/09/16.
//  Copyright © 2016 Amrit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CAShapeLayer *circle = [CAShapeLayer layer];
//    // Make a circular shape
//    UIBezierPath *circularPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
//    
//    circle.path = circularPath.CGPath;
//    
//    // Configure the apperence of the circle
//    circle.fillColor = [UIColor blackColor].CGColor;
//    circle.strokeColor = [UIColor blackColor].CGColor;
//    circle.lineWidth = 0;
    
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(100,300,100 ,100);
    
    self.circleView.layer.cornerRadius = 50;
    
    self.topImageView.layer.mask=self.circleView.layer;
    
    UIPanGestureRecognizer * pan1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveObject:)];
    pan1.minimumNumberOfTouches = 1;
    [self.circleView addGestureRecognizer:pan1];
    
    
}

- (UIImage*)maskedImage:(UIImage*)maskImage toImage:(UIImage*)image
{
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImage.CGImage),
                                        CGImageGetHeight(maskImage.CGImage),
                                        CGImageGetBitsPerComponent(maskImage.CGImage),
                                        CGImageGetBitsPerPixel(maskImage.CGImage),
                                        CGImageGetBytesPerRow(maskImage.CGImage),
                                        CGImageGetDataProvider(maskImage.CGImage), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask(image.CGImage, mask);
    
    UIImage *result = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(mask);
    CGImageRelease(masked);
    
    return result;
}


-(void)moveObject:(UIPanGestureRecognizer *)pan;
{
    pan.view.center = [pan locationInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
