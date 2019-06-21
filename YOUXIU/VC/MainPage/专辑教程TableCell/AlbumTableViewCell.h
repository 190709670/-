//
//  AlbumTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
-(void)setAlbumInfoWithData:(id)AlbumInfo;
-(void)setAlbumAddCartStatus:(NSInteger)status;
+(NSInteger)CellHeight;
@end
