#import <Foundation/Foundation.h>

typedef enum {
  NCDatatypeBoolean = 1,
  NCDatatypeInt8 = 10,
  NCDatatypeInt16 = 11,
  NCDatatypeInt32 = 12,
  NCDatatypeInt64 = 13,
  NCDatatypeUInt8 = 14,
  NCDatatypeUInt16 = 15,
  NCDatatypeUInt32 = 16,
  NCDatatypeUInt64 = 17,
  NCDatatypeFloat32 = 21,
  NCDatatypeFloat64 = 22,
  NCDatatypeString = 31,
  NCDatatypeArray = 32
} NCDatatype;

@interface NCValue : NSObject

@property BOOL booleanValue;
@property NSNumber* numberValue;
@property NSString* stringValue;

+ (NCValue*)parseDatatype:(NCDatatype)datatype fromBuffer:(NSData*)buffer usingCursor:(NSInteger*)cursor;

- (NCValue*)initWithBoolen:(BOOL)boolean;
- (NCValue*)initWithNumber:(NSNumber*)number;
- (NCValue*)initWithString:(NSString*)string;

- (NSData*)packAsDatatype:(NCDatatype)datatype;

@end
