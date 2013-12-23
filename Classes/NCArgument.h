#import <Foundation/Foundation.h>

#import "NCValue.h"

@interface NCArgument : NSObject

@property BOOL isArray;
@property NCDatatype datatype;
@property NSMutableArray* values;

+ (NCArgument*)parseFromBuffer:(NSData*)buffer usingCursor:(NSInteger*)cursor;

- (NCArgument*)initWithDatatype:(NCDatatype)datatype andValue:(NCValue*)value;
- (NCArgument*)initWithDatatype:(NCDatatype)datatype andValues:(NSArray*)values;

- (NSData*)pack;

@end
