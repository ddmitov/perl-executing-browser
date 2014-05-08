# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'katexml/xmldebug.xml' file of the syntax highlight
# engine of the kate text editor (http://kate.kde.org

#kate xml version 1.02
#kate version 2.3
#generated: Wed Nov  1 21:17:55 2006, localtime

package Syntax::Highlight::Engine::Kate::XML_Debug;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = $class->SUPER::new(@_);
	$self->attributes({
		'Attribute' => 'DataType',
		'Comment' => 'Comment',
		'Doctype Declaration' => 'Keyword',
		'Entity' => 'Char',
		'Error' => 'Error',
		'Normal Tag' => 'Keyword',
		'Normal Text' => 'Normal',
		'PI content' => 'Others',
		'Processing Instruction' => 'Keyword',
		'Stylesheet' => 'Keyword',
		'Value' => 'String',
	});
	$self->listAdd('AttType',
		'CDATA',
		'ENTITIES',
		'ENTITY',
		'ID',
		'IDREF',
		'IDREFS',
		'NMTOKEN',
		'NMTOKENS',
	);
	$self->contextdata({
		'0:prolog' => {
			callback => \&parse0prolog,
			attribute => 'Error',
		},
		'10:XMLDecl Standalone' => {
			callback => \&parse10XMLDeclStandalone,
			attribute => 'Error',
		},
		'11:Misc after XMLDecl' => {
			callback => \&parse11MiscafterXMLDecl,
			attribute => 'Error',
		},
		'12:Comment after XMLDecl' => {
			callback => \&parse12CommentafterXMLDecl,
			attribute => 'Comment',
		},
		'13:PI after XMLDecl' => {
			callback => \&parse13PIafterXMLDecl,
			attribute => 'Processing Instruction Body',
		},
		'14:Doctype Decl Name' => {
			callback => \&parse14DoctypeDeclName,
			attribute => 'Error',
		},
		'15:Doctype Decl ExternalID' => {
			callback => \&parse15DoctypeDeclExternalID,
			attribute => 'Error',
		},
		'16:Doctype Decl PublicID' => {
			callback => \&parse16DoctypeDeclPublicID,
			attribute => 'Error',
		},
		'17:Doctype Decl PublicID qq' => {
			callback => \&parse17DoctypeDeclPublicIDqq,
			attribute => 'Error',
		},
		'18:Doctype Decl PublicID q' => {
			callback => \&parse18DoctypeDeclPublicIDq,
			attribute => 'Value',
		},
		'19:Doctype Decl SystemID' => {
			callback => \&parse19DoctypeDeclSystemID,
			attribute => 'Error',
		},
		'1:XMLDecl Version' => {
			callback => \&parse1XMLDeclVersion,
			attribute => 'Error',
		},
		'20:Doctype Decl SystemID qq' => {
			callback => \&parse20DoctypeDeclSystemIDqq,
			attribute => 'Value',
		},
		'21:Doctype Decl SystemID q' => {
			callback => \&parse21DoctypeDeclSystemIDq,
			attribute => 'Value',
		},
		'22:Doctype Decl IS or end' => {
			callback => \&parse22DoctypeDeclISorend,
			attribute => 'Error',
		},
		'23:Doctype Decl IS' => {
			callback => \&parse23DoctypeDeclIS,
			attribute => 'Error',
		},
		'24:elementdecl' => {
			callback => \&parse24elementdecl,
			attribute => 'Error',
		},
		'25:contentspec' => {
			callback => \&parse25contentspec,
			attribute => 'Error',
		},
		'26:MixedOrChildren' => {
			callback => \&parse26MixedOrChildren,
			attribute => 'Error',
		},
		'27:MixedShort' => {
			callback => \&parse27MixedShort,
			attribute => 'Error',
		},
		'28:MixedLong' => {
			callback => \&parse28MixedLong,
			attribute => 'Error',
		},
		'29:MixedLong endOrContinue' => {
			callback => \&parse29MixedLongendOrContinue,
			attribute => 'Error',
		},
		'2:XMLDecl Version Eq' => {
			callback => \&parse2XMLDeclVersionEq,
			attribute => 'Error',
			lineending => '5:XMLDecl Encoding Eq',
		},
		'30:children unknown' => {
			callback => \&parse30childrenunknown,
			attribute => 'Error',
		},
		'31:children unknownOrEnd' => {
			callback => \&parse31childrenunknownOrEnd,
			attribute => 'Error',
		},
		'32:children unknownName' => {
			callback => \&parse32childrenunknownName,
			attribute => 'Error',
		},
		'33:children choice' => {
			callback => \&parse33childrenchoice,
			attribute => 'Error',
		},
		'34:children choiceOrEnd' => {
			callback => \&parse34childrenchoiceOrEnd,
			attribute => 'Error',
		},
		'35:children seq' => {
			callback => \&parse35childrenseq,
			attribute => 'Error',
		},
		'36:children seqOrEnd' => {
			callback => \&parse36childrenseqOrEnd,
			attribute => 'Error',
		},
		'37:element end' => {
			callback => \&parse37elementend,
			attribute => 'Error',
		},
		'38:AttlistDecl' => {
			callback => \&parse38AttlistDecl,
			attribute => 'Error',
		},
		'39:AttDef' => {
			callback => \&parse39AttDef,
			attribute => 'Error',
		},
		'3:XMLDecl Version' => {
			callback => \&parse3XMLDeclVersion,
			attribute => 'Error',
		},
		'40:AttType' => {
			callback => \&parse40AttType,
			attribute => 'Error',
		},
		'41:NotationStart' => {
			callback => \&parse41NotationStart,
			attribute => 'Error',
		},
		'42:Notation' => {
			callback => \&parse42Notation,
			attribute => 'Error',
		},
		'43:Notation or End' => {
			callback => \&parse43NotationorEnd,
			attribute => 'Error',
		},
		'44:Enumeration' => {
			callback => \&parse44Enumeration,
			attribute => 'Error',
		},
		'45:Enumeration or End' => {
			callback => \&parse45EnumerationorEnd,
			attribute => 'Error',
		},
		'46:DefaultDecl' => {
			callback => \&parse46DefaultDecl,
			attribute => 'Error',
		},
		'47:DefaultDecl AttValue' => {
			callback => \&parse47DefaultDeclAttValue,
			attribute => 'Error',
		},
		'48:DefaultDecl AttValue qq' => {
			callback => \&parse48DefaultDeclAttValueqq,
			attribute => 'Value',
		},
		'49:DefaultDecl AttValue q' => {
			callback => \&parse49DefaultDeclAttValueq,
			attribute => 'Value',
		},
		'4:XMLDecl Encoding' => {
			callback => \&parse4XMLDeclEncoding,
			attribute => 'Error',
		},
		'50:EntityDecl' => {
			callback => \&parse50EntityDecl,
			attribute => 'Error',
		},
		'51:unused' => {
			callback => \&parse51unused,
			attribute => 'Error',
		},
		'52:GEDecl EntityValueOrExternalID' => {
			callback => \&parse52GEDeclEntityValueOrExternalID,
			attribute => 'Error',
		},
		'53:GEDecl EntityValue qq' => {
			callback => \&parse53GEDeclEntityValueqq,
			attribute => 'Value',
		},
		'54:GEDecl EntityValue q' => {
			callback => \&parse54GEDeclEntityValueq,
			attribute => 'Value',
		},
		'55:GEDecl PublicID' => {
			callback => \&parse55GEDeclPublicID,
			attribute => 'Error',
		},
		'56:GEDecl PublicID qq' => {
			callback => \&parse56GEDeclPublicIDqq,
			attribute => 'Error',
		},
		'57:GEDecl PublicID q' => {
			callback => \&parse57GEDeclPublicIDq,
			attribute => 'Value',
		},
		'58:GEDecl SystemID' => {
			callback => \&parse58GEDeclSystemID,
			attribute => 'Error',
		},
		'59:GEDecl SystemID qq' => {
			callback => \&parse59GEDeclSystemIDqq,
			attribute => 'Value',
		},
		'5:XMLDecl Encoding Eq' => {
			callback => \&parse5XMLDeclEncodingEq,
			attribute => 'Error',
		},
		'60:GEDecl SystemID q' => {
			callback => \&parse60GEDeclSystemIDq,
			attribute => 'Value',
		},
		'61:PEDecl' => {
			callback => \&parse61PEDecl,
			attribute => 'Error',
		},
		'62:PEDecl EntityValueOrExternalID' => {
			callback => \&parse62PEDeclEntityValueOrExternalID,
			attribute => 'Error',
		},
		'63:PEDecl PublicID' => {
			callback => \&parse63PEDeclPublicID,
			attribute => 'Error',
		},
		'64:PEDecl PublicID qq' => {
			callback => \&parse64PEDeclPublicIDqq,
			attribute => 'Error',
		},
		'65:PEDecl PublicID q' => {
			callback => \&parse65PEDeclPublicIDq,
			attribute => 'Value',
		},
		'66:PEDecl SystemID' => {
			callback => \&parse66PEDeclSystemID,
			attribute => 'Error',
		},
		'67:PEDecl SystemID qq' => {
			callback => \&parse67PEDeclSystemIDqq,
			attribute => 'Value',
		},
		'68:PEDecl SystemID q' => {
			callback => \&parse68PEDeclSystemIDq,
			attribute => 'Value',
		},
		'69:GEDecl endOrNDATA' => {
			callback => \&parse69GEDeclendOrNDATA,
			attribute => 'Error',
		},
		'6:XMLDecl Encoding' => {
			callback => \&parse6XMLDeclEncoding,
			attribute => 'Error',
		},
		'70:GEDecl NDATA' => {
			callback => \&parse70GEDeclNDATA,
			attribute => 'Error',
		},
		'71:NotationDecl Name' => {
			callback => \&parse71NotationDeclName,
			attribute => 'Error',
		},
		'72:NotationDecl ExternalID' => {
			callback => \&parse72NotationDeclExternalID,
			attribute => 'Error',
		},
		'73:NotationDecl PublicID' => {
			callback => \&parse73NotationDeclPublicID,
			attribute => 'Error',
		},
		'74:NotationDecl PublicID qq' => {
			callback => \&parse74NotationDeclPublicIDqq,
			attribute => 'Error',
		},
		'75:NotationDecl PublicID q' => {
			callback => \&parse75NotationDeclPublicIDq,
			attribute => 'Value',
		},
		'76:NotationDecl SystemIDOrEnd' => {
			callback => \&parse76NotationDeclSystemIDOrEnd,
			attribute => 'Error',
		},
		'77:Comment inside IS' => {
			callback => \&parse77CommentinsideIS,
			attribute => 'Comment',
		},
		'78:PI inside IS' => {
			callback => \&parse78PIinsideIS,
			attribute => 'Processing Instruction Body',
		},
		'79:Outside' => {
			callback => \&parse79Outside,
			attribute => 'Normal Text',
		},
		'7:XMLDecl Standalone' => {
			callback => \&parse7XMLDeclStandalone,
			attribute => 'Error',
		},
		'80:STag' => {
			callback => \&parse80STag,
			attribute => 'Error',
		},
		'81:STag Attribute' => {
			callback => \&parse81STagAttribute,
			attribute => 'Error',
		},
		'82:STag Attribute Value' => {
			callback => \&parse82STagAttributeValue,
			attribute => 'Error',
		},
		'83:STag Value qq' => {
			callback => \&parse83STagValueqq,
			attribute => 'Value',
		},
		'84:STag Value q' => {
			callback => \&parse84STagValueq,
			attribute => 'Value',
		},
		'85:ETag' => {
			callback => \&parse85ETag,
			attribute => 'Error',
		},
		'86:CDSect' => {
			callback => \&parse86CDSect,
			attribute => 'Normal Text',
		},
		'87:Comment inside IS' => {
			callback => \&parse87CommentinsideIS,
			attribute => 'Comment',
		},
		'88:PI inside IS' => {
			callback => \&parse88PIinsideIS,
			attribute => 'Processing Instruction Body',
		},
		'8:XMLDecl Standalone Eq' => {
			callback => \&parse8XMLDeclStandaloneEq,
			attribute => 'Error',
		},
		'9:XMLDecl Standalone' => {
			callback => \&parse9XMLDeclStandalone,
			attribute => 'Error',
		},
	});
	$self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
	$self->basecontext('0:prolog');
	$self->keywordscase(1);
	$self->initialize;
	bless ($self, $class);
	return $self;
}

