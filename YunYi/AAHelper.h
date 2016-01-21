
#import <Foundation/Foundation.h>

@interface AAHelper : NSObject

+ (NSString *) md5:(NSString *) text;
+ (NSString *) calculatePKey:(NSString *)userKey nonce:(NSString *)nonce;
+ (NSString *) calculateUserKey:(NSString *) accountName password:(NSString *)pwd;
+ (NSString *) calculateAccessKey:(NSString *)userTicket nonce:(NSString *)nonce;


@end
