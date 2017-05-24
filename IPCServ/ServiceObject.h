//
//  ServiceObject.h
//  IPCServ
//
//  Created by Jeremy Agostino on 4/24/13.
//  Copyright (c) 2013 Tekserve. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServiceObject2;
@class ClientObject2;

@interface ServiceObject : NSObject

- (NSString *)getInfoCommand:(NSInteger)number;
@property (nonatomic, readwrite) NSInteger myNumber;

- (NSString *)getService;
- (NSString *)fooClient:(ClientObject2 *)obj;
@end

@interface ServiceObject2 : NSObject

- (NSString *)foo;
@end

@interface ClientObject : NSObject
- (NSString *)foo:(ServiceObject2 *)obj;
@end

@interface ClientObject2 : NSObject
- (NSString *)foo;
@end
