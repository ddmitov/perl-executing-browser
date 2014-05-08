# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'ldif.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#kate author Andreas Hochsteger (e9625392@student.tuwien.ac.at)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::LDIF;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'AttributeType' => 'DataType',
      'Comment' => 'Comment',
      'Description Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'ObjectClass' => 'Reserved',
      'Value (Encoded)' => 'BString',
      'Value (Encrypted)' => 'BaseN',
      'Value (Keyword)' => 'Float',
      'Value (Standard)' => 'String',
      'Value (URL)' => 'Others',
   });
   $self->listAdd('attributetypes',
      'IPPhone',
      'URL',
      'aRecord',
      'aliasedEntryName',
      'aliasedObjectName',
      'associatedDomain',
      'associatedName',
      'audio',
      'authorityRevocationList',
      'bootFile',
      'bootParameter',
      'buildingName',
      'businessCategory',
      'c',
      'cACertificate',
      'cNAMERecord',
      'certificateRevocationList',
      'cn',
      'comment',
      'commonName',
      'conferenceInformation',
      'corbaContainer',
      'corbaRepositoryId',
      'countryName',
      'crossCertificatePair',
      'custom1',
      'custom2',
      'custom3',
      'custom4',
      'dITRedirect',
      'dSAQuality',
      'dc',
      'deltaRevocationList',
      'description',
      'destinationIndicator',
      'distinguishedName',
      'dmdName',
      'dnQualifier',
      'documentAuthor',
      'documentIdentifier',
      'documentLocation',
      'documentPublisher',
      'documentTitle',
      'documentVersion',
      'domainComponent',
      'enhancedSearchGuide',
      'facsimileTelephoneNumber',
      'fax',
      'gecos',
      'generationQualifier',
      'gidNumber',
      'givenName',
      'gn',
      'homeDirectory',
      'homePostalAddress',
      'homeUrl',
      'host',
      'houseIdentifier',
      'info',
      'initials',
      'internationaliSDNNumber',
      'ipHostNumber',
      'ipNetmaskNumber',
      'ipNetworkNumber',
      'ipProtocolNumber',
      'ipServicePort',
      'ipServiceProtocol',
      'janetMailbox',
      'javaClassNames',
      'javaCodebase',
      'javaContainer',
      'javaDoc',
      'javaFactory',
      'javaReferenceAddress',
      'javaSerializedData',
      'knowledgeInformation',
      'l',
      'labeledURI',
      'lastModifiedBy',
      'lastModifiedTime',
      'lmpassword',
      'localityName',
      'loginShell',
      'mDRecord',
      'mXRecord',
      'macAddress',
      'mail',
      'manager',
      'member',
      'memberNisNetgroup',
      'memberUid',
      'mozillaHomeCountryName',
      'mozillaHomeFriendlyCountryName',
      'mozillaHomeLocalityName',
      'mozillaHomePostalAddress2',
      'mozillaHomePostalCode',
      'mozillaHomeState',
      'mozillaPostalAddress2',
      'mozillaSecondemail',
      'nSRecord',
      'name',
      'nisMapEntry',
      'nisMapName',
      'nisNetgroupTriple',
      'ntpasswd',
      'o',
      'objectClass',
      'oncRpcNumber',
      'organizationName',
      'organizationalStatus',
      'organizationalUnitName',
      'otherFacsimiletelephoneNumber',
      'otherMailbox',
      'ou',
      'owner',
      'personalSignature',
      'personalTitle',
      'photo',
      'physicalDeliveryOfficeName',
      'postOfficeBox',
      'postalAddress',
      'postalCode',
      'preferredDeliveryMethod',
      'presentationAddress',
      'protocolInformation',
      'rdn',
      'registeredAddress',
      'reports',
      'rfc822Mailbox',
      'roleOccupant',
      'roomNumber',
      'sOARecord',
      'searchGuide',
      'secretary',
      'seeAlso',
      'serialNumber',
      'shadowExpire',
      'shadowFlag',
      'shadowInactive',
      'shadowLastChange',
      'shadowMax',
      'shadowMin',
      'shadowWarning',
      'singleLevelQuality',
      'sn',
      'st',
      'stateOrProvinceName',
      'street',
      'streetAddress',
      'subtreeMaximumQuality',
      'subtreeMinimumQuality',
      'supportedAlgorithms',
      'supportedApplicationContext',
      'surname',
      'telephoneNumber',
      'teletexTerminalIdentifier',
      'telexNumber',
      'textEncodedORAddress',
      'title',
      'uid',
      'uidNumber',
      'uniqueIdentifier',
      'uniqueMember',
      'userCertificate',
      'userClass',
      'userPassword',
      'userid',
      'workUrl',
      'x121Address',
      'x500UniqueIdentifier',
      'xmozillaNickname',
      'xmozillaUseHtmlMail',
      'xmozillanickname',
      'xmozillausehtmlmail',
   );
   $self->listAdd('objectclasses',
      'RFC822localPart',
      'SUP',
      'account',
      'alias',
      'applicationEntity',
      'applicationProcess',
      'bootableDevice',
      'cRLDistributionPoint',
      'certificationAuthority',
      'certificationAuthority-V2',
      'corbaObject',
      'corbaObjectReference',
      'country',
      'dNSDomain',
      'dSA',
      'dcObject',
      'deltaCRL',
      'device',
      'dmd',
      'document',
      'documentSeries',
      'domain',
      'domainRelatedObject',
      'friendlyCountry',
      'groupOfNames',
      'groupOfUniqueNames',
      'ieee802Device',
      'inetOrgPerson',
      'ipHost',
      'ipNetwork',
      'ipProtocol',
      'ipService',
      'javaClassName',
      'javaMarshalledObject',
      'javaNamingReference',
      'javaObject',
      'javaSerializedObject',
      'labeledURIObject',
      'locality',
      'mozillaAbPersonObsolete',
      'nisMap',
      'nisNetgroup',
      'nisObject',
      'officePerson',
      'oncRpc',
      'organization',
      'organizationalPerson',
      'organizationalRole',
      'organizationalUnit',
      'pager',
      'pagerTelephoneNumber',
      'person',
      'pilotDSA',
      'pilotObject',
      'pilotOrganization',
      'pkiCA',
      'pkiUser',
      'posixAccount',
      'posixGroup',
      'qualityLabelledData',
      'residentialPerson',
      'rid',
      'room',
      'sambaAccount',
      'shadowAccount',
      'simpleSecurityObject',
      'strongAuthenticationUser',
      'telephoneNumber',
      'top',
      'uid',
      'uidNumber',
      'uidObject',
      'userSecurityInformation',
      'userid',
      'xmozillaanyphone',
      'zillaPerson',
   );
   $self->contextdata({
      'ctxEncoded' => {
         callback => \&parsectxEncoded,
         attribute => 'Value (Encoded)',
      },
      'ctxEncrypted' => {
         callback => \&parsectxEncrypted,
         attribute => 'Value (Encrypted)',
      },
      'ctxStandard' => {
         callback => \&parsectxStandard,
         attribute => 'Value (Standard)',
      },
      'ctxStart' => {
         callback => \&parsectxStart,
         attribute => 'Value (Standard)',
      },
      'ctxURL' => {
         callback => \&parsectxURL,
         attribute => 'Value (URL)',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('ctxStart');
   $self->keywordscase(1);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'LDIF';
}

sub parsectxEncoded {
   my ($self, $text) = @_;
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\s.*$'
   # attribute => 'Value (Encoded)'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s.*$', 0, 0, 0, undef, 0, '#stay', 'Value (Encoded)')) {
      return 1
   }
   # String => '[\w\-]+((;[\w\-]+)+)?:'
   # attribute => 'Description Keyword'
   # column => '0'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\-]+((;[\\w\\-]+)+)?:', 0, 0, 0, 0, 0, '#pop', 'Description Keyword')) {
      return 1
   }
   return 0;
};

