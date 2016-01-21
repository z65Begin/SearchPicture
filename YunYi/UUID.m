
#import "UUID.h"


static UUID * emptyUUID = nil;

@implementation UUID
{
    CFUUIDRef uuidRef;
}

+ (void) initialize
{
    if(self == [UUID class])
    {
        emptyUUID = [UUID create];
    }
}

+ (UUID *) create
{
    CFUUIDRef cf = CFUUIDCreate(NULL);

    UUID * instance = [[UUID alloc] init];
    instance->uuidRef = cf;

    return instance;
}

+ (UUID *) createFromString:(NSString *) string
{
    if (string != nil)
    {
        CFStringRef cfString = (__bridge_retained CFStringRef)string;
        CFUUIDRef uuidRef = CFUUIDCreateFromString (NULL, cfString);
        CFRelease(cfString);

        UUID * instance = [[UUID alloc] init];
        instance->uuidRef = uuidRef;

        return instance;
    }
    else
    {
        return nil;
    }
}

+ (UUID *) empty
{
    return emptyUUID;
}

- (BOOL) isEmpty
{
    return [self isEqual:emptyUUID];
}

- (BOOL) isEqual:(id)object
{
    if(object != nil && [object isKindOfClass:[UUID class]])
    {
        NSString * selfString = [self toString];
        NSString * objString = [(UUID *)object toString];

        if([selfString compare:objString options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            return YES;
        }
    }

    return NO;
}

- (NSUInteger)hash
{
    return [[self description] hash];
}

- (NSString *) toString
{
    CFStringRef cfString = CFUUIDCreateString(NULL, uuidRef);
    NSString * string = (__bridge_transfer NSString *)cfString;


    return [NSString stringWithString:string];
}

- (void) dealloc
{
    if (uuidRef != NULL)
    {
        CFRelease(uuidRef);
        uuidRef = NULL;
    }
}


- (NSString *) description
{
    return [self toString];
}

- (id)copyWithZone:(NSZone *)zone
{
    UUID * newInstance = [UUID createFromString:[self toString]];

    return newInstance;
}

#pragma mark * NSCoding
- (void) encodeWithCoder:(NSCoder *) encoder
{
    NSString * value = [self toString];
    [encoder encodeObject:value forKey:@"value"];
}

- (id) initWithCoder:(NSCoder *) decoder
{
    self = [super init];
    if(self != nil)
    {
        NSString * value = [decoder decodeObjectForKey:@"value"];
        assert(value != nil);

        CFStringRef cfString = (__bridge_retained CFStringRef)value;
        CFUUIDRef ref = CFUUIDCreateFromString (NULL, cfString);
        CFRelease(cfString);

        self->uuidRef = ref;
    }

    return self;
}

@end
