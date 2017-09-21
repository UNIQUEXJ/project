//
//  LJWeakTimer.h
//  Mcu_sdk_demo
//
//  Created by 刘蒋 on 2017/6/6.
//  Copyright © 2017年 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LJWeakTimerHandler)(id userInfo);

@interface LJWeakTimer : NSObject

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(LJWeakTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
