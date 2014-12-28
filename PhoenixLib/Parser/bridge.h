// Bridge to C functions...

@class Lexer;
@class ASTNode;


ASTNode* bridge_yyparse(Lexer * lexer, int debug);
const char * bridge_yyerror();
void foo();