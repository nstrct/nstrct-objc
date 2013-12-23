#import "NSData+NCBinaryUtilities.h"

@implementation NSData (NCBinaryUtilities)

- (uint8_t)readUInt8At:(NSInteger*)position
{
  uint8_t val = *(uint8_t*)[[self subdataWithRange:NSMakeRange((*position), 1)] bytes];
  (*position) += 1;
  return val;
}

- (uint16_t)readUInt16At:(NSInteger*)position
{
  uint16_t val = CFSwapInt16BigToHost(*(uint16_t*)[[self subdataWithRange:NSMakeRange((*position), 2)] bytes]);
  (*position) += 2;
  return val;
}

- (uint32_t)readUInt32At:(NSInteger*)position
{
  uint32_t val = CFSwapInt32BigToHost(*(uint32_t*)[[self subdataWithRange:NSMakeRange((*position), 4)] bytes]);
  (*position) += 4;
  return val;
}

- (uint64_t)readUInt64At:(NSInteger*)position
{
  uint64_t val = CFSwapInt64BigToHost(*(uint64_t*)[[self subdataWithRange:NSMakeRange((*position), 8)] bytes]);
  (*position) += 8;
  return val;
}

- (int8_t)readInt8At:(NSInteger*)position
{
  int8_t val = *(int8_t*)[[self subdataWithRange:NSMakeRange((*position), 1)] bytes];
  (*position) += 1;
  return val;
}

- (int16_t)readInt16At:(NSInteger*)position
{
  int16_t val = CFSwapInt16BigToHost(*(int16_t*)[[self subdataWithRange:NSMakeRange((*position), 2)] bytes]);
  (*position) += 2;
  return val;
}

- (int32_t)readInt32At:(NSInteger*)position
{
  int32_t val = CFSwapInt32BigToHost(*(int32_t*)[[self subdataWithRange:NSMakeRange((*position), 4)] bytes]);
  (*position) += 4;
  return val;
}

- (int64_t)readInt64At:(NSInteger*)position
{
  int64_t val = CFSwapInt64BigToHost(*(int64_t*)[[self subdataWithRange:NSMakeRange((*position), 8)] bytes]);
  (*position) += 8;
  return val;
}

- (float)readFloat32At:(NSInteger*)position
{
  union { float f; uint32_t i; } swap;
  swap.i = [self readUInt32At:position];
  return swap.f;
}

- (double)readFloat64At:(NSInteger*)position
{
  union { double d; uint64_t i; } swap;
  swap.i = [self readUInt64At:position];
  return swap.d;
}

@end
