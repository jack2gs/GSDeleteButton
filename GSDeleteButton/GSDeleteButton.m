//
//  GSDeleteButton.m
//  GSDeleteButton
//
//  Created by Gao Song on 11/2/15.
//  Copyright © 2015 Gao Song. All rights reserved.
//

#import "GSDeleteButton.h"

@interface GSDeleteButton ()
{
    BOOL _indicatorShown;
}

@property CGRect origialFrame;
@property CGRect finalFrame;

@property UILabel *deleteLabel;
@property CAShapeLayer *indicatorLayer;


@end

@implementation GSDeleteButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        // initialize indicator layer
        _indicatorLayer=[self createCloseShapeViewWithFrame:self.bounds];
        
        // initialize delete label
        _deleteLabel=[[UILabel alloc] init];
        _deleteLabel.text=@"清除";
        [_deleteLabel setTextAlignment:NSTextAlignmentCenter];
        
        CGSize suggestedSize=[_deleteLabel systemLayoutSizeFittingSize:CGSizeMake(999.f, 999.f)];
        _deleteLabel.alpha=0.f;
        
        // set frames
        _origialFrame=frame;
        
        CGFloat padding=10.f;
        CGFloat xOffset=suggestedSize.width-CGRectGetWidth(frame)+padding;
        
        _finalFrame=_origialFrame;
        _finalFrame.origin.x-=xOffset;
        _finalFrame.size.width+=xOffset;
        
        
        // add to this
        [self.layer addSublayer:_indicatorLayer];
        [self addSubview:_deleteLabel];
        
        // event handler
        [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
        
        _indicatorShown=YES;
        
        self.layer.cornerRadius=MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2;
        self.clipsToBounds=YES;
    }
    
    return self;
}

-(void)reset
{
        [self showIndicator:YES completion:nil];
}

-(void)toggle
{
    [self showIndicator:!_indicatorShown completion:^{
        if (_indicatorShown) {
            if (self.delegate) {
                [self.delegate sureToDelete:self];
            }
        }
        else
        {
            if (self.delegate) {
                [self.delegate wantToDelete:self];
            }
        }
    }];
}

-(void)showIndicator:(BOOL)show completion:(void(^)())completion
{
    
    CGFloat offset=CGRectGetWidth(_finalFrame)-CGRectGetWidth(_origialFrame);
    
    CGRect deleteLabelStartFrame,deleteLabelFinalFrame,finalFrame;
    CGFloat deleteLabelStartAlpha,deleteLabelFinalAlpha,indicatorStartAlhpa,indicatorFinalAlhpa;
    CGFloat indicatorRotationFinalRadians;
    
    
    
    if (show) {
        
        finalFrame=self.origialFrame;
        
        deleteLabelStartAlpha=1.0f;
        deleteLabelFinalAlpha=0.f;
        
        deleteLabelStartFrame=CGRectMake(0, 0, CGRectGetWidth(_finalFrame), CGRectGetHeight(_finalFrame));
        deleteLabelFinalFrame=deleteLabelStartFrame;
        deleteLabelFinalFrame.origin.x-=offset;
        
        indicatorStartAlhpa=0.f;
        indicatorFinalAlhpa=1.f;
        
        indicatorRotationFinalRadians=-2*M_PI;
    }
    else
    {
        finalFrame=self.finalFrame;
        
        deleteLabelStartAlpha=0.0f;
        deleteLabelFinalAlpha=1.f;
        
        deleteLabelStartFrame=CGRectMake(-offset, 0, CGRectGetWidth(_finalFrame), CGRectGetHeight(_finalFrame));
        deleteLabelFinalFrame=deleteLabelStartFrame;
        deleteLabelFinalFrame.origin.x=0.f;
        
        indicatorStartAlhpa=1.f;
        indicatorFinalAlhpa=0.f;
        
        indicatorRotationFinalRadians=2*M_PI;

    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.fromValue=@(0.f);
    animation.toValue=@(indicatorRotationFinalRadians);
    animation.duration=.5f;
 
    [_indicatorLayer addAnimation:animation forKey:@"rotation"];
    
    
    _deleteLabel.alpha=deleteLabelStartAlpha;
    _deleteLabel.frame=deleteLabelStartFrame;
    
    _indicatorLayer.opacity=indicatorStartAlhpa;
    
    [UIView animateWithDuration:.5f animations:^{
        
        self.frame=finalFrame;
        
        _deleteLabel.alpha=deleteLabelFinalAlpha;
        _deleteLabel.frame=deleteLabelFinalFrame;
        
        _indicatorLayer.opacity=indicatorFinalAlhpa;
        
    } completion:^(BOOL finished) {
        _indicatorShown=show;
        
        if (completion) {
            completion();
        }
        
    }];
    
}

-(CAShapeLayer *)createCloseShapeViewWithFrame:(CGRect)frame
{
    CAShapeLayer *shapeLayer=[[CAShapeLayer alloc] init];
    
    shapeLayer.position=CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    shapeLayer.bounds=CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    
    CGFloat padding=3.f;
    
    CGRect bound = shapeLayer.bounds;
    
    CGFloat radius=MIN(CGRectGetWidth(bound), CGRectGetHeight(bound))/2;
    CGPoint centerPoint=shapeLayer.position;
    
    
    if (radius > padding) {
        
        radius -= padding;
    
    }
    
    CALayer *lineLayer1=[self createLineShapeLayerWithStart:[self pointOfCircleAtCenter:centerPoint
                                                                                radidus:radius
                                                                                radians:M_PI*0.75f]
                                                        end:[self pointOfCircleAtCenter:centerPoint
                                                                                radidus:radius
                                                                                radians:M_PI*-0.25f]
                                                   andColor:[UIColor blackColor]];
    
    CALayer *lineLayer2=[self createLineShapeLayerWithStart:[self pointOfCircleAtCenter:centerPoint
                                                                                radidus:radius
                                                                                radians:M_PI*0.25f]
                                                        end:[self pointOfCircleAtCenter:centerPoint
                                                                                radidus:radius
                                                                                radians:M_PI*-0.75f]
                                                   andColor:[UIColor blackColor]];
    
    [lineLayer1 setPosition:shapeLayer.position];
    [lineLayer1 setBounds:shapeLayer.bounds];
    
    [lineLayer2 setPosition:shapeLayer.position];
    [lineLayer2 setBounds:shapeLayer.bounds];

    
    
    [shapeLayer addSublayer:lineLayer1];
    [shapeLayer addSublayer:lineLayer2];
    
    return shapeLayer;
    
}

- (CAShapeLayer*)createLineShapeLayerWithStart:(CGPoint)start end:(CGPoint)end andColor:(UIColor*)color {
    
    CAShapeLayer* layer = [CAShapeLayer new];
    
    //[layer setFrame:CGRectMake(100, 100, 20, 20)];
    
    UIBezierPath* path = [UIBezierPath new];
    
    [path moveToPoint:start];
    [path addLineToPoint:end];
    
    layer.path = path.CGPath;
    layer.lineWidth =2.f;
    layer.strokeColor = color.CGColor;
    
    return layer;
}

-(CGPoint)pointOfCircleAtCenter:(CGPoint)centerPoint radidus:(CGFloat)radius radians:(CGFloat)radians
{
    CGFloat x=centerPoint.x + radius * cosf(radians);
    CGFloat y=centerPoint.y + radius * sinf(radians);
    
    return CGPointMake(x, y);
}

@end
