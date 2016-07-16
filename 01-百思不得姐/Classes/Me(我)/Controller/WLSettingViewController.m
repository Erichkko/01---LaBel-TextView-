//
//  WLSettingViewController.m
//  01-百思不得姐
//
//  Created by wanglong on 16/7/15.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLSettingViewController.h"
#import <SDImageCache.h>

@interface WLSettingViewController ()

@end

@implementation WLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getSize];
    //获取当前文件下的所有直接内容
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    WLLog(@"filePath == %@",filePath);
    //获得直接子路径
//    NSArray *contenArray = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
//
//    WLLog(@"contentStr == %@",contenArray);
    //获得所有子路径
    NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:filePath error:nil];
    WLLog(@"subPaths ==  %@",subPaths);
 
 
}
- (void)getSubFile
{
    //获取当前文件下的所有直接内容
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    WLLog(@"filePath == %@",filePath);
    //获得直接子路径
    //    NSArray *contenArray = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
    //
    //    WLLog(@"contentStr == %@",contenArray);
    //获得所有子路径
    NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:filePath error:nil];
    WLLog(@"subPaths ==  %@",subPaths);
}
-(void)getSize
{
    NSUInteger cacheSize = [SDImageCache sharedImageCache].getSize;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = @"default/com.hackemist.SDWebImageCache.default";
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    WLLog(@"%zd,%@",cacheSize,filePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:filePath];
    NSUInteger size = 0;
    for (NSString *fileName in fileEnumerator) {
        
        
        NSString *fileAtPath =[filePath stringByAppendingPathComponent:fileName];
        //判断给定路径的文件是否是一个文件
        //        BOOL isDir = NO;
        //        [fileManager fileExistsAtPath:fileAtPath isDirectory:&isDir];
        //        if (isDir) {
        //            continue;
        //        }
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:fileAtPath error:nil];
        //通过获取得指定路径的文件信息判断文件属性
        if ([[fileDict fileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        size += [fileDict fileSize];
    }
    WLLog(@"size == %zd",size);
    /**
     fileDict == {
     NSFileOwnerAccountID : 502,
     NSFileSystemFileNumber : 4390568,
     NSFileExtensionHidden : 0,
     NSFileSystemNumber : 16777218,
     NSFileSize : 31654,            获取文件大小时比较准确，获取文件夹 不准确
     NSFileGroupOwnerAccountID : 20,
     NSFilePosixPermissions : 493,
     NSFileCreationDate : 2016-06-30 12:36:21 +0000,
     NSFileType : NSFileTypeDirectory,
     NSFileGroupOwnerAccountName : staff,
     NSFileReferenceCount : 931,
     NSFileModificationDate : 2016-07-15 13:45:21 +0000
     }
     */
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *sizeStr;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    WLLog(@"size -- %zd",size);
    if (size < 1000) {
        sizeStr = [NSString stringWithFormat:@"%zdb",size];
    }else if(size < 1000 * 1000){
        sizeStr = [NSString stringWithFormat:@"%.2fk",1.0 *size/1000];
    }else{
        sizeStr = [NSString stringWithFormat:@"%.2fm",1.0 *size/1000/1000];

    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"清除缓存(%@)", sizeStr];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    [tableView reloadData];
}
@end