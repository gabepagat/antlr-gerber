lexer grammar GerberLexer;

channels {
	COMMENTS
}

PERCENT: '%';
STAR: '*';
COMMA: ',';

// Units
SET_UNITS: (M O);
MM: (M M);
IN: (I N);

// Coordinates
X: 'X';
Y: 'Y';
X_COORDINATE: (X INTEGER);
Y_COORDINATE: (Y INTEGER);
DIMENSIONS: FLOAT (X FLOAT)?;

// G-codes
COMMENT_CODE: G (ZERO? FOUR);
LINEAR_INTERPOLATION: G (ZERO? ONE);
APERTURE_SELECT: G (FIVE FOUR);
CLOCKWISE_INTERPOLATION: G (ZERO? TWO);
COUNTERCLOCKWISE_INTERPOLATION: G (ZERO? THREE);

// D-codes
DRAW_MOVE: D (ZERO? ONE);
CLOSED_MOVE: D (ZERO? TWO);
FLASHING_MOVE: D (ZERO? THREE);
APERTURE_NAME: D INTEGER;

// Apertures
APERTURE_TYPE: RECTANGLE | OBLONG | CIRCLE | POLYGON;
RECTANGLE: R;
OBLONG: O;
CIRCLE: C;
POLYGON: P;
APERTURE_DEFINE: (A D);

// Layer Polarity
LAYER_POLARITY: (L P);
POLARITY_TYPE: DARK | CLEAR;
DARK: D;
CLEAR: C;

// Layer Name
LAYER_NAME: (L N) ~('*')*;

// Step and Repeat
STEP_REPEAT: (S R);
X_REPEATS: (X INTEGER);
Y_REPEATS: (Y INTEGER);
X_STEP_SIZE: (I FLOAT);
Y_STEP_SIZE: (J FLOAT);

EXIT: M (ZERO? TWO);
COMMENT: (ASTERISK_AT_START | COMMENT_CODE) .*? '\r'? '\n' -> channel(COMMENTS);

FLOAT: '-'? DIGIT+ '.' DIGIT+;
INTEGER: '-'? DIGIT+;
DIGIT: [0-9];
WHITESPACE: [ \t\r\n]+ -> skip;

// Fragments
fragment G: 'G';
fragment M: 'M';
fragment D: 'D';
fragment A: 'A';
fragment F: 'F';
fragment S: 'S';
fragment L: 'L';
fragment P: 'P';
fragment C: 'C';
fragment R: 'R';
fragment O: 'O';
fragment N: 'N';
fragment I: 'I';
fragment J: 'J';

fragment ZERO: '0';
fragment ONE: '1';
fragment TWO: '2';
fragment THREE: '3';
fragment FOUR: '4';
fragment FIVE: '5';
fragment SIX: '6';
fragment SEVEN: '7';
fragment EIGHT: '8';
fragment NINE: '9';

fragment ASTERISK_AT_START: {getCharPositionInLine() == 0}? STAR;