//
//  GZPDetaillView.m
//  YunYi
//
//  Created by liuyang on 15/8/4.
//  Copyright (c) 2015年 北京日立北工大信息系统有限公司. All rights reserved.
//

#import "GZPDetaillCommentView.h"
#import "GZPDetaillViewCell.h"

#define IMAGEH  ([UIScreen mainScreen].bounds.size.width - 16)*9/16
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@interface GZPDetaillCommentView ()
@property(nonatomic,weak)UIImageView * commentUserImage;
@end

static const CGFloat MJDuration = 2.0;
@implementation GZPDetaillCommentView
{
    int _imageCount;
}
-(void)setObjs:(NSMutableArray *)objs
{
    _objs = objs;
    
    if (_imageCount>=2) {
        self.listView2.headImage = self.headImage;
        self.listView2.headUrl = self.headUrl;
        self.listView2.likeNum = self.likeNum;
        self.listView2.collectNum = self.collectNum;
        if (_objs !=nil) {
            self.listView2.objs = self.objs;
        }
        self.listView2 = self.listView2;
        
        [_commentListdelegate authorBtn:self.listView2.headDetaillView.authorBtn];
        [_commentListdelegate followBtn:self.listView.headDetaillView.followBtn];

    }else{
        self.listView.headImage = self.headImage;
        self.listView.headUrl = self.headUrl;
        self.listView.likeNum = self.likeNum;
        self.listView.collectNum = self.collectNum;
        if (_objs !=nil) {
            self.listView.objs = self.objs;
        }
        self.listView = self.listView;
        
        [_commentListdelegate authorBtn:self.listView.headDetaillView.authorBtn];
        [_commentListdelegate followBtn:self.listView.headDetaillView.followBtn];

        
    }

   }

-(void)setLikeNum:(NSMutableArray *)likeNum
{
    _likeNum = likeNum;
    self.listView.likeNum = likeNum;
}

-(void)setCollectNum:(NSMutableArray *)collectNum
{
    _collectNum = collectNum;
    self.listView.collectNum = collectNum;
}

-(void)setCommentObjs:(NSMutableArray *)commentObjs
{
    _commentObjs = commentObjs;
    
    [self.tableView reloadData];
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

+(id)commentView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getnotf:) name:@"selectImages" object:nil];
        
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
       //self.tableView.rowHeight = 90 + IMAGEH;
//        self.height = self.tableView.rowHeight;
        [self addSubview:self.tableView];
        
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.tableView.footer beginRefreshing];
    }
    return self;
}

- (void)getnotf:(NSNotification *)nit
{
    NSDictionary *dict = nit.userInfo;
   _imageCount = [dict[@"images"] intValue];
    if (_imageCount>=2) {
        GZPListView2 * listView2 = [GZPListView listView];
        self.listView2 = listView2;
        listView2.frame = CGRectMake(0, 0, W, 90 + IMAGEH+130);
        self.tableView.tableHeaderView = listView2;//把listView放到tableView的头文件中
    }else{
        //创建tableView的表头视图
        GZPListView * listView = [GZPListView listView];
        self.listView = listView;
        listView.frame = CGRectMake(0, 0, W, 90 + IMAGEH);
        self.tableView.tableHeaderView = listView;//把listView放到tableView的头文件中

    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    GZPListView * listView = [GZPListView listView];
//    listView.headImage = self.headImage;
//    listView.headUrl = self.headUrl;
//    listView.likeNum = self.likeNum;
//    listView.collectNum = self.collectNum;
//    if (_objs !=nil) {
//        listView.objs = self.objs;
//    }
//    self.listView = listView;
//    
//    [_commentListdelegate authorBtn:self.listView.headDetaillView.authorBtn];
//    [_commentListdelegate followBtn:self.listView.headDetaillView.followBtn];
//    return listView;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentObjs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GZPDetaillViewCell * cell = [GZPDetaillViewCell commentViewCellWithTableView:tableView andObject:self.commentObjs[indexPath.row] andIndex:indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.detaillViewCell = cell;
    self.commentUserImage = cell.commentUserImage;
    
    UIButton *commentUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentUserBtn = commentUserBtn;
    [commentUserBtn setFrame:self.commentUserImage.frame];
    commentUserBtn.tag = indexPath.row;
    [commentUserBtn addTarget:self action:@selector(commentUserBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commentUserImage addSubview:commentUserBtn];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


-(void)commentUserBtnTouch:(UIButton *)button
{
    [_commentListdelegate commentUserBtn:button andIndex:(int)button.tag];
}


-(void)loadMoreData
{
    //1.我要确定，加载的是第几页,基数10，应该是文档中给出的，每次请求返回的数据量，不应该是我们自己猜测的
    int pageNumber = (int)self.objs.count / 10;//根据objs数组中存储的模型的个数，确定当前是第几页
    if (self.objs.count > pageNumber * 10) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.footer noticeNoMoreData];
        });
    }else{
        //2.告诉控制器我要加载更多的数据
        [_commentListdelegate commentView:self andPageNumber:++pageNumber andRefreshStatus:GZPCommentListRefreshFooterView];
        NSLog(@"上拉加载更多数据数据");
    }
}

@end
