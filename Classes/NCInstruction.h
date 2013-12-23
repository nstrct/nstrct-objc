#import <Foundation/Foundation.h>

@interface NCInstruction : NSObject

@property NSInteger code;
@property NSMutableArray* arguments;

+ (NCInstruction*)parseFromBuffer:(NSData*)buffer;

- (NCInstruction*)initWithCode:(NSInteger)code;
- (NCInstruction*)initWithCode:(NSInteger)code andArguments:(NSArray*)arguments;

- (NSInteger)countTotalArrayElements;

- (NSData*)pack;

@end
