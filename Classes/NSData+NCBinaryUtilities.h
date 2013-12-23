#import <Foundation/Foundation.h>

@interface NSData (NCBinaryUtilities)

- (uint8_t)readUInt8At:(NSInteger*)position;
- (uint16_t)readUInt16At:(NSInteger*)position;
- (uint32_t)readUInt32At:(NSInteger*)position;
- (uint64_t)readUInt64At:(NSInteger*)position;

- (int8_t)readInt8At:(NSInteger*)position;
- (int16_t)readInt16At:(NSInteger*)position;
- (int32_t)readInt32At:(NSInteger*)position;
- (int64_t)readInt64At:(NSInteger*)position;

- (float)readFloat32At:(NSInteger*)position;
- (double)readFloat64At:(NSInteger*)position;

@end
