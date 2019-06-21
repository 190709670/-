//
//  CustomFitContentLabel.h
//  TheGenuine
//
//  Created by lihui on 16/4/12.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface CustomFitContentLabel : UILabel{
@private VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;  
/**
 调整label高度以适配
 */
-(void)fitcontentWithHeight;
/**
 调整Label宽度以适配
 */
-(void)fitcontentWithWidth;
/**
 label添加空隙
 */
-(void)fitcontentWithWidthWithSpce:(CGFloat)spec;
@end
