#import <Foundation/Foundation.h>

@interface ASTContext : NSObject

//exported variable declarations
@property (nonatomic, retain) NSMutableArray *exportedVars;
@property (nonatomic, assign) NSInteger exportedIndex;

//scoped symbols for type inference
@property (nonatomic, retain) NSMutableArray *symbols;
@property (nonatomic, assign) NSInteger symbolsIndex;

//index for IDS
@property (nonatomic, assign) NSInteger generateIDIndex;

- (NSString *) variableDeclaration;
- (NSString *) declarationSeparator;

// Methods.
- (NSString *)generateID;
- (void) exportVar: (NSString *)name;
- (NSString *)getExportedVars;
- (void) saveExported;
- (void) restoreExported;
- (void) saveSymbols;
- (void) restoreSymbols;
- (void) addSymbolName: (NSString *)name
                  type: (GenericType *)type;
- (GenericType *)inferSymbol: (NSString *)name;

@end

// Global context....
static ASTContext *ctx = nil;  // Initialized top ASTContext when first context is created...