sub parsectxEncrypted {
   my ($self, $text) = @_;
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\s.*$'
   # attribute => 'Value (Encrypted)'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s.*$', 0, 0, 0, undef, 0, '#stay', 'Value (Encrypted)')) {
      return 1
   }
   # String => '[\w\-]+((;[\w\-]+)+)?:'
   # attribute => 'Description Keyword'
   # column => '0'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\-]+((;[\\w\\-]+)+)?:', 0, 0, 0, 0, 0, '#pop#pop', 'Description Keyword')) {
      return 1
   }
   return 0;
};

sub parsectxStandard {
   my ($self, $text) = @_;
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\{\w+\}.*$'
   # attribute => 'Value (Encrypted)'
   # context => 'ctxEncrypted'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\{\\w+\\}.*$', 0, 0, 0, undef, 0, 'ctxEncrypted', 'Value (Encrypted)')) {
      return 1
   }
   # String => 'attributetypes'
   # attribute => 'AttributeType'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attributetypes', 0, undef, 0, '#stay', 'AttributeType')) {
      return 1
   }
   # String => 'objectclasses'
   # attribute => 'ObjectClass'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'objectclasses', 0, undef, 0, '#stay', 'ObjectClass')) {
      return 1
   }
   # String => '[\w\-]+((;[\w\-]+)+)?:'
   # attribute => 'Description Keyword'
   # column => '0'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\-]+((;[\\w\\-]+)+)?:', 0, 0, 0, 0, 0, '#pop', 'Description Keyword')) {
      return 1
   }
   # String => '[a-zA-Z0-9\-]+='
   # attribute => 'Value (Keyword)'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[a-zA-Z0-9\\-]+=', 0, 0, 0, undef, 0, '#stay', 'Value (Keyword)')) {
      return 1
   }
   return 0;
};

