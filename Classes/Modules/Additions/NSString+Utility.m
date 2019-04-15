//
//  NSString+Utility.m
//  SRTEdit
//
//  Created by alex on 6/22/14.
//  Copyright (c) 2014 alex. All rights reserved.
//

#import "NSString+Utility.h"
#import "Log.h"

@implementation NSString (Utility)

- (NSUInteger)occurrenceCountOfCharacter:(UniChar)character
{
    CFStringRef selfAsCFStr = (__bridge CFStringRef)self;
    
    CFStringInlineBuffer inlineBuffer;
    CFIndex length = CFStringGetLength(selfAsCFStr);
    CFStringInitInlineBuffer(selfAsCFStr, &inlineBuffer, CFRangeMake(0, length));
    
    NSUInteger counter = 0;
    
    for (CFIndex i = 0; i < length; i++) {
        UniChar c = CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i);
        if (c == character) counter += 1;
    }
    
    return counter;
}

+(NSString *)uuidString {
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}

-(BOOL)isNilOrEmpty{
    
    if(self != nil && [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0 && [self isEqualTo:[NSNull null]] == NO){
        
        return NO;
    }
    
    return YES;
}

-(NSInteger)indexOf:(NSString *)searchString{
    
    NSRange range = [self rangeOfString:searchString];
    return range.location;
}

-(NSInteger)indexOf:(NSString *)searchString fromIndex:(NSInteger)searchIndex{
    
    NSRange searchRange = NSMakeRange(searchIndex, self.length - searchIndex);
    NSRange range = [self rangeOfString:searchString options:0 range:searchRange];
    
    return range.location;
}

-(NSArray *)nonEmptyComponentsSeparatedByString:(NSString *)seperator{
    
    NSArray *array = [self componentsSeparatedByString:seperator];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for(NSString *string in array){
        
        if([string isNilOrEmpty] == NO){
            [result addObject:string];
        }
    }
    
    return result;
}

-(NSString *)trim{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)trimCharactersInString:(NSString *)trimString{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trimString]];
}

-(NSString *)trimStart{
    
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)trimStartWithCharactersInString:(NSString *)trimString{
    
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trimString]];
}

-(NSString *)trimEnd{
    
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)trimEndWithCharactersInString:(NSString *)trimString{
    
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trimString]];
}

-(NSArray *)trimmedComponentsSeparatedByString:(NSString *)string{
    
    NSArray *array = [self componentsSeparatedByString:string];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for(NSString *s in array){
        
        if(s != nil && [s isNilOrEmpty] == NO){
            [resultArray addObject:s];
        }
    }
    
    return resultArray;
}

-(NSArray *)trimmedComponentsSeparatedByCharactersInSet:(NSCharacterSet *)set{
    
    NSArray *array = [self componentsSeparatedByCharactersInSet:set];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for(NSString *s in array){
        
        if(s != nil && [s isNilOrEmpty] == NO){
            [resultArray addObject:s];
        }
    }
    
    return resultArray;
}

-(NSString *)removeCharactersFromIndex:(NSInteger)index{
    
    NSMutableString *s = [[NSMutableString alloc] initWithString:self];
    [s deleteCharactersInRange:NSMakeRange(index, self.length - index)];
    
    return s;
}

-(NSString *)removeCharactersInRange:(NSRange)range{
    
    NSMutableString *s = [[NSMutableString alloc] initWithString:self];
    [s deleteCharactersInRange:range];
    return s;
}

-(NSString *)insertString:(NSString *)string atIndex:(NSInteger)index{
    
    NSMutableString *s = [[NSMutableString alloc] initWithString:self];
    [s insertString:string atIndex:index];
    
    return s;
}

-(BOOL)isInteger{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    return [scanner scanInteger:nil];
}

-(BOOL)isFloat{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    return [scanner scanFloat:nil];
}

-(BOOL)isLongLong{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    return [scanner scanLongLong:nil];
}

-(BOOL)isUppercase{
    
    BOOL isUppercase = YES;
    
    NSCharacterSet *uppercaseChracterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    
    for(NSUInteger i=0;i<[self length];i++){
    
        isUppercase = [uppercaseChracterSet characterIsMember:[self characterAtIndex:i]];
        
        if(isUppercase == NO){
            break;
        }
    }
    
    return isUppercase;
}

-(NSInteger)tagCountForString:(NSString *)tag{
    
    NSInteger count = 0;
    
    if([self length] > 0){
    
        NSInteger fromIndex = 0;
        
        while(fromIndex != NSNotFound){
            fromIndex = [self indexOf:tag fromIndex:fromIndex + tag.length];
            count ++;
        }
    }
    
    return count;
}

-(BOOL)containsString:(NSString *)string{
    
    NSRange r = [self rangeOfString:string];
    
    if(r.location == NSNotFound){
        return NO;
    }
    
    return YES;
}

