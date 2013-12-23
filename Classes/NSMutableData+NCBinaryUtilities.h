#import <Foundation/Foundation.h>

@interface NSMutableData (NCBinaryUtilities)

- (void)addUInt8:(uint8_t)value;
- (void)addUInt16:(uint16_t)value;
- (void)addUInt32:(uint32_t)value;
- (void)addUInt64:(uint64_t)value;

- (void)addInt8:(int8_t)value;
- (void)addInt16:(int16_t)value;
- (void)addInt32:(int32_t)value;
- (void)addInt64:(int64_t)value;

- (void)addFloat32:(float)value;
- (void)addFloat64:(double)value;

@end
