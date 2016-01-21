//
//  GZPInspiratCell.h
//  YunYi
//
//  Created by liuyang on 15/8/25.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GZPInspirationModel;

@interface GZPInspiratCell : UICollectionViewCell

@property(nonatomic, strong)GZPInspirationModel * inspiratModel;

@property (weak, nonatomic) IBOutlet UIImageView *inspiratProductImage;
@property (weak, nonatomic) IBOutlet UIImageView *authorAvatarImage;

//标记传进来的模型数据对象在存储所有模型数组中的位置
@property (nonatomic,assign)NSInteger index;

+(id)inspiratCellWithCollectionView:(UICollectionView *)collectionView;

/***在创建自定义cell的同时，将数据模型和数据在模型数组中的位置一起传过来**/
+ (id)inspiratCellWithCollectionView:(UICollectionView *)collectionView andObject:(id)model andIndex:(NSInteger)index;
@end
