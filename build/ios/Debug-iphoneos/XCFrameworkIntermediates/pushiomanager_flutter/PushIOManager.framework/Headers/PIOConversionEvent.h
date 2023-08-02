//
//  PIOConversionEvent.h
//  PushIOManager
//
//  Created by Sahil Wasan on 24/11/20.
//  Copyright © 2020 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushIOManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PIOConversionEvent : NSObject
@property (strong, nonatomic, nonnull) NSString *orderId;
@property (assign, nonatomic) double orderTotal;
@property (assign, nonatomic) NSInteger orderQuantity;
@property (assign, nonatomic) PushIOEngagementMetrics conversionType;
@property (strong, nonatomic) NSDictionary *customProperties;

-(instancetype)initWithOrderId:(nonnull NSString *)orderId orderTotal:(double)orderTotal orderQuantity:(NSInteger)orderQuantity conversionType:(PushIOEngagementMetrics)conversionType customProperties:(NSDictionary *)customProperties;

@end

NS_ASSUME_NONNULL_END
