//
//  YNPhotoUtil.m
//
//
//  Created by liyangly on 2018/9/10.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "YNPhotoUtil.h"

@implementation YNPhotoUtil

// 获取指定相册中照片
+ (NSArray<PHAsset *> *)getImageAssetWithAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    return [YNPhotoUtil getAssetsWithAssetCollection:assetCollection mediaType:PHAssetMediaTypeImage ascending:ascending];
}

+ (NSArray<PHAsset *> *)getAllAssetWithAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    // ascending:按照片创建时间排序 >> YES:升序 NO:降序
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:obj];
    }];
    return assets;
}

+ (NSArray<PHAsset *> *)getAssetsWithAssetCollection:(PHAssetCollection *)assetCollection mediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending
{
    // ascending:按照片创建时间排序 >> YES:升序 NO:降序
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((PHAsset *)obj).mediaType == mediaType) {
            [assets addObject:obj];
        }
    }];
    return assets;
}

// 获取asset对应的图片
+ (void)getImageWithAsset:(PHAsset *)asset size:(CGSize)size completion:(void (^)(UIImage *image))completion
{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.networkAccessAllowed = YES;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        if (completion)  completion(image);
    }];
}

// 获取asset对应的图片
+ (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.networkAccessAllowed = YES;
    [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        UIImage *image = [UIImage imageWithData:imageData];
        if (completion) completion(image);
    }];
}

@end
