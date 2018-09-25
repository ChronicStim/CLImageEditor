//
//  CLImageToolInfo.h
//
//  Created by sho yakushiji on 2013/11/26.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CLTool_Unknown = 0,
    CLTool_Adjustment,
    CLTool_Blur,
    CLTool_Clipping,
    CLTool_Draw,
    CLTool_Effect,
    CLTool_Filter,
    CLTool_Rotate,
    CLTool_ToneCurve,
    CLTool_Emoticon,
    CLTool_Resize,
    CLTool_Splash,
    CLTool_Sticker,
    CLTool_Text
} CLEditorTool;

#import <UIKit/UIKit.h>
@interface CLImageToolInfo : NSObject

@property (nonatomic, readonly) NSString *toolName;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, assign)   BOOL      available;
@property (nonatomic, assign)   CGFloat   dockedNumber;
@property (nonatomic, strong)   NSString *iconImagePath;
@property (nonatomic, readonly) UIImage  *iconImage;
@property (nonatomic, readonly) NSArray  *subtools;
@property (nonatomic, strong) NSMutableDictionary *optionalInfo;


- (NSString*)toolTreeDescription;
- (NSArray*)sortedSubtools;

- (CLImageToolInfo*)subToolInfoWithToolName:(NSString*)toolName recursive:(BOOL)recursive;

@end