sub language {
	return 'XML (Debug)';
}

sub parse0prolog {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?xml(\\s+|$)', 0, 0, 0, undef, 0, '1:XMLDecl Version', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse10XMLDeclStandalone {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\?>', 0, 0, 0, undef, 0, '11:Misc after XMLDecl', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse11MiscafterXMLDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<!--\\s*', 0, 0, 0, undef, 0, '12:Comment after XMLDecl', 'Comment')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\?xml-stylesheet(\\s+|$)', 0, 0, 0, undef, 0, '13:PI after XMLDecl', 'Processing Instruction')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\??[xX][mM][lL]', 0, 0, 0, undef, 0, '13:PI after XMLDecl', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\?[a-zA-Z_][a-zA-Z0-9_-]*(:[a-zA-Z0-9_-]*)?(\\s+|$)', 0, 0, 0, undef, 0, '13:PI after XMLDecl', 'Processing Instruction')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!DOCTYPE(\\s+|$)', 0, 0, 0, undef, 0, '14:Doctype Decl Name', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '80:STag', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '85:ETag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '85:ETag', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '85:ETag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '79:Outside', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '79:Outside', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!\\[CDATA\\[', 0, 0, 0, undef, 0, '86:CDSect', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!--', 0, 0, 0, undef, 0, '87:Comment inside IS', 'Comment')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?xml-stylesheet(\\s|$)', 0, 0, 0, undef, 0, '88:PI inside IS', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '88:PI inside IS', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '88:PI inside IS', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '88:PI inside IS', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '79:Outside', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '79:Outside', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\]\\]>', 0, 0, 0, undef, 0, '79:Outside', 'Error')) {
		return 1
	}
	return 0;
};

