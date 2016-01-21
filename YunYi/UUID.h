
#import <Foundation/Foundation.h>

@interface UUID : NSObject <NSCoding, NSCopying>

- (void) encodeWithCoder:(NSCoder *) encoder;
- (id) initWithCoder:(NSCoder *) decoder;


+ (UUID *) create;
+ (UUID *) createFromString:(NSString *) string;
+ (UUID *) empty;
- (BOOL) isEmpty;

- (NSString *) toString;


@end
