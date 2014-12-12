//
//  CLImageToolBase.m
//
//  Created by sho yakushiji on 2013/10/17.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import "CLImageToolBase.h"

@interface CLImageToolBase ()

@property (nonatomic, weak) NSUserDefaults *defaults;

@end

@implementation CLImageToolBase

- (id)initWithImageEditor:(_CLImageEditorViewController*)editor withToolInfo:(CLImageToolInfo*)info
{
    self = [super init];
    if(self){
        self.editor   = editor;
        self.toolInfo = info;
    }
    return self;
}

+ (NSString*)defaultIconImagePath
{
    CLImageEditorTheme *theme = [CLImageEditorTheme theme];
    return [NSString stringWithFormat:@"%@.bundle/%@/%@/icon.png", [CLImageEditorTheme bundleName], NSStringFromClass([self class]), theme.toolIconColor];
}

+ (CGFloat)defaultDockedNumber
{
    // Image tools are sorted according to the dockedNumber in tool bar.
    // Override point for tool bar customization
    NSArray *tools = @[
                       @"CLClippingTool",
                       @"CLRotateTool",
                       @"CLResizeTool",
                       @"CLAdjustmentTool",
                       @"CLFilterTool",
                       @"CLEffectTool",
                       @"CLBlurTool",
                       @"CLToneCurveTool",
                       @"CLSplashTool",
                       @"CLTextTool",
                       @"CLDrawTool",
                       @"CLStickerTool",
                       @"CLEmoticonTool"
                       ];
    return [tools indexOfObject:NSStringFromClass(self)];
}

+ (NSArray*)subtools
{
    return nil;
}

+ (NSString*)defaultTitle
{
    return @"DefaultTitle";
}

+ (BOOL)isAvailable
{
    return NO;
}

+ (NSDictionary*)optionalInfo
{
    return nil;
}

+ (CLEditorTool)editorToolCode;
{
    return CLTool_Unknown;
}

#pragma mark-

- (void)setup
{
    
}

- (void)cleanup
{
    
}

- (void)executeWithCompletionBlock:(void(^)(UIImage *image, NSError *error, NSDictionary *userInfo))completionBlock
{
    completionBlock(self.editor.imageView.image, nil, nil);
}

#pragma mark - Tool Availability

-(NSUserDefaults *)defaults;
{
    return [NSUserDefaults standardUserDefaults];
}

+(BOOL)editorToolIsAvailable;
{
    CLEditorTool editorTool = [[self class] editorToolCode];
    NSString *key = [self preferenceKeyForEditorToolAvailability];
    if (nil != [[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        //Default value exists and will be returned
        return [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    }
    
    // Default has not been set, so get default value and save to prefernces
    BOOL initialAvailability = [self defaultAvailabilityForEditorTool:editorTool];
    [self makeEditorToolAvailable:initialAvailability];
    return initialAvailability;
}

+(NSString *)preferenceKeyForEditorToolAvailability;
{
    NSString *key = [NSString stringWithFormat:@"!Cloud_CLEditorToolIsAvailable_%@",[[self class] defaultTitle]];
    NSLog(@"%@",key);
    return key;
}

+(void)makeEditorToolAvailable:(BOOL)available;
{
    NSString *key = [self preferenceKeyForEditorToolAvailability];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:available] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)defaultAvailabilityForEditorTool:(CLEditorTool)editorTool;
{
    BOOL defaultAvailability;
    switch (editorTool) {
        case CLTool_Adjustment:
        case CLTool_Clipping:
        case CLTool_Draw:
        case CLTool_Emoticon:
        case CLTool_Resize:
        case CLTool_Rotate:
        case CLTool_Sticker:
        case CLTool_Text:
            defaultAvailability = YES;
            break;
        case CLTool_Blur:
        case CLTool_Effect:
        case CLTool_Filter:
        case CLTool_Splash:
        case CLTool_ToneCurve:
        default:
            defaultAvailability = NO;
            break;
    }
    return defaultAvailability;
}

@end
