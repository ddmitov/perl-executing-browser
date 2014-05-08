# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'apache.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.10
#kate author Jan Janssen (medhefgo@googlemail.com)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Apache_Configuration;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Error',
      'Alternates' => 'Keyword',
      'Attribute' => 'Others',
      'Comment' => 'Comment',
      'Container' => 'Function',
      'Directives' => 'Reserved',
      'Float' => 'Float',
      'Int' => 'Float',
      'Normal Text' => 'Normal',
      'Other' => 'Char',
      'String' => 'String',
   });
   $self->listAdd('Alternates',
      'All',
      'Allow,Deny',
      'Any',
      'Ascending',
      'AuthConfig',
      'Basic',
      'Block',
      'CompatEnvVars',
      'Connection',
      'Cookie',
      'Cookie2',
      'DB',
      'DNS',
      'Date',
      'Default',
      'Deny,Allow',
      'Descending',
      'Description',
      'Digest',
      'Double',
      'EMail',
      'ExecCGI',
      'ExportCertData',
      'FakeBasicAuth',
      'Fallback',
      'FileInfo',
      'Filters',
      'FollowSymLinks',
      'Full',
      'Full',
      'GDBM',
      'GDSF',
      'Handlers',
      'INode',
      'Ignore',
      'Includes',
      'IncludesNOEXEC',
      'Indexes',
      'Indexes',
      'IsError',
      'Keep-Alive',
      'LRU',
      'Limit',
      'MD5',
      'MD5-sess',
      'MTime',
      'Major',
      'Min',
      'Minimal',
      'Minor',
      'MultiViews',
      'Mutual-failure',
      'NDBM',
      'Name',
      'NegotiatedOnly',
      'Netscape',
      'None',
      'OS',
      'Off',
      'On',
      'OptRenegotiate',
      'Options',
      'Prefer',
      'Prod',
      'ProductOnly',
      'Proxy-Authenticate',
      'Proxy-Authorization',
      'RFC2109',
      'RFC2965',
      'Registry',
      'Registry-Strict',
      'SDBM',
      'SSL',
      'SSLv2',
      'SSLv3',
      'STARTTLS',
      'Script',
      'Size',
      'Size',
      'StartBody',
      'StdEnvVars',
      'StrictRequire',
      'SymLinksIfOwnerMatch',
      'TE',
      'TLS',
      'TLSv1',
      'Trailers',
      'Transfer-Encoding',
      'Upgrade',
      'alert',
      'always',
      'auth',
      'auth-int',
      'crit',
      'dbm:',
      'dc:',
      'debug',
      'emerg',
      'error',
      'error',
      'fcntl',
      'fcntl:',
      'file:',
      'finding',
      'flock',
      'flock:',
      'formatted',
      'info',
      'inherit',
      'map',
      'never',
      'no',
      'nocontent',
      'nonenotnull',
      'notice',
      'optional',
      'optional_no_ca',
      'posixsem',
      'posixsem',
      'pthread',
      'pthread',
      'referer',
      'require',
      'searching',
      'sem',
      'semiformatted',
      'shm:',
      'sysvsem',
      'sysvsem',
      'unformatted',
      'warn',
      'yes',
   );
   $self->listAdd('Alternative Directives',
      'AcceptMutex',
      'AcceptPathInfo',
      'AllowEncodedSlashes',
      'AllowOverride',
      'Anonymous_Authoritative',
      'Anonymous_LogEmail',
      'Anonymous_MustGiveEmail',
      'Anonymous_NoUserID',
      'Anonymous_VerifyEmail',
      'AuthAuthoritative',
      'AuthBasicAuthoritative',
      'AuthBasicProvider',
      'AuthDBMAuthoritative',
      'AuthDBMType',
      'AuthDefaultAuthoritative',
      'AuthDigestAlgorithm',
      'AuthDigestNcCheck',
      'AuthDigestQop',
      'AuthLDAPAuthoritative',
      'AuthLDAPCompareDNOnServer',
      'AuthLDAPDereferenceAliases',
      'AuthLDAPEnabled',
      'AuthLDAPFrontPageHack',
      'AuthLDAPGroupAttributeIsDN',
      'AuthLDAPRemoteUserIsDN',
      'AuthType',
      'AuthzDBMAuthoritative',
      'AuthzDBMType',
      'AuthzDefaultAuthoritative',
      'AuthzGroupFileAuthoritative',
      'AuthzLDAPAuthoritative',
      'AuthzOwnerAuthoritative',
      'AuthzUserAuthoritative',
      'BufferedLogs',
      'CacheExpiryCheck',
      'CacheIgnoreCacheControl',
      'CacheIgnoreHeaders',
      'CacheIgnoreNoLastMod',
      'CacheNegotiatedDocs',
      'CacheStoreNoStore',
      'CacheStorePrivate',
      'CheckSpelling',
      'ContentDigest',
      'CookieStyle',
      'CookieTracking',
      'CoreDumpDirectory',
      'CustomLog',
      'DavDepthInfinity',
      'DirectorySlash',
      'DumpIOInput',
      'DumpIOOutput',
      'EnableExceptionHook',
      'EnableMMAP',
      'EnableSendfile',
      'ExpiresActive',
      'ExtendedStatus',
      'FileETag',
      'ForceLanguagePriority',
      'HostnameLookups',
      'ISAPIAppendLogToErrors',
      'ISAPIAppendLogToQuery',
      'ISAPIFakeAsync',
      'ISAPILogNotSupported',
      'IdentityCheck',
      'ImapDefault',
      'ImapMenu',
      'IndexOrderDefault',
      'KeepAlive',
      'LDAPTrustedMode',
      'LDAPVerifyServerCert',
      'LogLevel',
      'MCacheRemovalAlgorithm',
      'MetaFiles',
      'ModMimeUsePathInfo',
      'MultiviewsMatch',
      'Options',
      'Order',
      'ProtocolEcho',
      'ProxyBadHeader',
      'ProxyErrorOverride',
      'ProxyPreserveHost',
      'ProxyRequests',
      'ProxyVia',
      'RewriteEngine',
      'RewriteOptions',
      'SSLEngine',
      'SSLMutex',
      'SSLOptions',
      'SSLProtocol',
      'SSLProxyEngine',
      'SSLProxyVerify',
      'SSLSessionCache',
      'SSLVerifyClient',
      'Satisfy',
      'ScriptInterpreterSource',
      'ServerSignature',
      'ServerTokens',
      'UseCanonicalName',
      'XBitHack',
   );
   $self->listAdd('Integer Directives',
      'AllowCONNECT',
      'AssignUserID',
      'AuthDigestNonceLifetime',
      'AuthDigestShmemSize',
      'CacheDefaultExpire',
      'CacheDirLength',
      'CacheDirLevels',
      'CacheForceCompletion',
      'CacheGcDaily',
      'CacheGcInterval',
      'CacheGcMemUsage',
      'CacheLastModifiedFactor',
      'CacheMaxExpire',
      'CacheMaxFileSize',
      'CacheMinFileSize',
      'CacheSize',
      'CacheTimeMargin',
      'ChildPerUserID',
      'CookieExpires',
      'DBDExptime',
      'DBDKeep',
      'DBDMax',
      'DBDMin',
      'DBDPersist',
      'DavMinTimeout',
      'DeflateBufferSize',
      'DeflateCompressionLevel',
      'DeflateMemLevel',
      'DeflateWindowSize',
      'ISAPIReadAheadBuffer',
      'IdentityCheckTimeout',
      'KeepAliveTimeout',
      'LDAPCacheEntries',
      'LDAPCacheTTL',
      'LDAPConnectionTimeout',
      'LDAPOpCacheEntries',
      'LDAPOpCacheTTL',
      'LDAPSharedCacheSize',
      'LimitInternalRecursion',
      'LimitRequestBody',
      'LimitRequestFields',
      'LimitRequestFieldsize',
      'LimitRequestLine',
      'LimitXMLRequestBody',
      'ListenBacklog',
      'MCacheMaxObjectCount',
      'MCacheMaxObjectSize',
      'MCacheMaxStreamingBuffer',
      'MCacheMinObjectSize',
      'MCacheSize',
      'MaxClients',
      'MaxKeepAliveRequests',
      'MaxMemFree',
      'MaxRequestsPerChild',
      'MaxRequestsPerThread',
      'MaxSpareServers',
      'MaxSpareThreads',
      'MaxThreads',
      'MaxThreadsPerChild',
      'MinSpareServers',
      'MinSpareThreads',
      'NumServers',
      'ProxyIOBufferSize',
      'ProxyMaxForwards',
      'ProxyReceiveBufferSize',
      'ProxyTimeout',
      'RLimitCPU',
      'RLimitMEM',
      'RLimitNPROC',
      'RewriteLogLevel',
      'SSLProxyVerifyDepth',
      'SSLSessionCacheTimeout',
      'SSLVerifyDepth',
      'ScriptLogBuffer',
      'ScriptLogLength',
      'SendBufferSize',
      'ServerLimit',
      'StartServers',
      'StartThreads',
      'ThreadLimit',
      'ThreadStackSize',
      'ThreadsPerChild',
      'TimeOut',
   );
   $self->listAdd('String Directives',
      'AcceptFilter',
      'AccessFileName',
      'Action',
      'AddAlt',
      'AddAltByEncoding',
      'AddAltByType',
      'AddCharset',
      'AddDefaultCharset',
      'AddDescription',
      'AddEncoding',
      'AddHandler',
      'AddIcon',
      'AddIconByEncoding',
      'AddIconByType',
      'AddInputFilter',
      'AddLanguage',
      'AddModuleInfo',
      'AddOutputFilter',
      'AddOutputFilterByType',
      'AddType',
      'Alias',
      'AliasMatch',
      'Allow',
      'Anonymous',
      'AuthBasicProvider',
      'AuthDBMGroupFile',
      'AuthDBMUserFile',
      'AuthDigestDomain',
      'AuthDigestFile',
      'AuthDigestGroupFile',
      'AuthDigestNonceFormat',
      'AuthDigestProvider',
      'AuthGroupFile',
      'AuthLDAPBindDN',
      'AuthLDAPBindPassword',
      'AuthLDAPCharsetConfig',
      'AuthLDAPGroupAttribute',
      'AuthLDAPUrl',
      'AuthName',
      'AuthUserFile',
      'BS2000Account',
      'BrowserMatch',
      'BrowserMatchNoCase',
      'CGIMapExtension',
      'CacheDisable',
      'CacheEnable',
      'CacheFile',
      'CacheGcClean',
      'CacheGcUnused',
      'CacheRoot',
      'CharsetDefault',
      'CharsetOptions',
      'CharsetSourceEnc',
      'CookieDomain',
      'CookieLog',
      'CookieName',
      'CoreDumpDirectory',
      'CustomLog',
      'DBDParams',
      'DBDPrepareSQL',
      'DBDriver',
      'Dav',
      'DavGenericLockDB',
      'DavLockDB',
      'DefaultIcon',
      'DefaultLanguage',
      'DefaultType',
      'DeflateFilterNote',
      'Deny',
      'DirectoryIndex',
      'DocumentRoot',
      'ErrorDocument',
      'ErrorLog',
      'Example',
      'ExpiresByType',
      'ExpiresDefault',
      'ExtFilterDefine',
      'ExtFilterOptions',
      'FilterChain',
      'FilterDeclare',
      'FilterProtocol',
      'FilterProvider',
      'FilterTrace',
      'ForceType',
      'ForensicLog',
      'Group',
      'Header',
      'HeaderName',
      'ISAPICacheFile',
      'ImapBase',
      'Include',
      'IndexIgnore',
      'IndexOptions',
      'IndexStyleSheet',
      'LDAPSharedCacheFile',
      'LDAPTrustedCA',
      'LDAPTrustedCAType',
      'LDAPTrustedClientCert',
      'LDAPTrustedGlobalCert',
      'LanguagePriority',
      'Listen',
      'LoadFile',
      'LoadModule',
      'LockFile',
      'LogFormat',
      'MMapFile',
      'MetaDir',
      'MetaSuffix',
      'MimeMagicFile',
      'NWSSLTrustedCerts',
      'NWSSLUpgradeable',
      'NameVirtualHost',
      'NoProxy',
      'PassEnv',
      'PidFile',
      'ProxyBlock',
      'ProxyDomain',
      'ProxyPass',
      'ProxyPassReverse',
      'ProxyPassReverseCookieDomain',
      'ProxyPassReverseCookiePath',
      'ProxyRemote',
      'ProxyRemoteMatch',
      'ReadmeName',
      'Redirect',
      'RedirectMatch',
      'RedirectPermanent',
      'RedirectTemp',
      'RemoveCharset',
      'RemoveEncoding',
      'RemoveHandler',
      'RemoveInputFilter',
      'RemoveLanguage',
      'RemoveOutputFilter',
      'RemoveType',
      'RequestHeader',
      'Require',
      'RewriteBase',
      'RewriteCond',
      'RewriteLock',
      'RewriteLog',
      'RewriteMap',
      'RewriteRule',
      'SSIEndTag',
      'SSIErrorMsg',
      'SSIStartTag',
      'SSITimeFormat',
      'SSIUndefinedEcho',
      'SSLCACertificateFile',
      'SSLCACertificatePath',
      'SSLCADNRequestFile',
      'SSLCADNRequestPath',
      'SSLCARevocationFile',
      'SSLCARevocationPath',
      'SSLCertificateChainFile',
      'SSLCertificateFile',
      'SSLCertificateKeyFile',
      'SSLCipherSuite',
      'SSLCryptoDevice',
      'SSLHonorCiperOrder',
      'SSLPassPhraseDialog',
      'SSLProxyCACertificateFile',
      'SSLProxyCACertificatePath',
      'SSLProxyCARevocationFile',
      'SSLProxyCARevocationPath',
      'SSLProxyCipherSuite',
      'SSLProxyMachineCertificateFile',
      'SSLProxyMachineCertificatePath',
      'SSLProxyProtocol',
      'SSLRandomSeed',
      'SSLRequire',
      'SSLRequireSSL',
      'SSLUserName',
      'ScoreBoardFile',
      'Script',
      'ScriptAlias',
      'ScriptAliasMatch',
      'ScriptLog',
      'ScriptSock',
      'SecureListen',
      'ServerAdmin',
      'ServerAlias',
      'ServerName',
      'ServerPath',
      'ServerRoot',
      'SetEnv',
      'SetEnvIf',
      'SetEnvIfNoCase',
      'SetHandler',
      'SetInputFilter',
      'SetOutputFilter',
      'SuexecUserGroup',
      'TransferLog',
      'TypesConfig',
      'UnsetEnv',
      'User',
      'UserDir',
      'VirtualDocumentRoot',
      'VirtualDocumentRootIP',
      'VirtualScriptAlias',
      'VirtualScriptAliasIP',
      'Win32DisableAcceptEx',
   );
   $self->contextdata({
      'Alert' => {
         callback => \&parseAlert,
         attribute => 'Alert',
         lineending => '#pop',
      },
      'Alternative Directives' => {
         callback => \&parseAlternativeDirectives,
         attribute => 'Other',
         lineending => '#pop',
      },
      'Comment' => {
         callback => \&parseComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Comment Alert' => {
         callback => \&parseCommentAlert,
         attribute => 'Normal Text',
         lineending => '#pop',
      },
      'Container Close' => {
         callback => \&parseContainerClose,
         attribute => 'Container',
         lineending => '#pop',
      },
      'Container Open' => {
         callback => \&parseContainerOpen,
         attribute => 'Container',
         lineending => '#pop',
      },
      'Integer Directives' => {
         callback => \&parseIntegerDirectives,
         attribute => 'Other',
         lineending => '#pop',
      },
      'String Directives' => {
         callback => \&parseStringDirectives,
         attribute => 'Directives',
         lineending => '#pop',
      },
      'apache' => {
         callback => \&parseapache,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|,');
   $self->basecontext('apache');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Apache Configuration';
}

sub parseAlert {
   my ($self, $text) = @_;
   return 0;
};

sub parseAlternativeDirectives {
   my ($self, $text) = @_;
   # String => 'Alternates'
   # attribute => 'Alternates'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Alternates', 0, undef, 0, '#stay', 'Alternates')) {
      return 1
   }
   # attribute => 'Alternates'
   # char => '-'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '-', 0, 0, 0, undef, 0, '#stay', 'Alternates')) {
      return 1
   }
   # attribute => 'Alternates'
   # char => '+'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '+', 0, 0, 0, undef, 0, '#stay', 'Alternates')) {
      return 1
   }
   # context => 'Comment Alert'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment Alert', $text)) {
      return 1
   }
   return 0;
};