sub parse12CommentafterXMLDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '--->', 0, 0, 0, undef, 0, '#pop', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '-->', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
		return 1
	}
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	return 0;
};

sub parse13PIafterXMLDecl {
	my ($self, $text) = @_;
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '?', '>', 0, 0, 0, undef, 0, '#pop', 'Processing Instruction')) {
		return 1
	}
	return 0;
};

sub parse14DoctypeDeclName {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '15:Doctype Decl ExternalID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse15DoctypeDeclExternalID {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, 'PUBLIC(\\s+|$)', 0, 0, 0, undef, 0, '16:Doctype Decl PublicID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'SYSTEM(\\s+|$)', 0, 0, 0, undef, 0, '19:Doctype Decl SystemID', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse16DoctypeDeclPublicID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '17:Doctype Decl PublicID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '18:Doctype Decl PublicID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse17DoctypeDeclPublicIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"(\\s+|$)', 0, 0, 0, undef, 0, '19:Doctype Decl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9\'()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse18DoctypeDeclPublicIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'(\\s+|$)', 0, 0, 0, undef, 0, '19:Doctype Decl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse19DoctypeDeclSystemID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '20:Doctype Decl SystemID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '21:Doctype Decl SystemID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse1XMLDeclVersion {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*version\\s*', 0, 0, 0, undef, 0, '2:XMLDecl Version Eq', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse20DoctypeDeclSystemIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '22:Doctype Decl IS or end', 'Value')) {
		return 1
	}
	return 0;
};

