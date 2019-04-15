/*
 *  Log.h
 *  Handbook
 *
 *  Created by Samson on 9/9/09.
 *  Copyright 2009 InfoThinker. All rights reserved.
 *
 */

#ifndef __LOG_H__
#define __LOG_H__

#define _VERBOSE_QUIET    0
#define _VERBOSE_ERR      1
#define _VERBOSE_BUG      2
#define _VERBOSE_INFO     3
#define _VERBOSE_WARN     4
#define _VERBOSE_DBG      5
#define _VERBOSE_MAX      10

//#define VERBOSE_LEVEL _VERBOSE_MAX

#if DEBUG == 1
#define VERBOSE_LEVEL _VERBOSE_MAX
#else
#define VERBOSE_LEVEL _VERBOSE_QUIET
#endif

#ifndef VERBOSE_LEVEL
#define VERBOSE_LEVEL _VERBOSE_QUIET
#warning "You should define VERBOSE_LEVEL before include Log.h
#endif

#define FORMATTED_LOG(level, msg, ...)                                        \
{                                                                             \
	/*NSString * fileName                                                     \
		= [[NSString stringWithUTF8String:__FILE__] lastPathComponent];       \
	NSLog(@"<%s @ %@: %d> " level msg, __FUNCTION__, fileName,                \
		__LINE__, ##__VA_ARGS__); */                                          \
	NSLog(@"%s " level msg, __FUNCTION__, ##__VA_ARGS__);                     \
} 

#define LEVEL_LOG(level, msg, ...) NSLog(level msg, ##__VA_ARGS__)


#if VERBOSE_LEVEL >= _VERBOSE_ERR
#define ERR(msg, ...) FORMATTED_LOG(@"ERR: ", msg, ## __VA_ARGS__)
#else
#define ERR(msg, ...) /* NOTHING */
#endif

#if VERBOSE_LEVEL >= _VERBOSE_BUG
#define BUG(msg, ...) FORMATTED_LOG(@"BUG: ", msg, ## __VA_ARGS__)
#else
#define BUG(msg, ...) /* NOTHING */
#endif

#if VERBOSE_LEVEL >= _VERBOSE_INFO
#define INFO(msg, ...) FORMATTED_LOG(@"INFO: ", msg, ## __VA_ARGS__)
#else
#define INFO(msg, ...) /* NOTHING */
#endif

#if VERBOSE_LEVEL >= _VERBOSE_WARN
#define WARN(msg, ...) FORMATTED_LOG(@"WARN: ", msg, ## __VA_ARGS__)
#else
#define WARN(msg, ...) /* NOTHING */
#endif

#if VERBOSE_LEVEL >= _VERBOSE_DBG
#define DBG(msg, ...) FORMATTED_LOG(@"DBG: ", msg, ## __VA_ARGS__)
//#define DBG(msg, ...) LEVEL_LOG(@"DBG: ", msg, ## __VA_ARGS__)
#else
#define DBG(msg, ...) /* NOTHING */
#endif

#endif