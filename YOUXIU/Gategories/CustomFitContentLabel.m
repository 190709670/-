//
//  CustomFitContentLabel.m
//  TheGenuine
//
//  Created by lihui on 16/4/12.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "CustomFitContentLabel.h"
@interface CustomFitContentLabel(){
    CGRect orgionFrame;
}

@end
@implementation CustomFitContentLabel
@synthesize verticalAlignment = verticalAlignment_;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        orgionFrame = frame;
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

-(void)fitcontentWithHeight{
    CGRect rect = orgionFrame;
    if (self.numberOfLines!=0) {
        CGSize size =CGSizeMake(rect.size.width, 2000);
        CGSize labelsize =[self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize siglerow = [@"1"  sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat sigleHeight = siglerow.height;
  
        CGFloat height = rect.size.height - siglerow.height + labelsize.height;

        if (height > self.numberOfLines * sigleHeight) {
            height = rect.size.height - sigleHeight + sigleHeight * self.numberOfLines;
        }
        
        [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width,height)];
    }else{
        self.lineBreakMode =  NSLineBreakByClipping;
        CGSize size =CGSizeMake(rect.size.width, 2000);
        CGSize labelsize =[self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, labelsize.height)];
    }
}
-(void)fitcontentWithWidth{
    CGSize titleSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(Macro_ScreenWidth-self.frame.size.width, self.frame.size.height)];
    CGFloat width =titleSize.width;
    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y,width, self.frame.size.height)];
}
-(void)fitcontentWithWidthWithSpce:(CGFloat)spec{
    CGSize titleSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(Macro_ScreenWidth-self.frame.size.width, self.frame.size.height)];
    CGFloat width =titleSize.width;
    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y,width+spec, self.frame.size.height)];
}

#pragma mark 位置设置
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
@end