sub parse21DoctypeDeclSystemIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '22:Doctype Decl IS or end', 'Value')) {
		return 1
	}
	return 0;
};

sub parse22DoctypeDeclISorend {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '[', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '79:Outside', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse23DoctypeDeclIS {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '%(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!ELEMENT(\\s+|$)', 0, 0, 0, undef, 0, '24:elementdecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!ATTLIST(\\s+|$)', 0, 0, 0, undef, 0, '38:AttlistDecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!ENTITY(\\s+|$)', 0, 0, 0, undef, 0, '50:EntityDecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!NOTATION(\\s+|$)', 0, 0, 0, undef, 0, '71:NotationDecl Name', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<!--\\s*', 0, 0, 0, undef, 0, '77:Comment inside IS', 'Comment')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\?xml-stylesheet(\\s+|$)', 0, 0, 0, undef, 0, '78:PI inside IS', 'Processing Instruction')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\??[xX][mM][lL]', 0, 0, 0, undef, 0, '78:PI inside IS', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*<\\?[a-zA-Z_][a-zA-Z0-9_-]*(:[a-zA-Z0-9_-]*)?(\\s+|$)', 0, 0, 0, undef, 0, '78:PI inside IS', 'Processing Instruction')) {
		return 1
	}
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, ']', '>', 0, 0, 0, undef, 0, '79:Outside', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse24elementdecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*', 0, 0, 0, undef, 0, '25:contentspec', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse25contentspec {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(EMPTY|ANY)', 0, 0, 0, undef, 0, '37:element end', 'Attribute')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '26:MixedOrChildren', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse26MixedOrChildren {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '#PCDATA', 0, 0, 0, undef, 0, '27:MixedShort', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '30:children unknown', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*[\\?\\*\\+]?', 0, 0, 0, undef, 0, '30:children unknown', 'Value')) {
		return 1
	}
	return 0;
};