sub parseComment {
   my ($self, $text) = @_;
   # type => 'DetectSpaces'
   if ($self->testDetectSpaces($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   # type => 'DetectIdentifier'
   if ($self->testDetectIdentifier($text, 0, undef, 0, '#stay', undef)) {
      return 1
   }
   return 0;
};

sub parseCommentAlert {
   my ($self, $text) = @_;
   # attribute => 'Alert'
   # char => '#'
   # context => 'Alert'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'Alert', 'Alert')) {
      return 1
   }
   return 0;
};

sub parseContainerClose {
   my ($self, $text) = @_;
   # attribute => 'Container'
   # char => '>'
   # context => 'Alert'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'Alert', 'Container')) {
      return 1
   }
   return 0;
};

sub parseContainerOpen {
   my ($self, $text) = @_;
   # attribute => 'Container'
   # char => '>'
   # context => 'Alert'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '>', 0, 0, 0, undef, 0, 'Alert', 'Container')) {
      return 1
   }
   # String => '[^#>]*'
   # attribute => 'Attribute'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^#>]*', 0, 0, 0, undef, 0, '#stay', 'Attribute')) {
      return 1
   }
   # context => 'Comment Alert'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment Alert', $text)) {
      return 1
   }
   return 0;
};

sub parseIntegerDirectives {
   my ($self, $text) = @_;
   # attribute => 'Float'
   # context => 'Integer Directives'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, 'Integer Directives', 'Float')) {
      return 1
   }
   # attribute => 'Int'
   # context => 'Integer Directives'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, 'Integer Directives', 'Int')) {
      return 1
   }
   # context => 'Comment Alert'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment Alert', $text)) {
      return 1
   }
   return 0;
};