sub parsectxStart {
   my ($self, $text) = @_;
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Description Keyword'
   # char => ':'
   # context => 'ctxEncoded'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ':', 0, 0, 0, undef, 0, 'ctxEncoded', 'Description Keyword')) {
      return 1
   }
   # attribute => 'Description Keyword'
   # char => '<'
   # context => 'ctxURL'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '<', 0, 0, 0, undef, 0, 'ctxURL', 'Description Keyword')) {
      return 1
   }
   # String => '[^:<]'
   # attribute => 'Value (Standard)'
   # context => 'ctxStandard'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^:<]', 0, 0, 0, undef, 0, 'ctxStandard', 'Value (Standard)')) {
      return 1
   }
   # String => '[\w\-]+((;[\w\-]+)+)?:'
   # attribute => 'Description Keyword'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\-]+((;[\\w\\-]+)+)?:', 0, 0, 0, 0, 0, '#stay', 'Description Keyword')) {
      return 1
   }
   return 0;
};

sub parsectxURL {
   my ($self, $text) = @_;
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # String => '\s+[\w]+://[\w/.]+'
   # attribute => 'Value (URL)'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+[\\w]+://[\\w/.]+', 0, 0, 0, undef, 0, '#stay', 'Value (URL)')) {
      return 1
   }
   # String => '\s.*$'
   # attribute => 'Value (URL)'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s.*$', 0, 0, 0, undef, 0, '#stay', 'Value (URL)')) {
      return 1
   }
   # String => '[\w\-]+((;[\w\-]+)+)?:'
   # attribute => 'Description Keyword'
   # column => '0'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[\\w\\-]+((;[\\w\\-]+)+)?:', 0, 0, 0, 0, 0, '#pop', 'Description Keyword')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::LDIF - a Plugin for LDIF syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::LDIF;
 my $sh = new Syntax::Highlight::Engine::Kate::LDIF([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::LDIF is a  plugin module that provides syntax highlighting
for LDIF to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author