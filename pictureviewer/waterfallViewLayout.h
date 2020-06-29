//
//  waterfallViewLayout.h
//  pictureviewer
//
//  Created by zxononame on 2020/6/21.
//  Copyright © 2020 zxononame. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@class WaterfallViewLayout;
//@protocol WaterfallLayoutDelegate <NSObject>

//- (CGFloat)waterfall:(WaterfallViewLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath;

//@end

@interface WaterfallViewLayout : UICollectionViewLayout

//@property (nonatomic, weak) id <WaterfallLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger colum;
@property (nonatomic, assign) UIEdgeInsets insetSpace;
@property (nonatomic, assign) NSInteger distance;

@end

NS_ASSUME_NONNULL_END
