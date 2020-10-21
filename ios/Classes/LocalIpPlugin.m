#import "LocalIpPlugin.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation LocalIpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"local_ip"
            binaryMessenger:[registrar messenger]];
  LocalIpPlugin* instance = [[LocalIpPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getIP" isEqualToString:call.method]) {
    NSString *ip = [self getIPAddress];
        result(ip);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

//Get IP Address
- (NSString *)getIPAddress{
    NSString *adress = @"0.0.0.0";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces; //将结构体复制给副本temp_addr
        while (temp_addr != NULL) {

            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                //check if interface is en0 which is the wifi conection on the iphone
                if ([[NSString stringWithUTF8String:temp_addr ->ifa_name] isEqualToString:@"en0"]) {
                    adress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }
            }
            temp_addr = temp_addr -> ifa_next;
        }
    }

    //Free memory
    //extern void freeifaddrs(struct ifaddrs *);
    freeifaddrs(interfaces);
    return (adress);
}

@end
