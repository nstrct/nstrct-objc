#import "NCArgument.h"

#import "NSData+NCBinaryUtilities.h"
#import "NSMutableData+NCBinaryUtilities.h"

@implementation NCArgument

+ (NCArgument *)parseFromBuffer:(NSData *)buffer usingCursor:(NSInteger *)cursor
{
  NCArgument* argument = [[NCArgument alloc] initWithDatatype:[buffer readUInt8At:cursor]];
  
  if(argument.datatype == NCDatatypeArray) {
    argument.datatype = [buffer readUInt8At:cursor];
    argument.isArray = YES;
    uint8_t numElements = [buffer readUInt8At:cursor];
    
    for(uint8_t i=0; i<numElements; i++) {
      [argument.values addObject:[NCValue parseDatatype:argument.datatype fromBuffer:buffer usingCursor:cursor]];
    }
  } else {
    [argument.values addObject:[NCValue parseDatatype:argument.datatype fromBuffer:buffer usingCursor:cursor]];
  }
  
  return argument;
}

- (NCArgument *)initWithDatatype:(NCDatatype)datatype
{
  self = [self init];
  if(self) {
    self.datatype = datatype;
    self.values = [[NSMutableArray alloc] init];
    self.isArray = NO;
  }
  return self;
}

- (NCArgument *)initWithDatatype:(NCDatatype)datatype andValues:(NSArray *)values
{
  self = [self initWithDatatype:datatype];
  if(self) {
    self.values = [NSMutableArray arrayWithArray:values];
    self.isArray = YES;
  }
  return self;
}

- (NCArgument *)initWithDatatype:(NCDatatype)datatype andValue:(NCValue *)value
{
  self = [self initWithDatatype:datatype];
  if(self) {
    self.values = [NSMutableArray arrayWithArray:@[value]];
    self.isArray = NO;
  }
  return self;
}

- (NSData *)pack
{
  NSMutableData* buffer = [[NSMutableData alloc] init];
  if(self.isArray) {
    [buffer addUInt8:NCDatatypeArray];
    [buffer addUInt8:self.datatype];
    [buffer addUInt8:[self.values count]];
    for(NCValue* value in self.values) {
      [buffer appendData:[value packAsDatatype:self.datatype]];
    }
  } else {
    [buffer addUInt8:self.datatype];
    NCValue* value = self.values[0];
    [buffer appendData:[value packAsDatatype:self.datatype]];
  }
  return buffer;
}

- (NSString *)description
{
  NSMutableString* values = [NSMutableString stringWithString:@"["];
  for(NCValue* value in self.values) {
    [values appendString:value.description];
  }
  [values appendString:@"]"];

  return [NSString stringWithFormat:@"<NCArgument: datatype:%i isArray:%i values:%@>", self.datatype, self.isArray, values];
}

@end
