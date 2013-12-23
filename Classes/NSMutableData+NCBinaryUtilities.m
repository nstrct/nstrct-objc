#import "NSMutableData+NCBinaryUtilities.h"

@implementation NSMutableData (NCBinaryUtilities)

- (void)addUInt8:(uint8_t)value
{
  [self appendBytes:&value length:1];
}

- (void)addUInt16:(uint16_t)value
{
  uint16_t val = CFSwapInt16HostToBig(value);
  [self appendBytes:&val length:2];
}

- (void)addUInt32:(uint32_t)value
{
  uint32_t val = CFSwapInt32HostToBig(value);
  [self appendBytes:&val length:4];
}

- (void)addUInt64:(uint64_t)value
{
  uint64_t val = CFSwapInt64HostToBig(value);
  [self appendBytes:&val length:8];
}

- (void)addInt8:(int8_t)value
{
  [self appendBytes:&value length:1];
}

- (void)addInt16:(int16_t)value
{
  int16_t val = CFSwapInt16HostToBig(value);
  [self appendBytes:&val length:2];
}

- (void)addInt32:(int32_t)value
{
  int32_t val = CFSwapInt32HostToBig(value);
  [self appendBytes:&val length:4];
}

- (void)addInt64:(int64_t)value
{
  int64_t val = CFSwapInt64HostToBig(value);
  [self appendBytes:&val length:8];
}

- (void)addFloat32:(float)value
{
  union { float f; uint32_t i; } swap;
  swap.f = value;
  [self addUInt32:swap.i];
}

- (void)addFloat64:(double)value
{
  union { double d; uint64_t i; } swap;
  swap.d = value;
  [self addUInt64:swap.i];
}

@end
