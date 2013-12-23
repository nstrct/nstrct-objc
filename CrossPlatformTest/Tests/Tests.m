#import <XCTest/XCTest.h>

#import "nstrct.h"

@interface nstrct_tests : XCTestCase
@end

@implementation nstrct_tests

- (void)setUp
{
  [super setUp];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)proofInstruction:(NCInstruction*)instruction
{
  NCInstruction* instruction2 = [NCInstruction parseFromBuffer:[instruction pack]];
  XCTAssertEqualObjects([instruction description], [instruction2 description]);
}

- (void)testBasicInstruction
{
  NCInstruction* instruction = [[NCInstruction alloc] initWithCode:11];
  [self proofInstruction:instruction];
}

- (void)testInstruction
{
  NCInstruction* instruction = [[NCInstruction alloc] initWithCode:12 andArguments:@[[[NCArgument alloc] initWithDatatype:NCDatatypeUInt16 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithInt:253]]]]];
  [self proofInstruction:instruction];
}

- (void)testComplexInstruction
{
  NCInstruction* instruction = [[NCInstruction alloc] initWithCode:233];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeInt64 andValue:[[NCValue alloc] initWithNumber:[NSNumber numberWithLong:8947]]]];
  [instruction.arguments addObject:[[NCArgument alloc] initWithDatatype:NCDatatypeString andValue:[[NCValue alloc] initWithString:@"hello world"]]];
  [self proofInstruction:instruction];
}

@end
