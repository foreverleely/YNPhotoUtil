//
//  YNPhotoUtil.h
//  
//
//  Created by liyangly on 2018/9/10.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

@interface YNPhotoUtil : NSObject

/**
 获取指定相册中照片
 
 @param assetCollection 相册
 @param ascending 升序OR降序
 @return 排序后的集合
 */
+ (NSArray<PHAsset *> *)getImageAssetWithAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

+ (NSArray<PHAsset *> *)getAllAssetWithAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

+ (NSArray<PHAsset *> *)getAssetsWithAssetCollection:(PHAssetCollection *)assetCollection mediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending;

/**
 获取asset对应的图片
 
 @param asset asset
 @param size 图片size
 @param completion 图片
 */
+ (void)getImageWithAsset:(PHAsset *)asset
                     size:(CGSize)size
               completion:(void (^)(UIImage *image))completion;


/**
 获取asset对应图片
 
 @param asset asset
 @param completion 图片
 */
+ (void)getImageWithAsset:(PHAsset *)asset
               completion:(void (^)(UIImage *image))completion;

@end
