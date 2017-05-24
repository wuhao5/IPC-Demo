//
//  main.m
//  ipc
//
//  Created by Jeremy Agostino on 4/24/13.
//  Copyright (c) 2013 Tekserve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../IPCServ/ServiceObject.h"

@implementation ClientObject
- (NSString *)foo:(ServiceObject2 *)obj {
  return [obj foo];
}
@end

@implementation ClientObject2
- (NSString *)foo{
  return @"food";
}
@end

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    ClientObject *cobj = [[ClientObject alloc] init];
    ClientObject2 *cobj2 = [[ClientObject2 alloc] init];

    __block NSConnection *conn;
    __block NSConnection *conn2;

    //dispatch_semaphore_t lock = dispatch_semaphore_create(0L);
    [NSThread detachNewThreadWithBlock:^{
      conn = [NSConnection serviceConnectionWithName:@"com.tekserve.IPCServ.TestService2" rootObject:cobj];
      conn2 = [NSConnection serviceConnectionWithName:@"com.tekserve.IPCServ.TestService3" rootObject:cobj2];
      //dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
      [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    }];
    ServiceObject * obj = (id)[NSConnection rootProxyForConnectionWithRegisteredName:@"com.tekserve.IPCServ.TestService" host:nil];
    //NSLog(@"client obj:%@", [obj fooClient:cobj2]);

    if (obj) {
      NSLog(@"obj2: %@", [obj getService]);
      obj.myNumber = 5;

      for (NSInteger i = 4; i <= 6; i++) {
        NSLog(@"%@", [obj getInfoCommand:i]);
      }

      [[(NSDistantObject *)obj connectionForProxy] invalidate];
    }
    else {
      NSLog(@"No Connection");
    }
    [conn invalidate];
    [conn2 invalidate];
  }
  return 0;
}

