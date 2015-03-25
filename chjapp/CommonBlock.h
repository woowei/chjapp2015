//
//  CommonBlock.h
//  iHaiGo
//
//  Created by kcmini on 14-7-7.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#ifndef iHaiGo_CommonBlock_h
#define iHaiGo_CommonBlock_h

typedef void (^ScrollViewWillBeginDecelerating)(CGFloat lastContentOffset, UIScrollView *scroll); //列表滑动时
typedef void (^TableCellSelect)(NSIndexPath *indexPath, id object);//tableview cell 点击时
typedef void (^ButtonActionBlock)(UIButton *btn,id model);//按钮点击block
typedef void (^CommonBlock)(id object); //普通block
typedef void (^CommonBlockDouble)(id object1, id object2); //双参数block

#endif
