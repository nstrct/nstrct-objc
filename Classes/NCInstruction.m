#import "NCInstruction.h"
#import "NCArgument.h"

#import "NSData+NCBinaryUtilities.h"
#import "NSMutableData+NCBinaryUtilities.h"

@implementation NCInstruction

+ (NCInstruction *)parseFromBuffer:(NSData*)buffer
{
  NSInteger cursor = 0;
  NCInstruction* instruction = [[NCInstruction alloc] initWithCode:[buffer readUInt16At:&cursor]];
  uint8_t numArguments = [buffer readUInt8At:&cursor];
  cursor += 2; // skip total amount of array elements
  for(uint8_t i=0; i<numArguments; i++) {
    [instruction.arguments addObject:[NCArgument parseFromBuffer:buffer usingCursor:&cursor]];
  }

  return instruction;
}

- (NCInstruction *)initWithCode:(NSInteger)code
{
  self = [self init];
  if(self) {
    self.code = code;
    self.arguments = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NCInstruction *)initWithCode:(NSInteger)code andArguments:(NSArray *)arguments
{
  self = [self initWithCode:code];
  if(self) {
    self.arguments = [NSMutableArray arrayWithArray:arguments];
  }
  return self;
}

- (NSInteger)countTotalArrayElements
{
  NSInteger counter = 0;
  for(NCArgument* argument in self.arguments) {
    if([argument isArray]) {
      counter += [argument.values count];
    }
  }
  return counter;
}

- (NSData *)pack
{
  NSMutableData* buffer = [[NSMutableData alloc] init];
  
  [buffer addUInt16:self.code];
  [buffer addUInt8:[self.arguments count]];
  [buffer addUInt16:[self countTotalArrayElements]];
  
  for(NCArgument* argument in self.arguments) {
    [buffer appendData:argument.pack];
  }

  return buffer;
}

- (NSString *)description
{
  NSMutableString* arguments = [NSMutableString stringWithString:@"["];
  for(NCArgument* argument in self.arguments) {
    [arguments appendString:argument.description];
  }
  [arguments appendString:@"]"];

  return [NSString stringWithFormat:@"<NCInstruction: code:%li arguments:%@>", (long)self.code, arguments];
}

@end
