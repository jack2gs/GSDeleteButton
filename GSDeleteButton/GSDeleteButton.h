//
//  GSDeleteButton.h
//  GSDeleteButton
//
//  Created by Gao Song on 11/2/15.
//  Copyright © 2015 Gao Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GSDeleteButton;

@protocol GSDeleteButtonDelegate <NSObject>

-(void)wantToDelete:(GSDeleteButton *)button;

-(void)sureToDelete:(GSDeleteButton *)button;

@end

@interface GSDeleteButton : UIButton

@property(weak) id<GSDeleteButtonDelegate> delegate;

@property UIColor *deleteLabelColor;
@property UIFont *deleteLabelFont;

@property UIColor *indicatorColor;
@property CGFloat indicatorLineWeight;
-(void)reset;
@end
