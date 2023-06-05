parser grammar GerberParser;

options {
	tokenVocab = GerberLexer;
}

// Entry rule
gerber: comment* definition* command* exit EOF;

dCodes: DRAW_MOVE | CLOSED_MOVE | FLASHING_MOVE;

linearCoordinates: X_COORDINATE Y_COORDINATE;
apertureSelectCommand: APERTURE_SELECT APERTURE_NAME endCommand;
linearInterpolationCommand:
	LINEAR_INTERPOLATION linearCoordinates dCodes endCommand;

endCommand: STAR;
exit: EXIT endCommand;

drawPolygon: apertureSelectCommand definition* interpolation+;
interpolation: linearInterpolationCommand;

command: drawPolygon;
comment: COMMENT;

definition: PERCENT defintionType endCommand PERCENT;
defintionType:
	stepAndRepeatDefinition
	| apertureDefinition
	| layerPolarityDefinition
	| layerNameDefinition
	| unitsDefinition;
apertureDefinition:
	APERTURE_DEFINE APERTURE_NAME APERTURE_TYPE COMMA DIMENSIONS
	| APERTURE_DEFINE;
layerPolarityDefinition: LAYER_POLARITY POLARITY_TYPE;
layerNameDefinition: LAYER_NAME;
stepAndRepeatDefinition:
	(STEP_REPEAT) (X_REPEATS Y_REPEATS) (X_STEP_SIZE Y_STEP_SIZE);
unitsDefinition: SET_UNITS units;
units: MM | IN;