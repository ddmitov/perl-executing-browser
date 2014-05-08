# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'cisco.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.10
#kate version 2.4
#kate author Raphaël GRAPINET
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Cisco;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Char' => 'Char',
      'Command' => 'Normal',
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Others',
      'Parameter' => 'Others',
      'String' => 'String',
      'Substitution' => 'Others',
   });
   $self->listAdd('commands',
      'aaa',
      'access-list',
      'address',
      'alias',
      'arp',
      'async-bootp',
      'banner',
      'boot',
      'bridge',
      'buffers',
      'busy-message',
      'call-history-mib',
      'cdp',
      'chat-script',
      'class-map',
      'clock',
      'cns',
      'config-register',
      'controller',
      'crypto',
      'default',
      'default-value',
      'dialer',
      'dialer-list',
      'dnsix-dmdp',
      'dnsix-nat',
      'downward-compatible-config',
      'enable',
      'end',
      'exception',
      'exit',
      'file',
      'frame-relay',
      'help',
      'hostname',
      'interface',
      'ip',
      'isdn',
      'isdn-mib',
      'kerberos',
      'key',
      'line',
      'logging',
      'login-string',
      'map-class',
      'map-list',
      'memory-size',
      'menu',
      'modemcap',
      'multilink',
      'netbios',
      'no',
      'ntp',
      'partition',
      'policy-map',
      'priority-list',
      'privilege',
      'process-max-time',
      'prompt',
      'queue-list',
      'resume-string',
      'rlogin',
      'rmon',
      'route-map',
      'router',
      'rtr',
      'scheduler',
      'service',
      'snmp-server',
      'sntp',
      'stackmaker',
      'state-machine',
      'subscriber-policy',
      'tacacs-server',
      'template',
      'terminal-queue',
      'tftp-server',
      'time-range',
      'username',
      'virtual-profile',
      'virtual-template',
      'vpdn',
      'vpdn-group',
      'x25',
      'x29',
   );
   $self->listAdd('options',
      'accounting',
      'accounting-list',
      'accounting-threshold',
      'accounting-transits',
      'address-pool',
      'as-path',
      'audit',
      'auth-proxy',
      'authentication',
      'authorization',
      'bgp-community',
      'bootp',
      'cef',
      'classless',
      'community-list',
      'default-gateway',
      'default-network',
      'dhcp',
      'dhcp-server',
      'domain-list',
      'domain-lookup',
      'domain-name',
      'dvmrp',
      'exec-callback',
      'extcommunity-list',
      'finger',
      'flow-aggregation',
      'flow-cache',
      'flow-export',
      'forward-protocol',
      'ftp',
      'gratuitous-arps',
      'host',
      'host-routing',
      'hp-host',
      'http',
      'icmp',
      'inspect',
      'local',
      'mrm',
      'mroute',
      'msdp',
      'multicast',
      'multicast-routing',
      'name-server',
      'nat',
      'new-model',
      'ospf',
      'password',
      'password-encryption',
      'pgm',
      'pim',
      'port-map',
      'prefix-list',
      'radius',
      'rcmd',
      'reflexive-list',
      'route',
      'routing',
      'rsvp',
      'rtcp',
      'sap',
      'sdr',
      'security',
      'source-route',
      'subnet-zero',
      'tacacs',
      'tcp',
      'tcp-small-servers',
      'telnet',
      'tftp',
      'timestamps',
      'udp-small-servers',
      'vrf',
      'wccp',
   );
   $self->listAdd('parameters',
      'accounting',
      'accounting-list',
      'accounting-threshold',
      'accounting-transits',
      'address-pool',
      'as-path',
      'audit',
      'auth-proxy',
      'authentication',
      'authorization',
      'bgp-community',
      'bootp',
      'cef',
      'classless',
      'community-list',
      'default-gateway',
      'default-network',
      'dhcp',
      'dhcp-server',
      'domain-list',
      'domain-lookup',
      'domain-name',
      'dvmrp',
      'exec-callback',
      'extcommunity-list',
      'finger',
      'flow-aggregation',
      'flow-cache',
      'flow-export',
      'forward-protocol',
      'ftp',
      'gratuitous-arps',
      'host',
      'host-routing',
      'hp-host',
      'http',
      'icmp',
      'inspect',
      'local',
      'mrm',
      'mroute',
      'msdp',
      'multicast',
      'multicast-routing',
      'name-server',
      'nat',
      'new-model',
      'ospf',
      'password',
      'password-encryption',
      'pgm',
      'pim',
      'port-map',
      'prefix-list',
      'radius',
      'rcmd',
      'reflexive-list',
      'route',
      'routing',
      'rsvp',
      'rtcp',
      'sap',
      'sdr',
      'security',
      'source-route',
      'subnet-zero',
      'tacacs',
      'tcp',
      'tcp-small-servers',
      'telnet',
      'tftp',
      'timestamps',
      'udp-small-servers',
      'vrf',
      'wccp',
   );
   $self->contextdata({
      'Base' => {
         callback => \&parseBase,
         attribute => 'Normal Text',
      },
      'Parameter' => {
         callback => \&parseParameter,
         attribute => 'Parameter',
      },
      'Single Quote' => {
         callback => \&parseSingleQuote,
         attribute => 'String',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'Substitution' => {
         callback => \&parseSubstitution,
         attribute => 'Substitution',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Base');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Cisco';
}

sub parseBase {
   my ($self, $text) = @_;
   # String => '\bdone\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'dodone1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdone\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bdo\b'
   # attribute => 'Keyword'
   # beginRegion => 'dodone1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bdo\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\belif\b'
   # attribute => 'Keyword'
   # beginRegion => 'iffi1'
   # context => '#stay'
   # endRegion => 'iffi1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\belif\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bif\b'
   # attribute => 'Keyword'
   # beginRegion => 'iffi1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bif\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bfi\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'iffi1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bfi\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\bcase\b'
   # attribute => 'Keyword'
   # beginRegion => 'case1'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\bcase\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\besac\b'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'case1'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\besac\\b', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '[^()]+\)'
   # attribute => 'Keyword'
   # beginRegion => 'subcase1'
   # column => '0'
   # context => '#stay'
   # insensitive => 'TRUE'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^()]+\\)', 1, 0, 0, 0, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => ';'
   # char1 => ';'
   # context => '#stay'
   # endRegion => 'subcase1'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, ';', ';', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # beginRegion => 'func1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Keyword'
   # char => '}'
   # context => '#stay'
   # endRegion => 'func1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'commands'
   # attribute => 'Command'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'commands', 0, undef, 0, '#stay', 'Command')) {
      return 1
   }
   # String => 'parameters'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'parameters', 0, undef, 0, '#stay', 'Parameter')) {
      return 1
   }
   # String => 'options'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'options', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # String => '\$[A-Za-z0-9_?{}!]+'
   # attribute => 'Parameter'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z0-9_?{}!]+', 0, 0, 0, undef, 0, '#stay', 'Parameter')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # char1 => '"'
   # context => '#stay'
   # type => 'RangeDetect'
   if ($self->testRangeDetect($text, '"', '"', 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '|<>=;'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '|<>=;', 0, 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'Single Quote'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Single Quote', 'String')) {
      return 1
   }
   # attribute => 'Substitution'
   # char => '`'
   # context => 'Substitution'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, 'Substitution', 'Substitution')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '\'
   # char1 => '#'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '#', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '#.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseParameter {
   my ($self, $text) = @_;
   # String => '\$[A-Za-z0-9_?]+'
   # attribute => 'Parameter'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\$[A-Za-z0-9_?]+', 0, 0, 0, undef, 0, '#pop', 'Parameter')) {
      return 1
   }
   return 0;
};

sub parseSingleQuote {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '\'
   # char1 => '''
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\'', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '\'
   # char1 => '"'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '"', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parseSubstitution {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '\'
   # char1 => '\'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '\\', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '\'
   # char1 => '`'
   # context => '#stay'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '\\', '`', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'Substitution'
   # char => '`'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '`', 0, 0, 0, undef, 0, '#pop', 'Substitution')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Cisco - a Plugin for Cisco syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Cisco;
 my $sh = new Syntax::Highlight::Engine::Kate::Cisco([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Cisco is a  plugin module that provides syntax highlighting
for Cisco to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author