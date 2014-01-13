#import <Foundation/Foundation.h>

@class NCInstruction;

@interface NCFrame : NSObject

@property NCInstruction* instruction;

+ (BOOL)available:(NSData*)buffer;
+ (NCFrame*)parseFromBuffer:(NSData*)buffer;

- (NCFrame*)initWithInstruction:(NCInstruction*)instruction;
- (NSData*)pack;

@end
