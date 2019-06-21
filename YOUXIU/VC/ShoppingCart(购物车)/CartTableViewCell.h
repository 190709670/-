//
//  CartTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell
+ (CGFloat)cellHeight;
-(void)setCartInfoWithMusicInfo:(id)MusicInfo;
@end