sub parse27MixedShort {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '28:MixedLong', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '37:element end', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse28MixedLong {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*', 0, 0, 0, undef, 0, '29:MixedLong endOrContinue', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse29MixedLongendOrContinue {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#pop', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#pop#pop', 'Doctype Declaration')) {
		return 1
	}
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, ')', '*', 0, 0, 0, undef, 0, '37:element end', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse2XMLDeclVersionEq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, '3:XMLDecl Version', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};

sub parse30childrenunknown {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '33:children choice', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '35:children seq', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)[\\?\\*\\+]?', 0, 0, 0, undef, 0, '31:children unknownOrEnd', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse31childrenunknownOrEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '33:children choice', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '35:children seq', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)[\\?\\*\\+]?', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse32childrenunknownName {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*[\\?\\*\\+]?', 0, 0, 0, undef, 0, '30:children unknown', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse33childrenchoice {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*[\\?\\*\\+]?', 0, 0, 0, undef, 0, '34:children choiceOrEnd', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '32:children unknownName', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse34childrenchoiceOrEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#pop', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)[\\?\\*\\+]?', 0, 0, 0, undef, 0, '31:children unknownOrEnd', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse35childrenseq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*[\\?\\*\\+]?', 0, 0, 0, undef, 0, '36:children seqOrEnd', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '32:children unknownName', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse36childrenseqOrEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, ',', 0, 0, 0, undef, 0, '#pop', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)[\\?\\*\\+]?', 0, 0, 0, undef, 0, '31:children unknownOrEnd', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse37elementend {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse38AttlistDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '39:AttDef', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse39AttDef {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '40:AttType', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse3XMLDeclVersion {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*("[A-Za-z0-9:._-]*"|\'[A-Za-z0-9:._-]*\')(?!e)\\s*', 0, 0, 0, undef, 0, '4:XMLDecl Encoding', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};

sub parse40AttType {
	my ($self, $text) = @_;
	# type => keyword
	if ($self->testKeyword($text, 'AttType', 0, 0, undef, 0, '46:DefaultDecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'NOTATION(\\s+|$)', 0, 0, 0, undef, 0, '41:NotationStart', 'Doctype Declaration')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '42:Notation', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#pop', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse41NotationStart {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '42:Notation', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#pop#pop', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse42Notation {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*', 0, 0, 0, undef, 0, '43:Notation or End', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse43NotationorEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '#pop', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)(\\s+|$)', 0, 0, 0, undef, 0, '46:DefaultDecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse44Enumeration {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(\\w|[_:.-])+', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse45EnumerationorEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '|', 0, 0, 0, undef, 0, '44:Enumeration', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\)(\\s+|$)', 0, 0, 0, undef, 0, '46:DefaultDecl', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse46DefaultDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(#REQUIRED|#IMPLIED)(\\s+|$)', 0, 0, 0, undef, 0, '39:AttDef', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '#FIXED(\\s+|$)', 0, 0, 0, undef, 0, '47:DefaultDecl AttValue', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '"', 0, 0, 0, undef, 0, '48:DefaultDecl AttValue qq', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'', 0, 0, 0, undef, 0, '49:DefaultDecl AttValue q', 'Value')) {
		return 1
	}
	return 0;
};

sub parse47DefaultDeclAttValue {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '"', 0, 0, 0, undef, 0, '48:DefaultDecl AttValue qq', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'', 0, 0, 0, undef, 0, '49:DefaultDecl AttValue q', 'Value')) {
		return 1
	}
	return 0;
};

sub parse48DefaultDeclAttValueqq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '39:AttDef', 'Value')) {
		return 1
	}
	return 0;
};

