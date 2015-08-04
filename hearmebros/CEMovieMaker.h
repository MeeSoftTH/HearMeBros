//
//  CEMovieMaker.h
//
//  Created by Petch Temeeyasen on 7/18/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//
@import AVFoundation;
@import Foundation;
@import UIKit;

typedef void(^CEMovieMakerCompletion)(NSURL *fileURL);

@interface CEMovieMaker : NSObject

@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *writerInput;
@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *bufferAdapter;
@property (nonatomic, strong) NSDictionary *videoSettings;
@property (nonatomic, assign) CMTime frameTime;
@property (nonatomic, strong) NSURL *fileURL;
@property (nonatomic, copy) CEMovieMakerCompletion completionBlock;

- (instancetype)initWithSettings:(NSDictionary *)videoSettings;
+ (instancetype)CEMovieMakerWithSetting:(NSDictionary *)videoSettings;
- (void)createMovieFromImages:(NSArray *)images withCompletion:(CEMovieMakerCompletion)completion;

+ (NSDictionary *)videoSettingsWithCodec:(NSString *)codec withWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
