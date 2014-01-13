#import <Foundation/Foundation.h>

#import "nstrct.h"
#import "NSMutableData+NCBinaryUtilities.h"

double float64_max;

void genereate()
{
  NCInstruction* instruction = [[NCInstruction alloc] initWithCode:UINT16_MAX];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeBoolean andValue:[[NCValue alloc] initWithBoolen:NO]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeInt8 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithChar:INT8_MIN]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeInt16 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithShort:INT16_MIN]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeInt32 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithInt:INT32_MIN]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeInt64 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithLong:INT64_MIN]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeUInt8 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedChar:UINT8_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeUInt16 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedShort:UINT16_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeUInt32 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedInt:UINT32_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeUInt64 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedLong:UINT64_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeFloat32 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithFloat:FLT_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeFloat64 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithDouble:DBL_MAX]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeString andValue:[[NCValue alloc] initWithString:@"hello world"]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeString andValue:[[NCValue alloc] initWithString:@""]]];
  
  NSArray* array = @[ [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedShort:2443]], [[NCValue alloc] initWithNumber:[NSNumber numberWithUnsignedShort:3443]] ];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeUInt16 andValues:array]];
  
  NCFrame* frame = [[NCFrame alloc] initWithInstruction:instruction];
  
  NSMutableData* length = [[NSMutableData alloc] init];
  [length addUInt32:(uint32_t)[[frame pack] length]];
  [length writeToFile:@"/dev/stdout" atomically:NO];
  
  [[frame pack] writeToFile:@"/dev/stdout" atomically:NO];
}

void test(const char * string, bool exp) {
  if(!exp) {
    printf("%s\n",string);
    exit(1);
  }
}

NCValue* getValue(NCInstruction* instruction, NSInteger i, NSInteger ii) {
  NCArgument* arg = instruction.arguments[i];
  return arg.values[ii];
}

void process()
{
  NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
  NSData *inputData = [NSData dataWithData:[input readDataToEndOfFile]];
  NSData *subdata = [inputData subdataWithRange:NSMakeRange(4, inputData.length-4)];
  
  NCFrame* frame = [NCFrame parseFromBuffer:subdata];
  NCInstruction* instruction = frame.instruction;
  
  test("    boolean value", !getValue(instruction, 0, 0).booleanValue);
  test("    int8 value", getValue(instruction, 1, 0).numberValue.charValue == INT8_MIN);
  test("    int16 value", getValue(instruction, 2, 0).numberValue.shortValue == INT16_MIN);
  test("    int32 value", getValue(instruction, 3, 0).numberValue.intValue == INT32_MIN);
  test("    int64 value", getValue(instruction, 4, 0).numberValue.longValue == INT64_MIN);
  test("    uint8 value", getValue(instruction, 5, 0).numberValue.unsignedCharValue == UINT8_MAX);
  test("    uint16 value", getValue(instruction, 6, 0).numberValue.unsignedShortValue == UINT16_MAX);
  test("    uint32 value", getValue(instruction, 7, 0).numberValue.unsignedIntValue == UINT32_MAX);
  test("    uint64 value", getValue(instruction, 8, 0).numberValue.unsignedLongValue == UINT64_MAX);
  test("    float32 value", getValue(instruction, 9, 0).numberValue.floatValue == FLT_MAX);
  test("    float64 value", getValue(instruction, 10, 0).numberValue.doubleValue == DBL_MAX);
  test("    string value", [getValue(instruction, 11, 0).stringValue isEqualToString:@"hello world"]);
  test("    empty string value", [getValue(instruction, 12, 0).stringValue isEqualToString:@""]);
  test("    array uint16 value 1 value", getValue(instruction, 13, 0).numberValue.unsignedShortValue == 2443);
  test("    array uint16 value 2 value", getValue(instruction, 13, 1).numberValue.unsignedShortValue == 3443);
  printf("    tests passed\n");
}

int main(int argc, const char * argv[])
{
  float64_max = 1.7976931348623157*pow(10,308);
  @autoreleasepool {
    if(argc > 1) {
      NSString* mode = [[NSString alloc] initWithBytes:argv[1] length:2 encoding:NSUTF8StringEncoding];
      if([mode isEqualToString:@"-g"]) {
        genereate();
      } else if([mode isEqualToString:@"-p"]) {
        process();
      }
    } else {
      NSLog(@"Invoke test with -p or -g.");
    }
  }
  return 0;
}