sub parse49DefaultDeclAttValueq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '39:AttDef', 'Value')) {
		return 1
	}
	return 0;
};

sub parse4XMLDeclEncoding {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*encoding\\s*', 0, 0, 0, undef, 0, '5:XMLDecl Encoding Eq', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\?>', 0, 0, 0, undef, 0, '11:Misc after XMLDecl', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse50EntityDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '52:GEDecl EntityValueOrExternalID', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, '61:PEDecl', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse51unused {
	my ($self, $text) = @_;
	return 0;
};

sub parse52GEDeclEntityValueOrExternalID {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '"', 0, 0, 0, undef, 0, '53:GEDecl EntityValue qq', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'', 0, 0, 0, undef, 0, '54:GEDecl EntityValue q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'PUBLIC(\\s+|$)', 0, 0, 0, undef, 0, '55:GEDecl PublicID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'SYSTEM(\\s+|$)', 0, 0, 0, undef, 0, '58:GEDecl SystemID', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse53GEDeclEntityValueqq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '[&%](?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '69:GEDecl endOrNDATA', 'Value')) {
		return 1
	}
	return 0;
};

sub parse54GEDeclEntityValueq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '[&%](?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '%', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '69:GEDecl endOrNDATA', 'Value')) {
		return 1
	}
	return 0;
};

sub parse55GEDeclPublicID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '56:GEDecl PublicID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '57:GEDecl PublicID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse56GEDeclPublicIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"(\\s+|$)', 0, 0, 0, undef, 0, '58:GEDecl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9\'()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse57GEDeclPublicIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'(\\s+|$)', 0, 0, 0, undef, 0, '58:GEDecl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse58GEDeclSystemID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '59:GEDecl SystemID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '60:GEDecl SystemID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse59GEDeclSystemIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '69:GEDecl endOrNDATA', 'Value')) {
		return 1
	}
	return 0;
};

sub parse5XMLDeclEncodingEq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, '6:XMLDecl Encoding', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};

