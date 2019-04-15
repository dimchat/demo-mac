#import <Foundation/Foundation.h>

@interface NSString (Utility)

-(NSUInteger)occurrenceCountOfCharacter:(UniChar)character;
+(NSString *)uuidString;
-(BOOL)isNilOrEmpty;
-(NSInteger)indexOf:(NSString *)searchString;
-(NSInteger)indexOf:(NSString *)searchString fromIndex:(NSInteger)searchIndex;
-(NSArray *)nonEmptyComponentsSeparatedByString:(NSString *)seperator;
-(NSString *)trim;
-(NSString *)trimCharactersInString:(NSString *)trimString;
-(NSString *)trimStart;
-(NSString *)trimStartWithCharactersInString:(NSString *)trimString;
-(NSString *)trimEnd;
-(NSString *)trimEndWithCharactersInString:(NSString *)trimString;
-(NSString *)removeCharactersFromIndex:(NSInteger)index;
-(NSString *)removeCharactersInRange:(NSRange)range;
-(NSString *)insertString:(NSString *)string atIndex:(NSInteger)index;
-(NSArray *)trimmedComponentsSeparatedByString:(NSString *)string;
-(NSArray *)trimmedComponentsSeparatedByCharactersInSet:(NSCharacterSet *)set;
-(BOOL)isInteger;
-(BOOL)isLongLong;
-(BOOL)isFloat;
-(BOOL)isUppercase;
-(NSInteger)tagCountForString:(NSString *)tag;
-(BOOL)containsString:(NSString *)string;

-(NSString *)removeHtmlTags;
-(NSString *)removeSsaTags;

-(BOOL)isMatchRegex:(NSString *)regex;
-(NSRange)rangeOfMatchRegex:(NSString *)regex;
-(NSString *)replaceRegex:(NSString *)regex withString:(NSString *)replacement;
-(NSString *)stringAtIndex:(NSUInteger)index;

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

-(NSString *)removeLineBreaks;
-(NSArray *)splitToLines;

-(NSString *)autoBreakLine:(NSInteger)maximumLength shorterThan:(NSInteger)mergeLinesShorterThan inLanguage:(NSString *)language;
-(BOOL)canBreak:(NSInteger)index language:(NSString *)language;

@end
