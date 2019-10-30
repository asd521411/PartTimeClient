//
//  PomeloHotPositionTableViewCell.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloHotPositionTableViewCell.h"
#import "PomeloHotCollectionViewCell.h"
#import "UIView+HWUtilView.h"

@interface PomeloHotPositionTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

//@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *itemArr;

@end

@implementation PomeloHotPositionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [ECUtil colorWithHexString:@"f5f5f5"];
        [self setupSubViews];
    
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(KSpaceDistance15, KSpaceDistance15, self.width - KSpaceDistance15 * 2, self.height - KSpaceDistance15 * 2);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(200, 100);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumLineSpacing = 10;
        
        //_collectionView = [[UICollectionView alloc] init];
        //_collectionView.collectionViewLayout = flow;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, self.width - 15 * 2, self.height) collectionViewLayout:flow];
        _collectionView.backgroundColor = [ECUtil colorWithHexString:@"f5f5f5"];
        _collectionView.contentSize = CGSizeMake(self.width, self.height);
        //_collectionView.pagingEnabled = YES;
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[PomeloHotCollectionViewCell class] forCellWithReuseIdentifier:@"PomeloHotCollectionViewCell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PomeloHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PomeloHotCollectionViewCell" forIndexPath:indexPath];
    cell.commonModel = self.itemArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    if (self.collectionDidSelectItemBlock) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        self.collectionDidSelectItemBlock(strongSelf.itemArr[indexPath.row], indexPath.row);
    }
}

- (void)setCellArr:(NSArray *)cellArr {
    if (_cellArr != cellArr) {
        _cellArr = cellArr;
        [self.itemArr removeAllObjects];
        self.itemArr = [[NSMutableArray alloc] initWithArray:cellArr];
        [self.collectionView reloadData];
    }
}

- (NSMutableArray *)itemArr {
    if (!_itemArr) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
