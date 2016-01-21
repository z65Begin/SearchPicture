//
//  GZPInspiratCell.m
//  YunYi
//
//  Created by liuyang on 15/8/25.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import "GZPInspiratCell.h"
#import "GZPInspirationModel.h"
#import "GZPComponent.h"

@interface GZPInspiratCell ()
@property (weak, nonatomic) IBOutlet UIView *xinXiView;

@end

@implementation GZPInspiratCell


+(id)inspiratCellWithCollectionView:(UICollectionView *)collectionView
{
    UINib * nib = [UINib nibWithNibName:@"GZPInspiratCell" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil]lastObject];

}

+ (id)inspiratCellWithCollectionView:(UICollectionView *)collectionView andObject:(id)model andIndex:(NSInteger)index
{
    GZPInspiratCell * cell = [self inspiratCellWithCollectionView:collectionView];
    cell.index = index;
    cell.inspiratModel = model;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1;
    return cell;
}

-(void)awakeFromNib
{
    self.xinXiView.backgroundColor = [UIColor colorWithHexString:@"#f1faff"];
    self.backgroundColor = [UIColor colorWithHexString:@"#efefef"];

    
}

-(void)setInspiratModel:(GZPInspirationModel *)inspiratModel
{
    _inspiratModel = inspiratModel;
    [self.inspiratProductImage sd_setImageWithURL:[NSURL URLWithString:inspiratModel.homeComponent.picUrl]];
    [self.authorAvatarImage sd_setImageWithURL:[NSURL URLWithString:inspiratModel.homeComponent.picUrl]];
}

@end
