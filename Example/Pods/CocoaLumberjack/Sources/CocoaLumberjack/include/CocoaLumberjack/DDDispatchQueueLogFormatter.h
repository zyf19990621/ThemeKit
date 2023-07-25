// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2023, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import <Foundation/Foundation.h>

// Disable legacy macros
#ifndef DD_LEGACY_MACROS
    #define DD_LEGACY_MACROS 0
#endif

#import <CocoaLumberjack/DDLog.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Log formatter mode
 */
__attribute__((deprecated("DDDispatchQueueLogFormatter is always shareable")))
typedef NS_ENUM(NSUInteger, DDDispatchQueueLogFormatterMode){
    /**
     *  This is the default option, means the formatter can be reused between multiple loggers and therefore is thread-safe.
     *  There is, of course, a performance cost for the thread-safety
     */
    DDDispatchQueueLogFormatterModeShareble = 0,
    /**
     *  If the formatter will only be used by a single logger, then the thread-safety can be removed
     *  @note: there is an assert checking if the formatter is added to multiple loggers and the mode is non-shareble
     */
    DDDispatchQueueLogFormatterModeNonShareble,
};

/**
 * Quality of Service names.
 *
 * Since macOS 10.10 and iOS 8.0, pthreads, dispatch queues and NSOperations express their
 * scheduling priority by using an abstract classification called Quality of Service (QOS).
 *
 * This formatter will add a representation of this QOS in the log message by using those
 * string constants.
 * For example:
 *
 * `2011-10-17 20:21:45.435 AppName[19928:5207 (QOS:DF)] Your log message here`
 *
 * Where QOS is one of:
 * `- UI = User Interactive`
 * `- IN = User Initiated`
 * `- DF = Default`
 * `- UT = Utility`
 * `- BG = Background`
 * `- UN = Unspecified`
 *
 * Note: QOS will be absent in the log messages if running on OS versions that don't support it.
 **/
typedef NSString * DDQualityOfServiceName NS_STRING_ENUM;

FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceUserInteractive NS_SWIFT_NAME(DDQualityOfServiceName.userInteractive) API_AVAILABLE(macos(10.10), ios(8.0));
FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceUserInitiated NS_SWIFT_NAME(DDQualityOfServiceName.userInitiated) API_AVAILABLE(macos(10.10), ios(8.0));
FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceDefault NS_SWIFT_NAME(DDQualityOfServiceName.default) API_AVAILABLE(macos(10.10), ios(8.0));
FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceUtility NS_SWIFT_NAME(DDQualityOfServiceName.utility) API_AVAILABLE(macos(10.10), ios(8.0));
FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceBackground NS_SWIFT_NAME(DDQualityOfServiceName.background) API_AVAILABLE(macos(10.10), ios(8.0));
FOUNDATION_EXPORT DDQualityOfServiceName const DDQualityOfServiceUnspecified NS_SWIFT_NAME(DDQualityOfServiceName.unspecified) API_AVAILABLE(macos(10.10), ios(8.0));

/**
 * This class provides a log formatter that prints the dispatch_queue label instead of the mach_thread_id.
 *
 * A log formatter can be added to any logger to format and/or filter its output.
 * You can learn more about log formatters here:
 * Documentation/CustomFormatters.md
 *
 * A typical `NSLog` (or `DDTTYLogger`) prints detailed info as `[<process_id>:<thread_id>]`.
 * For example:
 *
 * `2011-10-17 20:21:45.435 AppName[19928:5207] Your log message here`
 *
 * Where:
 * `- 19928 = process id`
 * `-  5207 = thread id (mach_thread_id printed in hex)`
 *
 * When using grand central dispatch (GCD), this information is less useful.
 * This is because a single serial dispatch queue may be run on any thread from an internally managed thread pool.
 * For example:
 *
 * `2011-10-17 20:32:31.111 AppName[19954:4d07] Message from my_serial_dispatch_queue`
 * `2011-10-17 20:32:31.112 AppName[19954:5207] Message from my_serial_dispatch_queue`
 * `2011-10-17 20:32:31.113 AppName[19954:2c55] Message from my_serial_dispatch_queue`
 *
 * This formatter allows you to replace the standard `[box:info]` with the dispatch_queue name.
 * For example:
 *
 * `2011-10-17 20:32:31.111 AppName[img-scaling] Message from my_serial_dispatch_queue`
 * `2011-10-17 20:32:31.112 AppName[img-scaling] Message from my_serial_dispatch_queue`
 * `2011-10-17 20:32:31.113 AppName[img-scaling] Message from my_serial_dispatch_queue`
 *
 * If the dispatch_queue doesn't have a set name, then it falls back to the thread name.
 * If the current thread doesn't have a set name, then it falls back to the mach_thread_id in hex (like normal).
 *
 * Note: If manually creating your own background threads (via `NSThread/alloc/init` or `NSThread/detachNeThread`),
 * you can use `[[NSThread currentThread] setName:(NSString *)]`.
 **/
