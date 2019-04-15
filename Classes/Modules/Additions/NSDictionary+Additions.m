#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)


- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) ? defaultValue : [[self objectForKey:key] boolValue];
}

- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(double)defaultValue {
    return ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) ? [NSNumber numberWithDouble:defaultValue] : [NSNumber numberWithDouble:[[self objectForKey:key] doubleValue]];
}

- (NSDate *)getDateValueForKey:(NSString *)key defaultValue:(NSDate *)defaultValue{
    
    return ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) ? defaultValue : [NSDate dateWithTimeIntervalSince1970:[[self objectForKey:key] doubleValue]];
    
}

- (NSDate *)getDateValueForKey:(NSString *)key dateFormat:(NSString *)format defaultValue:(NSDate *)defaultValue {
    
    if (([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null])) {
        return defaultValue;
    }
    
    NSString *dateString = [self objectForKey:key];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
    
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
	return ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) ? defaultValue : [[self objectForKey:key] intValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
	NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
	struct tm created;
    time_t now;
    time(&now);
    
	if (stringTime) {
		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
		return mktime(&created);
	}
	return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
	return ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]) ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    
    id object = [self objectForKey:key];
    
    NSString *result = nil;
    
    if(object == nil || object == [NSNull null] || ![object isKindOfClass:[NSString class]]){
        result = defaultValue;
    }else{
        result = (NSString *)object;
    }
    
	return  result;
}

- (double)getDoubleValueValueForKey:(NSString *)key defaultValue:(double)defaultValue{
    
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [[self objectForKey:key] doubleValue];
}

- (NSArray *)getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue{
    
    id object = [self objectForKey:key];
    
    return object == nil || object == [NSNull null] || ![object isKindOfClass:[NSArray class]] ? defaultValue : object;
}

- (NSDictionary *)getDictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue{
    
    id object = [self objectForKey:key];
    
    return object == nil || object == [NSNull null] || ![object isKindOfClass:[NSDictionary class]] ? defaultValue : object;
}

@end

@implementation NSMutableDictionary (Additions)

- (void)setObject:(NSObject *)o forKey:(NSString *)key defaultValue:(NSObject *)defaultValue {
    
    if(o == nil || o == [NSNull null]){
        [self setObject:defaultValue forKey:key];
    }else{
        [self setObject:o forKey:key];
    }
}

@end
