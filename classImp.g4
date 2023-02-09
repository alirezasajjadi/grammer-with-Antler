grammar classImp;
program: statement* ; // match one or more class definitions
statement: classDeclaration;
classDeclaration: Class ID (extend)? (implements)? Begin
            classBody
            End;
extend:  OpenPartz ID ClosePartz;
implements: Implements ID (',' ID)*;
classBody: classMembers constructor? classMembers;

constructor: ID OpenPartz (DataType ID (',' DataType ID)*)? ClosePartz
                Begin
                    constructor_member
                End
                ;
constructor_member: (This PT expression SIMICOLON)*;

classMembers: (variable | function | class_instantiation)*;

/*       class instantiation        */
class_instantiation: ACCESSIBILITY? CONST? ID ID
                        ('=' (Null | (ID OpenPartz (initial_value (',' initial_value)*)? ClosePartz)))?
                        SIMICOLON;

/*       method declaration         */
function: DataType ID OpenPartz parameter_list? ClosePartz
            Begin
                variable*
            End;
parameter_list: DataType expression (',' DataType expression)*;

/*       variable declaration       */
variable: (ACCESSIBILITY)? (CONST)? DataType
            (
            var_decl (','var_decl)* SIMICOLON |
            array_decl SIMICOLON
            )
            ;
var_decl: expression;
array_decl: ID OpenBrac CloseBrac ('=' New DataType OpenBrac (INT) CloseBrac |
                                    '=' OpenBrac (initial_value(',' initial_value)*)? CloseBrac
                                    )?;

/*       Loop declaration           */
loopStatement: forStatement | whileStatement;
forStatement: For


/*       expression                 */
expression: expression ('=' | '+=' | '-=' | '/=' | '*=' | '//=') exp_12 | exp_12;
exp_12: exp_12 ('not' | 'and' | 'or' | '||' | '&&') exp_11 | exp_11;
exp_11: exp_11 ('<' | '>' | '<=' | '>=') exp_10 | exp_10;
exp_10: exp_10 ('==' | '!=' | '<>') exp_9 | exp_9;
exp_9: exp_9 ('&' | '^' | '|') exp_8 | exp_8;
exp_8: exp_8 ('>>' | '<<') exp_7 | exp_7;
exp_7: exp_7 ('+' | '-') exp_6 | exp_6;
exp_6: exp_6 ('*' | '/' | '//' | '%') exp_5 | exp_5;
exp_5: exp_5 ('++' | '--') | ('++' | '--') exp_5 | exp_4;
exp_4: ('-' | '+') exp_4 | exp_3;
exp_3: '~' exp_3 | exp_2;
exp_2: exp_2 '**' exp_1 | exp_1;
exp_1: (OpenPartz expression ClosePartz) | ID | initial_value;


initial_value: INT | STRING | CHAR | BOOL | DOUBLE;
/*       reserved Keys              */
Class: 'class';
Begin: 'begin';
End: 'end';
Implements: 'implements';
New: 'new';
This: 'this';
Require: 'require';
From: 'from';
True: 'true';
False: 'false';
Return: 'return';
Null: 'Null';
For: 'for';

/*       Data types                 */
DataType: ('int' | 'bool' | 'double' | 'char' | 'string' ) ;

ACCESSIBILITY: ('private' | 'public');
BOOL: True | False;
INT: [0-9]+;
DOUBLE: INT+ PT INT+
            | PT INT+
            | INT+
            ;
CHAR: '\'' [a-zA-Z_$] '\'';
STRING: '"' (~'"')* '"';
PT: '.';
CONST: 'const';

/*       Naming Rules               */
//ReservedKey: 'public' | 'private' | 'require' | 'end' | 'begin' |

ID : (LETTER | '$') (LETTER | '0'..'9' | '_' | '$')+;
fragment LETTER : [a-zA-Z];
WS : [ \r\t\n]+ -> skip;


/*       symbols                    */
OpenPartz: '(';
ClosePartz: ')';
OpenBrac: '[';
CloseBrac: ']';
//Assignment: '=';
SIMICOLON: ';';
