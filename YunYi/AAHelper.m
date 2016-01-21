
#import "AAHelper.h"

#import <CommonCrypto/CommonDigest.h>

@implementation AAHelper

+ (NSString *) md5:(NSString *) text
{
    const char * bytes = [text UTF8String];
    unsigned char md5Binary[16];
    CC_MD5(bytes, strlen(bytes), md5Binary);

    NSString * md5String = [NSString
                            stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            md5Binary[0], md5Binary[1], md5Binary[2], md5Binary[3],
                            md5Binary[4], md5Binary[5], md5Binary[6], md5Binary[7],
                            md5Binary[8], md5Binary[9], md5Binary[10], md5Binary[11],
                            md5Binary[12], md5Binary[13], md5Binary[14], md5Binary[15]
                            ];
    return md5String;
}

+ (NSString *) calculatePKey:(NSString *)userKey nonce:(NSString *)nonce
{
    userKey = [userKey lowercaseString];
    NSString * tmp = [userKey stringByAppendingString:nonce];
    NSString * pKey = [self md5:tmp];

    return pKey;

}

+ (NSString *) calculateUserKey:(NSString *) accountName password:(NSString *)pwd
{
    accountName = [accountName lowercaseString];
    NSString * tmp = [accountName stringByAppendingString:pwd];
    NSString * userKey = [self md5:tmp];

    return userKey;
}

+ (NSString *) calculateAccessKey:(NSString *)userTicket nonce:(NSString *)nonce
{
    userTicket = [userTicket lowercaseString];
    NSString * tmp = [nonce stringByAppendingString:userTicket];
    NSString * accessKey = [self md5:tmp];

    return accessKey;
}

@end