@interface DDDispatchQueueLogFormatter : NSObject <DDLogFormatter>

/**
 * Standard init method.
 * Configure using properties as desired.
 **/
- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 *  Initializer with ability to set the queue mode
 *
 *  @param mode choose between DDDispatchQueueLogFormatterModeShareble and DDDispatchQueueLogFormatterModeNonShareble, depending if the formatter is shared between several loggers or not
 */
- (instancetype)initWithMode:(DDDispatchQueueLogFormatterMode)mode __attribute__((deprecated("DDDispatchQueueLogFormatter is always shareable")));

/**
 * The minQueueLength restricts the minimum size of the [detail box].
 * If the minQueueLength is set to 0, there is no restriction.
 *
 * For example, say a dispatch_queue has a label of "diskIO":
 *
 * If the minQueueLength is 0: [diskIO]
 * If the minQueueLength is 4: [diskIO]
 * If the minQueueLength is 5: [diskIO]
 * If the minQueueLength is 6: [diskIO]
 * If the minQueueLength is 7: [diskIO ]
 * If the minQueueLength is 8: [diskIO  ]
 *
 * The default minQueueLength is 0 (no minimum, so [detail box] won't be padded).
 *
 * If you want every [detail box] to have the exact same width,
 * set both minQueueLength and maxQueueLength to the same value.
 **/
@property (assign, atomic) NSUInteger minQueueLength;

/**
 * The maxQueueLength restricts the number of characters that will be inside the [detail box].
 * If the maxQueueLength is 0, there is no restriction.
 *
 * For example, say a dispatch_queue has a label of "diskIO":
 *
 * If the maxQueueLength is 0: [diskIO]
 * If the maxQueueLength is 4: [disk]
 * If the maxQueueLength is 5: [diskI]
 * If the maxQueueLength is 6: [diskIO]
 * If the maxQueueLength is 7: [diskIO]
 * If the maxQueueLength is 8: [diskIO]
 *
 * The default maxQueueLength is 0 (no maximum, so [detail box] won't be truncated).
 *
 * If you want every [detail box] to have the exact same width,
 * set both minQueueLength and maxQueueLength to the same value.
 **/
@property (assign, atomic) NSUInteger maxQueueLength;

/**
 * Sometimes queue labels have long names like "com.apple.main-queue",
 * but you'd prefer something shorter like simply "main".
 *
 * This method allows you to set such preferred replacements.
 * The above example is set by default.
 *
 * To remove/undo a previous replacement, invoke this method with nil for the 'shortLabel' parameter.
 **/
- (nullable NSString *)replacementStringForQueueLabel:(NSString *)longLabel;

/**
 *  See the `replacementStringForQueueLabel:` description
 */
- (void)setReplacementString:(nullable NSString *)shortLabel forQueueLabel:(NSString *)longLabel;

@end

/**
 *  Category on `DDDispatchQueueLogFormatter` to make method declarations easier to extend/modify
 **/
@interface DDDispatchQueueLogFormatter (OverridableMethods)

/**
 *  Date formatter default configuration
 */
- (void)configureDateFormatter:(NSDateFormatter *)dateFormatter;

/**
 *  Formatter method to transfrom from date to string
 */
- (NSString *)stringFromDate:(NSDate *)date;

/**
 *  Method to compute the queue thread label
 */
- (NSString *)queueThreadLabelForLogMessage:(DDLogMessage *)logMessage;

@end

#pragma mark - DDAtomicCountable

__attribute__((deprecated("DDAtomicCountable is useless since DDDispatchQueueLogFormatter is always shareable now")))
@protocol DDAtomicCountable <NSObject>

- (instancetype)initWithDefaultValue:(int32_t)defaultValue;
- (int32_t)increment;
- (int32_t)decrement;
- (int32_t)value;

@end

__attribute__((deprecated("DDAtomicCountable is deprecated")))
@interface DDAtomicCounter: NSObject<DDAtomicCountable>
@end

NS_ASSUME_NONNULL_END
