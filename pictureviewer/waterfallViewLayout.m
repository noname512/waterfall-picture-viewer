//
//  WaterfallViewLayout.m
//  pictureviewer
//
//  Created by zxononame on 2020/6/21.
//  Copyright © 2020 zxononame. All rights reserved.
//

#import "WaterfallViewLayout.h"

@interface WaterfallViewLayout ()

@property (nonatomic, strong) NSMutableArray *columHeightArr;
@property (nonatomic, strong) NSMutableArray *cellFrameArr;

@end

@implementation WaterfallViewLayout

- (void)setColum:(NSInteger) colum {
    if (colum != _colum) {
        _colum = colum;
        [self invalidateLayout];
    }
}

- (void)setDistance:(NSInteger) distance {
    if (distance != _distance) {
        _distance = distance;
        [self invalidateLayout];
    }
}

- (void)setInsetSpace:(UIEdgeInsets) insetSpace {
    if (!UIEdgeInsetsEqualToEdgeInsets(insetSpace, _insetSpace)) {
        _insetSpace = insetSpace;
        [self invalidateLayout];
    }
}

- (void)prepareLayout {
    [self initDataArray];
    [self initColumHeightArray];
    [self initAllCellHeight];
}

- (void)initDataArray {
    _columHeightArr = [NSMutableArray arrayWithCapacity:_colum];
    _cellFrameArr = [NSMutableArray arrayWithCapacity:0];
}

- (void)initColumHeightArray {
    for (int i = 0; i < _colum; i++) {
        [_columHeightArr addObject:@(_insetSpace.top)];
    }
}

- (void)initAllCellHeight {
    NSInteger allCellNumber = [self.collectionView numberOfItemsInSection:0];
    CGFloat totalWidth = self.collectionView.frame.size.width;
    CGFloat itemAllWidth = totalWidth - _insetSpace.left - _insetSpace.right - _distance * (_colum - 1);
    CGFloat width = itemAllWidth / _colum;
    for (int i = 0; i < allCellNumber; i++) {
        NSInteger currentColum = [self getShortestColum];
        CGFloat xOffset = _insetSpace.left + currentColum * (width + _distance);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat yOffset = [[_columHeightArr objectAtIndex:currentColum] floatValue] + _distance;
        CGFloat height = 0.f;
        if (_delegate && [_delegate respondsToSelector:@selector(waterfall:heightForCellAtIndexPath:)]) {
            height = [_delegate waterfall:self heightForCellAtIndexPath:indexPath];
        }
        CGRect frame = CGRectMake(xOffset, yOffset, width, height);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [_cellFrameArr addObject:attributes];
        _columHeightArr[currentColum] = @(frame.size.height + frame.origin.y);
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_cellFrameArr objectAtIndex:indexPath.item];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attributes in _cellFrameArr) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [temp addObject:attributes];
        }
    }
    return temp;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = [self getLongestColumHeight];
    return CGSizeMake(width, height);
}

- (CGFloat)getLongestColumHeight {
    __block NSInteger currentColum = 0;
    __block CGFloat longestHeight = 0;
    [_columHeightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj floatValue] > longestHeight) {
            longestHeight = [obj floatValue];
            currentColum = idx;
        }
    }];
    return longestHeight + _insetSpace.bottom;
}

- (NSInteger)getShortestColum {
    __block NSInteger currentColum = 0;
    __block CGFloat ShortestHeight = 0;
    [_columHeightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj floatValue] < ShortestHeight) {
            ShortestHeight = [obj floatValue];
            currentColum = idx;
        }
    }];
    return currentColum;
}

@end