-(NSString *)removeSsaTags
{
    NSString *s = [NSString stringWithFormat:@"%@", self];
    NSInteger k = [s indexOf:@"{"];
    while(k != NSNotFound){
        
        NSInteger l = [s indexOf:@"}" fromIndex:k];
        
        if(l > k){
            s = [s removeCharactersInRange:NSMakeRange(k, l - k + 1)];
            
            if([s length] > 1 && [s length] > k){
                k = [s indexOf:@"{" fromIndex:k];
            }else{
                break;
            }
        }else{
            break;
        }
    }
    
    return s;
}

-(NSString *)removeHtmlTags{
    NSRange r;
    NSString *s = self;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    return s;
}

-(BOOL)isMatchRegex:(NSString *)regex{
    
    NSRange r = [self rangeOfMatchRegex:regex];
    
    if(r.location != NSNotFound){
        return YES;
    }
    
    return NO;
}

-(NSRange)rangeOfMatchRegex:(NSString *)regex{
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
    NSRange matchRange = [expression rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    
    return matchRange;
}

-(NSString *)replaceRegex:(NSString *)regex withString:(NSString *)replacement{
    
    return [self stringByReplacingOccurrencesOfString:regex withString:replacement options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

-(NSString *)stringAtIndex:(NSUInteger)index{
    
    NSString *s = @"";
    
    if(index < [self length]){
        s = [self substringWithRange:NSMakeRange(index, 1)];
    }
    
    return s;
}

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

-(NSArray *)splitToLines{
    
    return [self trimmedComponentsSeparatedByString:@"\n"];
}

-(NSString *)removeLineBreaks
{
    
    //s = HtmlUtil.FixUpperTags(s);
    NSString *s = self;
    s = [s stringByReplacingOccurrencesOfString:@"\n</i>" withString:@"</i>\n"];
    s = [s stringByReplacingOccurrencesOfString:@"\n</b>" withString:@"</b>\n"];
    s = [s stringByReplacingOccurrencesOfString:@"\n</u>" withString:@"</u>\n"];
    s = [s stringByReplacingOccurrencesOfString:@"\n</font>" withString:@"</font>\n"];
    s = [s stringByReplacingOccurrencesOfString:@"</i> \n<i>" withString:@" "];
    s = [s stringByReplacingOccurrencesOfString:@"</i>\n <i>" withString:@" "];
    s = [s stringByReplacingOccurrencesOfString:@"</i>\n<i>" withString:@" "];
    s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    s = [s stringByReplacingOccurrencesOfString:@" </i>" withString:@"</i> "];
    s = [s stringByReplacingOccurrencesOfString:@" </b>" withString:@"</b> "];
    s = [s stringByReplacingOccurrencesOfString:@" </u>" withString:@"</u> "];
    s = [s stringByReplacingOccurrencesOfString:@" </font>" withString:@"</font> "];
    
    //s = s.FixExtraSpaces();
    return [s trim];
}

-(NSString *)autoBreakLine:(NSInteger)maximumLength shorterThan:(NSInteger)mergeLinesShorterThan inLanguage:(NSString *)language{
    
    if(self == nil || [self length] < 3){
        return self;
    }
    
    if([self containsString:@"-"] && [self containsString:@"\n"]){
        NSArray *noTagLines = [[self removeHtmlTags] splitToLines];
        
        if([noTagLines count] == 2){
            
            NSString *arr0 = [[[[noTagLines[0] trim] trimEndWithCharactersInString:@"\""] trimEndWithCharactersInString:@"'"] trimEnd];
            NSString *lastArr0String = [arr0 stringAtIndex:[arr0 length] - 1];
            NSString *arr1 = [noTagLines[1] trimStart];
            NSString *charString = @".?!)]";
            
            if(([arr0 hasPrefix:@"-"] && [arr1 hasPrefix:@"-"] && [arr0 length] > 1 && [charString containsString:lastArr0String]) || [arr0 hasSuffix:@"--"] || [arr0 hasSuffix:@"-"]){
                return self;
            }
        }
    }
    
    NSString *s = [self removeLineBreaks];
    NSString *noTagText = [s removeHtmlTags];
    
    if([noTagText length] < mergeLinesShorterThan){
        
        NSArray *lines = [self splitToLines];
        if([lines count] > 1){
            
            BOOL isDialog = YES;
            for(NSString *line in lines){
                NSString *noTagLine = [[line removeHtmlTags] trim];
                isDialog = isDialog && ([noTagLine hasPrefix:@"-"] || [noTagLine hasPrefix:@"-"]);
            }
            
            if(isDialog){
                return self;
            }
        }
        
        return s;
    }
    
    NSMutableDictionary *htmlTags = [[NSMutableDictionary alloc] init];
    NSMutableString *sb = [[NSMutableString alloc] init];
    NSInteger six = 0;
    
    while(six < [s length]){
        
        NSString *letter = [s stringAtIndex:six];
        NSString *sixString = [[s substringFromIndex:six] lowercaseString];
        BOOL tagFound = ([letter isEqualToString:@"<"] &&
                         (
                         [sixString hasPrefix:@"<font"] ||
                         [sixString hasPrefix:@"</font"] ||
                         [sixString hasPrefix:@"<u"] ||
                         [sixString hasPrefix:@"</u"] ||
                         [sixString hasPrefix:@"<b"] ||
                         [sixString hasPrefix:@"</b"] ||
                         [sixString hasPrefix:@"<i"] ||
                         [sixString hasPrefix:@"</i"]
                         )
                         );
        
        NSInteger endIndex = NSNotFound;
        
        if(tagFound){
            endIndex = [s indexOf:@">" fromIndex:six+1];
        }
        
        if(tagFound && endIndex != NSNotFound){
            
            NSString *tag = [s substringWithRange:NSMakeRange(six, endIndex - six + 1)];
            s = [s removeCharactersInRange:NSMakeRange(six, tag.length)];
            
            NSString *sixKey = [NSString stringWithFormat:@"%ld", six];
            if([[htmlTags allKeys] containsObject:sixKey]){
                NSString *oldValue = [htmlTags objectForKey:sixKey];
                NSString *newValue = [NSString stringWithFormat:@"%@%@", oldValue, tag];
                [htmlTags setObject:newValue forKey:sixKey];
            }else{
                [htmlTags setObject:tag forKey:sixKey];
            }
            
        }else{
            
            [sb appendString:letter];
            six++;
        }
    }
    
    s = sb;

    NSInteger splitPos = NSNotFound;
    NSInteger mid = [s length] / 2;
    
    if([s containsString:@" - "]){
        
        for(NSUInteger j=0;j<= (maximumLength / 2) + 5; j++){
            
            if(mid + j + 4 < [s length]){
                
                if([[s stringAtIndex:mid + j] isEqualToString:@"-"] &&
                   [[s stringAtIndex:mid + j + 1] isEqualToString:@" "] &&
                   [[s stringAtIndex:mid + j - 1] isEqualToString:@" "]){
                    
                    NSString *rest = [[s substringFromIndex:mid+j+1] trimStart];
                    
                    if([rest length] > 0 && [[rest stringAtIndex:0] isUppercase]){
                        splitPos = mid + j;
                        break;
                    }
                }
            }
            
            if(mid - (j + 1) > 4){
                
                if([[s stringAtIndex:mid - j] isEqualToString:@"-"] &&
                   [[s stringAtIndex:mid - j + 1] isEqualToString:@" "] &&
                   [[s stringAtIndex:mid - j - 1] isEqualToString:@" "]){
                    
                    NSString *rest = [[s substringFromIndex:mid - j + 1] trimStart];
                    
                    if([rest length] > 0 && [[rest stringAtIndex:0] isUppercase]){
                        
                        NSString *charString = @"!?.";
                        if(mid - j > 5 && [[s stringAtIndex:mid - j - 1] isEqualToString:@" "] &&
                           [charString containsString:[s stringAtIndex:mid - j - 2]]){
                            splitPos = mid - j;
                            break;
                        }
                    }
                }
            }
        }
    }
    
    if(splitPos == maximumLength + 1 && [[s stringAtIndex:maximumLength] isEqualToString:@" "] == NO){
        splitPos = NSNotFound;
    }
    
    if(splitPos == NSNotFound){
        
        for(NSUInteger j=0;j<15;j++){
            
            if(mid + j + 1 < [s length] && mid + j > 0){
                
                NSString *charString = @"!?.";
                
                if([charString containsString:[s stringAtIndex:mid + j]] &&
                   [s isPartOfNumber:mid + j] && [s canBreak:mid + j + 1 language:language]){
                    
                    splitPos = mid + j + 1;
                    
                    NSString *digitAndCharString = @".!?0123456789";
                    if([digitAndCharString containsString:[s stringAtIndex:splitPos]]){
                        
                        splitPos ++;
                        if([digitAndCharString containsString:[s stringAtIndex:mid + j + 1]]){
                            splitPos ++;
                        }
                    }
                    break;
                }
                
                if([charString containsString:[s stringAtIndex:mid - j]] &&
                   [s isPartOfNumber:mid - j] && [s canBreak:mid - j language:language]){
                    
                    splitPos = mid - j;
                    splitPos ++;
                    break;
                }
            }
        }
    }
    
    if(splitPos > maximumLength){
        
        if(splitPos != maximumLength + 1 || [[s stringAtIndex:maximumLength] isEqualToString:@" "] == NO){
            splitPos = NSNotFound;
        }
        
    }else if(splitPos != NSNotFound && [s length] - splitPos > maximumLength){
        splitPos = NSNotFound;
    }
    
    if(splitPos == NSNotFound){
        
        for(NSUInteger j=0;j<25;j++){
            
            if(mid + j + 1 < [s length] && mid + j > 0){
                
                NSString *charString = @".!?, ";
                NSString *noCommentCharString = @" .!?";
                if([charString containsString:[s stringAtIndex:mid + j]] &&
                   [s isPartOfNumber:mid + j] == NO &&
                   [s length] > mid + j + 2 &&
                   [s canBreak:mid + j language:language]){
                    
                    splitPos = mid + j;
                    
                    if([noCommentCharString containsString:[s stringAtIndex:mid + j + 1]]){
                        
                        splitPos ++;
                        if([noCommentCharString containsString:[s stringAtIndex:mid + j + 2]]){
                            splitPos ++;
                        }
                    }
                    
                    break;
                }
                
                noCommentCharString = @".!?";
                if([charString containsString:[s stringAtIndex:mid - j]] &&
                   [s isPartOfNumber:mid - j] == NO &&
                   [s length] > mid + j + 2 &&
                   [s canBreak:mid - j language:language]){
                    
                    splitPos = mid - j;
                    
                    if([noCommentCharString containsString:[s stringAtIndex:splitPos]]){
                        splitPos --;
                    }
                    if([noCommentCharString containsString:[s stringAtIndex:splitPos]]){
                        splitPos --;
                    }
                    if([noCommentCharString containsString:[s stringAtIndex:splitPos]]){
                        splitPos --;
                    }
                    
                    break;
                }
            }
        }
    }
    
    if(splitPos == NSNotFound){
        
        splitPos = mid;
        s = [s insertString:@"\n" atIndex:mid-1];
        s = [s reinsertHtmlTags:htmlTags];
        htmlTags = [[NSMutableDictionary alloc] init];
        s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@"-"];
    }
    
    if(splitPos < [s length] - 2){
        
        s = [NSString stringWithFormat:@"%@\n%@", [s substringWithRange:NSMakeRange(0, splitPos)], [s substringFromIndex:splitPos]];
    }
    
    s = [s reinsertHtmlTags:htmlTags];
    s = [s stringByReplacingOccurrencesOfString:@" \n" withString:@"\n"];
    s = [s stringByReplacingOccurrencesOfString:@"\n " withString:@"\n"];
    
    return [s trimEnd];
}

-(BOOL)isPartOfNumber:(NSInteger)position{

    if([self isNilOrEmpty] || position + 1 >= [self length]){
        return NO;
    }
    
    NSString *charString = @",.";
    if(position > 0 && [charString containsString:[self stringAtIndex:position]]){
        return [[self stringAtIndex:position - 1] isInteger] && [[self stringAtIndex:position + 1] isInteger];
    }
    
    return NO;
}

-(BOOL)canBreak:(NSInteger)index language:(NSString *)language{
    
    NSString *nextChar = @" ";
    if (index >= 0 && index < self.length)
        nextChar = [self stringAtIndex:index];
    else
        return NO;
    
    NSString *charString = @"\r\n\t ";
    if([charString containsString:nextChar] == NO){
        return NO;
    }

    NSString *s2 = [self substringWithRange:NSMakeRange(0, index)];

//    if (Configuration.Settings.Tools.UseNoLineBreakAfter)
//    {
//        foreach (NoBreakAfterItem ending in NoBreakAfterList(language))
//        {
//            if (ending.IsMatch(s2))
//                return false;
//        }
//    }
    
    if([s2 hasSuffix:@"? -"] || [s2 hasSuffix:@"! -"] || [s2 hasSuffix:@". -"]){
        return NO;
    }
    
    return YES;
}

-(NSString *)reinsertHtmlTags:(NSDictionary *)htmlTags{

    NSString *s = self;
    if([htmlTags count] > 0){
        
        NSMutableString *sb = [[NSMutableString alloc] init];
        NSInteger six = 0;
        
        for(NSUInteger i=0;i<[s length];i++){
            
            NSString *letter = [s stringAtIndex:i];
            NSString *sixKey = [NSString stringWithFormat:@"%ld", six];
            
            if([letter isEqualToString:@"\n"]){
                [sb appendString:letter];
            }else{
                
                if([[htmlTags allKeys] containsObject:sixKey]){
                    [sb appendString:[htmlTags objectForKey:sixKey]];
                }
                
                [sb appendString:letter];
                six++;
            }
        }
        
        NSString *sixKey = [NSString stringWithFormat:@"%ld", six];
        if([[htmlTags allKeys] containsObject:sixKey]){
            [sb appendString:[htmlTags objectForKey:sixKey]];
        }
        
        s = sb;
    }

    return s;
}

@end