sub parseStringDirectives {
   my ($self, $text) = @_;
   # String => '[^#]*'
   # attribute => 'String'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '[^#]*', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # context => 'Comment Alert'
   # type => 'IncludeRules'
   if ($self->includeRules('Comment Alert', $text)) {
      return 1
   }
   return 0;
};

sub parseapache {
   my ($self, $text) = @_;
   # String => 'String Directives'
   # context => 'String Directives'
   # type => 'keyword'
   if ($self->testKeyword($text, 'String Directives', 0, undef, 0, 'String Directives', undef)) {
      return 1
   }
   # String => 'Integer Directives'
   # attribute => 'Directives'
   # context => 'Integer Directives'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Integer Directives', 0, undef, 0, 'Integer Directives', 'Directives')) {
      return 1
   }
   # String => 'Alternative Directives'
   # attribute => 'Directives'
   # context => 'Alternative Directives'
   # type => 'keyword'
   if ($self->testKeyword($text, 'Alternative Directives', 0, undef, 0, 'Alternative Directives', 'Directives')) {
      return 1
   }
   # String => '<\w+'
   # attribute => 'Container'
   # beginRegion => 'Container'
   # context => 'Container Open'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\w+', 0, 0, 0, undef, 0, 'Container Open', 'Container')) {
      return 1
   }
   # String => '</\w+'
   # attribute => 'Container'
   # context => 'Container Close'
   # endRegion => 'Container'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '</\\w+', 0, 0, 0, undef, 0, 'Container Close', 'Container')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'Comment'
   # firstNonSpace => 'true'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 1, 'Comment', 'Comment')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Apache_Configuration - a Plugin for Apache Configuration syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Apache_Configuration;
 my $sh = new Syntax::Highlight::Engine::Kate::Apache_Configuration([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Apache_Configuration is a  plugin module that provides syntax highlighting
for Apache Configuration to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author