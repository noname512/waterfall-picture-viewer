//
//  WaterfallViewController.m
//  pictureviewer
//
//  Created by zxononame on 2020/6/27.
//  Copyright © 2020 zxononame. All rights reserved.
//

#import "WaterfallViewController.h"
#import "WaterfallViewLayout.h"
#import "WaterfallViewCell.h"

@interface WaterfallViewController ()

@property (nonatomic) NSInteger cnt;
@property (nonatomic, strong) NSMutableDictionary *cellDic;

@end

@implementation WaterfallViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.cellDic = [[NSMutableDictionary alloc] init];
                                      
    _cnt = 0;
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (WaterfallViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *formatInd = [NSString stringWithFormat:@"%@", indexPath];
    NSString *identifier = [_cellDic objectForKey:formatInd];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", reuseIdentifier, formatInd];
        [_cellDic setValue:identifier forKey:formatInd];
        [self.collectionView registerClass:[WaterfallViewCell class] forCellWithReuseIdentifier:identifier];
    }
    
    WaterfallViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell.cellImageView == nil) {
        _cnt = _cnt + 1;
        NSLog(@"test %ld: %ld", _cnt, indexPath.item);
        cell.cellImageView = [[UIImageView alloc] init];
        
        // Configure the cell
    /*    NSInteger imageIndex = arc4random() % 10;
        NSString *imageName = [NSString stringWithFormat:@"00%ld.jpg", imageIndex];*/
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"qwq" ofType:@"jpg"];
        UIImage *images = [UIImage imageWithContentsOfFile:imagePath];
        [cell.cellImageView setImage:images];
        cell.cellImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255. green:arc4random() % 256 / 255. blue:arc4random() % 256 / 255. alpha:1];
        NSLog(@"bgc: %ld", indexPath.item * 10);
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(nonnull UICollectionViewLayout *)fromLayout newLayout:(nonnull UICollectionViewLayout *)toLayout {
    UICollectionViewTransitionLayout *transition = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return transition;
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