sub parse60GEDeclSystemIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '69:GEDecl endOrNDATA', 'Value')) {
		return 1
	}
	return 0;
};

sub parse61PEDecl {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '62:PEDecl EntityValueOrExternalID', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse62PEDeclEntityValueOrExternalID {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '"', 0, 0, 0, undef, 0, '53:GEDecl EntityValue qq', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'', 0, 0, 0, undef, 0, '54:GEDecl EntityValue q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'PUBLIC(\\s+|$)', 0, 0, 0, undef, 0, '63:PEDecl PublicID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'SYSTEM(\\s+|$)', 0, 0, 0, undef, 0, '66:PEDecl SystemID', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse63PEDeclPublicID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '64:PEDecl PublicID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '65:PEDecl PublicID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse64PEDeclPublicIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"(\\s+|$)', 0, 0, 0, undef, 0, '66:PEDecl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9\'()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse65PEDeclPublicIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'(\\s+|$)', 0, 0, 0, undef, 0, '66:PEDecl SystemID', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse66PEDeclSystemID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '67:PEDecl SystemID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '68:PEDecl SystemID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse67PEDeclSystemIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '37:element end', 'Value')) {
		return 1
	}
	return 0;
};

sub parse68PEDeclSystemIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '37:element end', 'Value')) {
		return 1
	}
	return 0;
};

sub parse69GEDeclendOrNDATA {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'NDATA(\\s+|$)', 0, 0, 0, undef, 0, '70:GEDecl NDATA', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse6XMLDeclEncoding {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*("[A-Za-z][A-Za-z0-9._-]*"|\'[A-Za-z][A-Za-z0-9._-]*\')(?!s)\\s*', 0, 0, 0, undef, 0, '7:XMLDecl Standalone', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};

sub parse70GEDeclNDATA {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*', 0, 0, 0, undef, 0, '37:element end', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse71NotationDeclName {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*(\\s+|$)', 0, 0, 0, undef, 0, '72:NotationDecl ExternalID', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse72NotationDeclExternalID {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, 'PUBLIC(\\s+|$)', 0, 0, 0, undef, 0, '73:NotationDecl PublicID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, 'SYSTEM(\\s+|$)', 0, 0, 0, undef, 0, '66:PEDecl SystemID', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse73NotationDeclPublicID {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '74:NotationDecl PublicID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '75:NotationDecl PublicID q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse74NotationDeclPublicIDqq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"(\\s+|$)', 0, 0, 0, undef, 0, '76:NotationDecl SystemIDOrEnd', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9\'()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse75NotationDeclPublicIDq {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '\'(\\s+|$)', 0, 0, 0, undef, 0, '76:NotationDecl SystemIDOrEnd', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[ 
a-zA-Z0-9()+,./:=?;!*#@$_%-]', 0, 0, 0, undef, 0, '#stay', 'Value')) {
		return 1
	}
	return 0;
};

sub parse76NotationDeclSystemIDOrEnd {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '67:PEDecl SystemID qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '68:PEDecl SystemID q', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse77CommentinsideIS {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '--->', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '-->', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Comment')) {
		return 1
	}
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	return 0;
};

sub parse78PIinsideIS {
	my ($self, $text) = @_;
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '?', '>', 0, 0, 0, undef, 0, '23:Doctype Decl IS', 'Processing Instruction')) {
		return 1
	}
	return 0;
};

sub parse79Outside {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '<[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '80:STag', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '85:ETag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '85:ETag', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '</(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '85:ETag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!\\[CDATA\\[', 0, 0, 0, undef, 0, '86:CDSect', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<!--', 0, 0, 0, undef, 0, '87:Comment inside IS', 'Comment')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?xml-stylesheet(\\s|$)', 0, 0, 0, undef, 0, '88:PI inside IS', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '88:PI inside IS', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '88:PI inside IS', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '<\\?(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '88:PI inside IS', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\]\\]>', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	return 0;
};

