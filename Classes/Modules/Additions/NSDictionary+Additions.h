#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (double)getDoubleValueValueForKey:(NSString *)key defaultValue:(double)defaultValue;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(double)defaultValue;
- (NSDate *)getDateValueForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)getDateValueForKey:(NSString *)key dateFormat:(NSString *)format defaultValue:(NSDate *)defaultValue;

- (NSArray *)getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)getDictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;


@end


@interface NSMutableDictionary (Additions)

- (void)setObject:(NSObject *)o forKey:(NSString *)key defaultValue:(NSObject *)defaultValue;

@end
