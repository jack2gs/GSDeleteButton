//
//  GSDeleteButton.m
//  GSDeleteButton
//
//  Created by Gao Song on 11/2/15.
//  Copyright © 2015 Gao Song. All rights reserved.
//

#import "GSDeleteButton.h"

@interface GSDeleteButton ()
@property UILabel *indedicatorLabel;
@end

@implementation GSDeleteButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        UIView *closeShapeView=[self createCloseShapeViewWithFrame:self.bounds];
        
        [self addSubview:closeShapeView];
        
        self.transform=CGAffineTransformMakeRotation(M_PI_4);
    }
    
    return self;
}

-(UIView *)createCloseShapeViewWithFrame:(CGRect)frame
{
    UIView *shapeView=[[UIView alloc] initWithFrame:frame];
    
    CGRect bound = shapeView.bounds;
    
    CALayer *lineLayer1=[self createLineShapeLayerWithStart:CGPointMake(CGRectGetMinX(bound), CGRectGetMinY(bound)) end:CGPointMake(CGRectGetMaxX(bound), CGRectGetMaxY(bound)) andColor:[UIColor blackColor]];
    CALayer *lineLayer2=[self createLineShapeLayerWithStart:CGPointMake(CGRectGetMinX(bound), CGRectGetMaxY(bound)) end:CGPointMake(CGRectGetMaxX(bound), CGRectGetMinY(bound)) andColor:[UIColor blackColor]];
    
    [shapeView.layer addSublayer:lineLayer1];
    [shapeView.layer addSublayer:lineLayer2];
    
    return shapeView;
    
}

- (CAShapeLayer*)createLineShapeLayerWithStart:(CGPoint)start end:(CGPoint)end andColor:(UIColor*)color {
    
    CAShapeLayer* layer = [CAShapeLayer new];
    
    UIBezierPath* path = [UIBezierPath new];
    
    [path moveToPoint:start];
    [path addLineToPoint:end];
    
    layer.path = path.CGPath;
    layer.lineWidth =2.f;
    layer.strokeColor = color.CGColor;
    
    return layer;
}

@end