sub parse7XMLDeclStandalone {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*standalone\\s*', 0, 0, 0, undef, 0, '8:XMLDecl Standalone Eq', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Doctype Declaration')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\?>', 0, 0, 0, undef, 0, '11:Misc after XMLDecl', 'Doctype Declaration')) {
		return 1
	}
	return 0;
};

sub parse80STag {
	my ($self, $text) = @_;
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '/', '>', 0, 0, 0, undef, 0, '79:Outside', 'Normal Tag')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '79:Outside', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '(xmlns:(\\w|[_.-])*|xmlns|xml:(lang|base|space))', 0, 0, 0, undef, 0, '81:STag Attribute', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '[xX][mM][lL](\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '81:STag Attribute', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|_)(\\w|[_.-])*(:(\\w|[_.-])+)?', 0, 0, 0, undef, 0, '81:STag Attribute', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[:_])(\\w|[:_.-])*', 0, 0, 0, undef, 0, '81:STag Attribute', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Normal Tag')) {
		return 1
	}
	return 0;
};

sub parse81STagAttribute {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '=', 0, 0, 0, undef, 0, '82:STag Attribute Value', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Normal Tag')) {
		return 1
	}
	return 0;
};

sub parse82STagAttributeValue {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '83:STag Value qq', 'Value')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '84:STag Value q', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Normal Tag')) {
		return 1
	}
	return 0;
};

sub parse83STagValueqq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '"(?=(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:]))', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '"(?=>|/>|\\s|$)', 0, 0, 0, undef, 0, '80:STag', 'Value')) {
		return 1
	}
	return 0;
};

sub parse84STagValueq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '&(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:])(\\w|[_:.-])*;', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '&#(x[0-9a-fA-F]+|[0-9]+);', 0, 0, 0, undef, 0, '#stay', 'Entity')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => DetectChar
	if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'(?=(?![٠-٩۰-۹०-९০-৯੦-੯૦-૯୦-୯௧-௯౦-౯೦-೯൦-൯๐-๙໐-໙༠-༩]|\\d)(\\w|[_:]))', 0, 0, 0, undef, 0, '80:STag', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\'(?=>|/>|\\s|$)', 0, 0, 0, undef, 0, '80:STag', 'Value')) {
		return 1
	}
	return 0;
};

sub parse85ETag {
	my ($self, $text) = @_;
	# type => DetectChar
	if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, '79:Outside', 'Normal Tag')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Normal Tag')) {
		return 1
	}
	return 0;
};

sub parse86CDSect {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\]\\]>', 0, 0, 0, undef, 0, '79:Outside', 'Entity')) {
		return 1
	}
	return 0;
};

sub parse87CommentinsideIS {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '--->', 0, 0, 0, undef, 0, '79:Outside', 'Error')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '-->', 0, 0, 0, undef, 0, '79:Outside', 'Comment')) {
		return 1
	}
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, '#stay', 'Error')) {
		return 1
	}
	return 0;
};

sub parse88PIinsideIS {
	my ($self, $text) = @_;
	# type => Detect2Chars
	if ($self->testDetect2Chars($text, '?', '>', 0, 0, 0, undef, 0, '79:Outside', 'Processing Instruction')) {
		return 1
	}
	return 0;
};

sub parse8XMLDeclStandaloneEq {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, '9:XMLDecl Standalone', 'Attribute')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};

sub parse9XMLDeclStandalone {
	my ($self, $text) = @_;
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s*"(yes|no)"|\'(yes|no)\'\\s*', 0, 0, 0, undef, 0, '10:XMLDecl Standalone', 'Value')) {
		return 1
	}
	# type => RegExpr
	if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
		return 1
	}
	return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::XML_Debug - a Plugin for XML (Debug) syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::XML_Debug;
 my $sh = new Syntax::Highlight::Engine::Kate::XML_Debug([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::XML_Debug is a  plugin module that provides syntax highlighting
for XML (Debug) to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author