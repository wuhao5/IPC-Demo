//
//  ServiceObject.m
//  IPCServ
//
//  Created by Jeremy Agostino on 4/24/13.
//  Copyright (c) 2013 Tekserve. All rights reserved.
//

#import "ServiceObject.h"

@implementation ServiceObject

- (NSString *)getInfoCommand:(NSInteger)number
{
    if (number == self.myNumber) {
        return [NSString stringWithFormat:@"%ld is the server's number", number];
    }
    else {
        return [NSString stringWithFormat:@"%ld is NOT the server's number", number];
    }
}

- (NSString *)fooClient:(ClientObject2 *)obj {
  return [obj foo];
}

- (NSString *)getService {
  ClientObject *obj = (id)[NSConnection rootProxyForConnectionWithRegisteredName:@"com.tekserve.IPCServ.TestService2" host:nil];
  return [[obj foo:[[ServiceObject2 alloc] init]] stringByAppendingString:[obj foo]];
}
@end

@implementation ServiceObject2

- (NSString *)foo {
  ClientObject2 *obj = (id)[NSConnection rootProxyForConnectionWithRegisteredName:@"com.tekserve.IPCServ.TestService3" host:nil];
  return [obj foo];
}

@end
