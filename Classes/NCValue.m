#import "NCValue.h"

#import "NSData+NCBinaryUtilities.h"
#import "NSMutableData+NCBinaryUtilities.h"

@implementation NCValue

+ (NCValue *)parseDatatype:(NCDatatype)datatype fromBuffer:(NSData *)buffer usingCursor:(NSInteger *)cursor
{
  switch (datatype) {
    case NCDatatypeBoolean:
      return [[NCValue alloc] initWithBoolen:[[NSNumber numberWithUnsignedChar:[buffer readUInt8At:cursor]] boolValue]];
    case NCDatatypeUInt8:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedChar:[buffer readUInt8At:cursor]]];
    case NCDatatypeUInt16:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedShort:[buffer readUInt16At:cursor]]];
    case NCDatatypeUInt32:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedInt:[buffer readUInt32At:cursor]]];
    case NCDatatypeUInt64:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedLongLong:([buffer readUInt64At:cursor])]];
    case NCDatatypeInt8:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithChar:[buffer readInt8At:cursor]]];
    case NCDatatypeInt16:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithShort:[buffer readInt16At:cursor]]];
    case NCDatatypeInt32:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithInt:[buffer readInt32At:cursor]]];
    case NCDatatypeInt64:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithLongLong:[buffer readInt64At:cursor]]];
    case NCDatatypeFloat32:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithFloat:[buffer readFloat32At:cursor]]];
    case NCDatatypeFloat64:
      return [[NCValue alloc] initWithNumber:[NSNumber numberWithDouble:[buffer readFloat64At:cursor]]];
    case NCDatatypeString: {
      uint8_t length = [buffer readUInt8At:cursor];
      NCValue* value = [[NCValue alloc] initWithString:[[NSString alloc] initWithData:[buffer subdataWithRange:NSMakeRange(*cursor, length)] encoding:NSUTF8StringEncoding]];
      (*cursor) += length;
      return value;
    }
    default:
      [NSException raise:@"Datatype can't be parsed directly" format:@"datatype: %i", datatype];
      break;
  }
  return [[NCValue alloc] init];
}

- (NCValue *)initWithBoolen:(BOOL)boolean
{
  self = [self init];
  if(self) {
    self.booleanValue = boolean;
  }
  return self;
}

- (NCValue *)initWithNumber:(NSNumber *)number
{
  self = [self init];
  if(self) {
    self.numberValue = number;
  }
  return self;
}

- (NCValue *)initWithString:(NSString *)string
{
  self = [self init];
  if(self) {
    self.stringValue = string;
  }
  return self;
}

- (NSData *)packAsDatatype:(NCDatatype)datatype
{
  NSMutableData* buffer = [[NSMutableData alloc] init];

  switch (datatype) {
    case NCDatatypeBoolean: [buffer addUInt8:self.booleanValue]; break;
    case NCDatatypeUInt8: [buffer addUInt8:self.numberValue.unsignedCharValue]; break;
    case NCDatatypeUInt16: [buffer addUInt16:self.numberValue.unsignedShortValue]; break;
    case NCDatatypeUInt32: [buffer addUInt32:self.numberValue.unsignedIntValue]; break;
    case NCDatatypeUInt64: [buffer addUInt64:self.numberValue.unsignedLongValue]; break;
    case NCDatatypeInt8: [buffer addInt8:self.numberValue.charValue]; break;
    case NCDatatypeInt16: [buffer addInt16:self.numberValue.shortValue]; break;
    case NCDatatypeInt32: [buffer addInt32:self.numberValue.intValue]; break;
    case NCDatatypeInt64: [buffer addInt64:self.numberValue.longValue]; break;
    case NCDatatypeFloat32: [buffer addFloat32:self.numberValue.floatValue]; break;
    case NCDatatypeFloat64: [buffer addFloat64:self.numberValue.doubleValue]; break;
    case NCDatatypeString: {
      [buffer addUInt8:self.stringValue.length];
      [buffer appendData:[self.stringValue dataUsingEncoding:NSUTF8StringEncoding]];
      break;
    }
    default:
      [NSException raise:@"Datatype can't be packed directly" format:@"datatype: %i", datatype];
      break;
  }

  return buffer;
}

-(NSString *)description
{
  return [NSString stringWithFormat:@"<NCValue: booleanValue:%i numberValue:%@ stringValue:%@>", self.booleanValue, self.numberValue, self.stringValue];
}

@end
