parser grammar GerberParser;

options {
	tokenVocab = GerberLexer;
}

// Entry rule
gerber: comment* definition* command* exit EOF;

dCodes: DRAW_MOVE | CLOSED_MOVE | FLASHING_MOVE;

apertureSelectCommand: APERTURE_SELECT APERTURE_NAME endCommand;
linearInterpolationCommand:
	LINEAR_INTERPOLATION XY dCodes endCommand;

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
stepAndRepeatDefinition: STEP_REPEAT XY STEPS;
unitsDefinition: SET_UNITS UNITS;
formatSpecficationDefinition: FORMAT_SPECIFICATION OPTIONS* XY;