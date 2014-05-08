# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'jsp.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.4
#kate author Rob Martin (rob@gamepimp.com)
#generated: Sun Feb  3 22:02:05 2008, localtime

package Syntax::Highlight::Engine::Kate::JSP;

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
      'Comment' => 'Comment',
      'Decimal' => 'DecVal',
      'Float' => 'Float',
      'Hex' => 'BaseN',
      'Html Comment' => 'Comment',
      'Identifier' => 'Others',
      'Java 1.4.2 Classes' => 'Normal',
      'Java Comment' => 'Comment',
      'Jsp Comment' => 'Comment',
      'Jsp Directive' => 'Normal',
      'Jsp Expression' => 'Normal',
      'Jsp Param Name' => 'Others',
      'Jsp Param Value' => 'String',
      'Jsp Scriptlet' => 'Normal',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Octal' => 'BaseN',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Normal',
      'Types' => 'DataType',
   });
   $self->listAdd('java-1.4.2-classes',
      'ARG_IN',
      'ARG_INOUT',
      'ARG_OUT',
      'AWTError',
      'AWTEvent',
      'AWTEventListener',
      'AWTEventListenerProxy',
      'AWTEventMulticaster',
      'AWTException',
      'AWTKeyStroke',
      'AWTPermission',
      'AbstractAction',
      'AbstractBorder',
      'AbstractButton',
      'AbstractCellEditor',
      'AbstractCollection',
      'AbstractColorChooserPanel',
      'AbstractDocument',
      'AbstractFormatter',
      'AbstractFormatterFactory',
      'AbstractInterruptibleChannel',
      'AbstractLayoutCache',
      'AbstractList',
      'AbstractListModel',
      'AbstractMap',
      'AbstractMethodError',
      'AbstractPreferences',
      'AbstractSelectableChannel',
      'AbstractSelectionKey',
      'AbstractSelector',
      'AbstractSequentialList',
      'AbstractSet',
      'AbstractSpinnerModel',
      'AbstractTableModel',
      'AbstractUndoableEdit',
      'AbstractWriter',
      'AccessControlContext',
      'AccessControlException',
      'AccessController',
      'AccessException',
      'Accessible',
      'AccessibleAction',
      'AccessibleBundle',
      'AccessibleComponent',
      'AccessibleContext',
      'AccessibleEditableText',
      'AccessibleExtendedComponent',
      'AccessibleExtendedTable',
      'AccessibleHyperlink',
      'AccessibleHypertext',
      'AccessibleIcon',
      'AccessibleKeyBinding',
      'AccessibleObject',
      'AccessibleRelation',
      'AccessibleRelationSet',
      'AccessibleResourceBundle',
      'AccessibleRole',
      'AccessibleSelection',
      'AccessibleState',
      'AccessibleStateSet',
      'AccessibleTable',
      'AccessibleTableModelChange',
      'AccessibleText',
      'AccessibleValue',
      'AccountExpiredException',
      'Acl',
      'AclEntry',
      'AclNotFoundException',
      'Action',
      'ActionEvent',
      'ActionListener',
      'ActionMap',
      'ActionMapUIResource',
      'Activatable',
      'ActivateFailedException',
      'ActivationDesc',
      'ActivationException',
      'ActivationGroup',
      'ActivationGroupDesc',
      'ActivationGroupID',
      'ActivationGroup_Stub',
      'ActivationID',
      'ActivationInstantiator',
      'ActivationMonitor',
      'ActivationSystem',
      'Activator',
      'ActiveEvent',
      'ActiveValue',
      'AdapterActivator',
      'AdapterActivatorOperations',
      'AdapterAlreadyExists',
      'AdapterAlreadyExistsHelper',
      'AdapterInactive',
      'AdapterInactiveHelper',
      'AdapterNonExistent',
      'AdapterNonExistentHelper',
      'AddressHelper',
      'Adjustable',
      'AdjustmentEvent',
      'AdjustmentListener',
      'Adler32',
      'AffineTransform',
      'AffineTransformOp',
      'AlgorithmParameterGenerator',
      'AlgorithmParameterGeneratorSpi',
      'AlgorithmParameterSpec',
      'AlgorithmParameters',
      'AlgorithmParametersSpi',
      'AlignmentAction',
      'AllPermission',
      'AlphaComposite',
      'AlreadyBound',
      'AlreadyBoundException',
      'AlreadyBoundHelper',
      'AlreadyBoundHolder',
      'AlreadyConnectedException',
      'AncestorEvent',
      'AncestorListener',
      'Annotation',
      'Any',
      'AnyHolder',
      'AnySeqHelper',
      'AnySeqHelper',
      'AnySeqHolder',
      'AppConfigurationEntry',
      'Applet',
      'AppletContext',
      'AppletInitializer',
      'AppletStub',
      'ApplicationException',
      'Arc2D',
      'Area',
      'AreaAveragingScaleFilter',
      'ArithmeticException',
      'Array',
      'Array',
      'ArrayIndexOutOfBoundsException',
      'ArrayList',
      'ArrayStoreException',
      'Arrays',
      'AssertionError',
      'AsyncBoxView',
      'AsynchronousCloseException',
      'Attr',
      'Attribute',
      'Attribute',
      'Attribute',
      'Attribute',
      'Attribute',
      'AttributeContext',
      'AttributeException',
      'AttributeInUseException',
      'AttributeList',
      'AttributeList',
      'AttributeListImpl',
      'AttributeModificationException',
      'AttributeSet',
      'AttributeSet',
      'AttributeSetUtilities',
      'AttributeUndoableEdit',
      'AttributedCharacterIterator',
      'AttributedString',
      'Attributes',
      'Attributes',
      'Attributes',
      'AttributesImpl',
      'AudioClip',
      'AudioFileFormat',
      'AudioFileReader',
      'AudioFileWriter',
      'AudioFormat',
      'AudioInputStream',
      'AudioPermission',
      'AudioSystem',
      'AuthPermission',
      'AuthenticationException',
      'AuthenticationNotSupportedException',
      'Authenticator',
      'Autoscroll',
      'BAD_CONTEXT',
      'BAD_INV_ORDER',
      'BAD_OPERATION',
      'BAD_PARAM',
      'BAD_POLICY',
      'BAD_POLICY_TYPE',
      'BAD_POLICY_VALUE',
      'BAD_TYPECODE',
      'BCSIterator',
      'BCSSServiceProvider',
      'BYTE_ARRAY',
      'BackingStoreException',
      'BadKind',
      'BadLocationException',
      'BadPaddingException',
      'BandCombineOp',
      'BandedSampleModel',
      'BasicArrowButton',
      'BasicAttribute',
      'BasicAttributes',
      'BasicBorders',
      'BasicButtonListener',
      'BasicButtonUI',
      'BasicCaret',
      'BasicCheckBoxMenuItemUI',
      'BasicCheckBoxUI',
      'BasicColorChooserUI',
      'BasicComboBoxEditor',
      'BasicComboBoxRenderer',
      'BasicComboBoxUI',
      'BasicComboPopup',
      'BasicDesktopIconUI',
      'BasicDesktopPaneUI',
      'BasicDirectoryModel',
      'BasicEditorPaneUI',
      'BasicFileChooserUI',
      'BasicFormattedTextFieldUI',
      'BasicGraphicsUtils',
      'BasicHTML',
      'BasicHighlighter',
      'BasicIconFactory',
      'BasicInternalFrameTitlePane',
      'BasicInternalFrameUI',
      'BasicLabelUI',
      'BasicListUI',
      'BasicLookAndFeel',
      'BasicMenuBarUI',
      'BasicMenuItemUI',
      'BasicMenuUI',
      'BasicOptionPaneUI',
      'BasicPanelUI',
      'BasicPasswordFieldUI',
      'BasicPermission',
      'BasicPopupMenuSeparatorUI',
      'BasicPopupMenuUI',
      'BasicProgressBarUI',
      'BasicRadioButtonMenuItemUI',
      'BasicRadioButtonUI',
      'BasicRootPaneUI',
      'BasicScrollBarUI',
      'BasicScrollPaneUI',
      'BasicSeparatorUI',
      'BasicSliderUI',
      'BasicSpinnerUI',
      'BasicSplitPaneDivider',
      'BasicSplitPaneUI',
      'BasicStroke',
      'BasicTabbedPaneUI',
      'BasicTableHeaderUI',
      'BasicTableUI',
      'BasicTextAreaUI',
      'BasicTextFieldUI',
      'BasicTextPaneUI',
      'BasicTextUI',
      'BasicToggleButtonUI',
      'BasicToolBarSeparatorUI',
      'BasicToolBarUI',
      'BasicToolTipUI',
      'BasicTreeUI',
      'BasicViewportUI',
      'BatchUpdateException',
      'BeanContext',
      'BeanContextChild',
      'BeanContextChildComponentProxy',
      'BeanContextChildSupport',
      'BeanContextContainerProxy',
      'BeanContextEvent',
      'BeanContextMembershipEvent',
      'BeanContextMembershipListener',
      'BeanContextProxy',
      'BeanContextServiceAvailableEvent',
      'BeanContextServiceProvider',
      'BeanContextServiceProviderBeanInfo',
      'BeanContextServiceRevokedEvent',
      'BeanContextServiceRevokedListener',
      'BeanContextServices',
      'BeanContextServicesListener',
      'BeanContextServicesSupport',
      'BeanContextSupport',
      'BeanDescriptor',
      'BeanInfo',
      'Beans',
      'BeepAction',
      'BevelBorder',
      'BevelBorderUIResource',
      'Bias',
      'Bidi',
      'BigDecimal',
      'BigInteger',
      'BinaryRefAddr',
      'BindException',
      'Binding',
      'Binding',
      'BindingHelper',
      'BindingHolder',
      'BindingIterator',
      'BindingIteratorHelper',
      'BindingIteratorHolder',
      'BindingIteratorOperations',
      'BindingIteratorPOA',
      'BindingListHelper',
      'BindingListHolder',
      'BindingType',
      'BindingTypeHelper',
      'BindingTypeHolder',
      'BitSet',
      'Blob',
      'BlockView',
      'BoldAction',
      'Book',
      'Boolean',
      'BooleanControl',
      'BooleanHolder',
      'BooleanSeqHelper',
      'BooleanSeqHolder',
      'Border',
      'BorderFactory',
      'BorderLayout',
      'BorderUIResource',
      'BoundedRangeModel',
      'Bounds',
      'Bounds',
      'Box',
      'BoxLayout',
      'BoxPainter',
      'BoxView',
      'BoxedValueHelper',
      'BreakIterator',
      'Buffer',
      'BufferCapabilities',
      'BufferOverflowException',
      'BufferStrategy',
      'BufferUnderflowException',
      'BufferedImage',
      'BufferedImageFilter',
      'BufferedImageOp',
      'BufferedInputStream',
      'BufferedOutputStream',
      'BufferedReader',
      'BufferedWriter',
      'Button',
      'ButtonAreaLayout',
      'ButtonBorder',
      'ButtonBorder',
      'ButtonGroup',
      'ButtonModel',
      'ButtonUI',
      'Byte',
      'ByteArrayInputStream',
      'ByteArrayOutputStream',
      'ByteBuffer',
      'ByteChannel',
      'ByteHolder',
      'ByteLookupTable',
      'ByteOrder',
      'CDATASection',
      'CHAR_ARRAY',
      'CMMException',
      'COMM_FAILURE',
      'CRC32',
      'CRL',
      'CRLException',
      'CRLSelector',
      'CSS',
      'CTX_RESTRICT_SCOPE',
      'Calendar',
      'CallableStatement',
      'Callback',
      'CallbackHandler',
      'CancelablePrintJob',
      'CancelledKeyException',
      'CannotProceed',
      'CannotProceedException',
      'CannotProceedHelper',
      'CannotProceedHolder',
      'CannotRedoException',
      'CannotUndoException',
      'Canvas',
      'CardLayout',
      'Caret',
      'CaretEvent',
      'CaretListener',
      'CaretPolicy',
      'CellEditor',
      'CellEditorListener',
      'CellRendererPane',
      'CertPath',
      'CertPathBuilder',
      'CertPathBuilderException',
      'CertPathBuilderResult',
      'CertPathBuilderSpi',
      'CertPathParameters',
      'CertPathRep',
      'CertPathValidator',
      'CertPathValidatorException',
      'CertPathValidatorResult',
      'CertPathValidatorSpi',
      'CertSelector',
      'CertStore',
      'CertStoreException',
      'CertStoreParameters',
      'CertStoreSpi',
      'Certificate',
      'Certificate',
      'Certificate',
      'CertificateEncodingException',
      'CertificateEncodingException',
      'CertificateException',
      'CertificateException',
      'CertificateExpiredException',
      'CertificateExpiredException',
      'CertificateFactory',
      'CertificateFactorySpi',
      'CertificateNotYetValidException',
      'CertificateNotYetValidException',
      'CertificateParsingException',
      'CertificateParsingException',
      'CertificateRep',
      'ChangeEvent',
      'ChangeListener',
      'ChangedCharSetException',
      'Channel',
      'ChannelBinding',
      'Channels',
      'CharArrayReader',
      'CharArrayWriter',
      'CharBuffer',
      'CharConversionException',
      'CharHolder',
      'CharSeqHelper',
      'CharSeqHolder',
      'CharSequence',
      'Character',
      'CharacterAttribute',
      'CharacterCodingException',
      'CharacterConstants',
      'CharacterData',
      'CharacterIterator',
      'Charset',
      'CharsetDecoder',
      'CharsetEncoder',
      'CharsetProvider',
      'Checkbox',
      'CheckboxGroup',
      'CheckboxMenuItem',
      'CheckedInputStream',
      'CheckedOutputStream',
      'Checksum',
      'Choice',
      'ChoiceCallback',
      'ChoiceFormat',
      'Chromaticity',
      'Cipher',
      'CipherInputStream',
      'CipherOutputStream',
      'CipherSpi',
      'Class',
      'ClassCastException',
      'ClassCircularityError',
      'ClassDesc',
      'ClassFormatError',
      'ClassLoader',
      'ClassNotFoundException',
      'ClientRequestInfo',
      'ClientRequestInfoOperations',
      'ClientRequestInterceptor',
      'ClientRequestInterceptorOperations',
      'Clip',
      'Clipboard',
      'ClipboardOwner',
      'Clob',
      'CloneNotSupportedException',
      'Cloneable',
      'ClosedByInterruptException',
      'ClosedChannelException',
      'ClosedSelectorException',
      'CodeSets',
      'CodeSource',
      'Codec',
      'CodecFactory',
      'CodecFactoryHelper',
      'CodecFactoryOperations',
      'CodecOperations',
      'CoderMalfunctionError',
      'CoderResult',
      'CodingErrorAction',
      'CollationElementIterator',
      'CollationKey',
      'Collator',
      'Collection',
      'CollectionCertStoreParameters',
      'Collections',
      'Color',
      'ColorAttribute',
      'ColorChooserComponentFactory',
      'ColorChooserUI',
      'ColorConstants',
      'ColorConvertOp',
      'ColorModel',
      'ColorSelectionModel',
      'ColorSpace',
      'ColorSupported',
      'ColorType',
      'ColorUIResource',
      'ComboBoxEditor',
      'ComboBoxModel',
      'ComboBoxUI',
      'ComboPopup',
      'CommandEnvironment',
      'Comment',
      'CommunicationException',
      'Comparable',
      'Comparator',
      'Compiler',
      'CompletionStatus',
      'CompletionStatusHelper',
      'Component',
      'ComponentAdapter',
      'ComponentColorModel',
      'ComponentEvent',
      'ComponentIdHelper',
      'ComponentInputMap',
      'ComponentInputMapUIResource',
      'ComponentListener',
      'ComponentOrientation',
      'ComponentSampleModel',
      'ComponentUI',
      'ComponentView',
      'Composite',
      'CompositeContext',
      'CompositeName',
      'CompositeView',
      'CompoundBorder',
      'CompoundBorderUIResource',
      'CompoundControl',
      'CompoundEdit',
      'CompoundName',
      'Compression',
      'ConcurrentModificationException',
      'Configuration',
      'ConfigurationException',
      'ConfirmationCallback',
      'ConnectException',
      'ConnectException',
      'ConnectIOException',
      'Connection',
      'ConnectionEvent',
      'ConnectionEventListener',
      'ConnectionPendingException',
      'ConnectionPoolDataSource',
      'ConsoleHandler',
      'Constraints',
      'Constructor',
      'Container',
      'ContainerAdapter',
      'ContainerEvent',
      'ContainerListener',
      'ContainerOrderFocusTraversalPolicy',
      'Content',
      'ContentHandler',
      'ContentHandler',
      'ContentHandlerFactory',
      'ContentModel',
      'Context',
      'Context',
      'ContextList',
      'ContextNotEmptyException',
      'ContextualRenderedImageFactory',
      'Control',
      'Control',
      'ControlFactory',
      'ControllerEventListener',
      'ConvolveOp',
      'CookieHolder',
      'Copies',
      'CopiesSupported',
      'CopyAction',
      'CredentialExpiredException',
      'CropImageFilter',
      'CubicCurve2D',
      'Currency',
      'Current',
      'Current',
      'Current',
      'CurrentHelper',
      'CurrentHelper',
      'CurrentHelper',
      'CurrentHolder',
      'CurrentOperations',
      'CurrentOperations',
      'CurrentOperations',
      'Cursor',
      'CustomMarshal',
      'CustomValue',
      'Customizer',
      'CutAction',
      'DATA_CONVERSION',
      'DESKeySpec',
      'DESedeKeySpec',
      'DGC',
      'DHGenParameterSpec',
      'DHKey',
      'DHParameterSpec',
      'DHPrivateKey',
      'DHPrivateKeySpec',
      'DHPublicKey',
      'DHPublicKeySpec',
      'DOMException',
      'DOMImplementation',
      'DOMLocator',
      'DOMResult',
      'DOMSource',
      'DSAKey',
      'DSAKeyPairGenerator',
      'DSAParameterSpec',
      'DSAParams',
      'DSAPrivateKey',
      'DSAPrivateKeySpec',
      'DSAPublicKey',
      'DSAPublicKeySpec',
      'DTD',
      'DTDConstants',
      'DTDHandler',
      'DataBuffer',
      'DataBufferByte',
      'DataBufferDouble',
      'DataBufferFloat',
      'DataBufferInt',
      'DataBufferShort',
      'DataBufferUShort',
      'DataFlavor',
      'DataFormatException',
      'DataInput',
      'DataInputStream',
      'DataInputStream',
      'DataLine',
      'DataOutput',
      'DataOutputStream',
      'DataOutputStream',
      'DataSource',
      'DataTruncation',
      'DatabaseMetaData',
      'DatagramChannel',
      'DatagramPacket',
      'DatagramSocket',
      'DatagramSocketImpl',
      'DatagramSocketImplFactory',
      'Date',
      'Date',
      'DateEditor',
      'DateFormat',
      'DateFormatSymbols',
      'DateFormatter',
      'DateTimeAtCompleted',
      'DateTimeAtCreation',
      'DateTimeAtProcessing',
      'DateTimeSyntax',
      'DebugGraphics',
      'DecimalFormat',
      'DecimalFormatSymbols',
      'DeclHandler',
      'DefaultBoundedRangeModel',
      'DefaultButtonModel',
      'DefaultCaret',
      'DefaultCellEditor',
      'DefaultColorSelectionModel',
      'DefaultComboBoxModel',
      'DefaultDesktopManager',
      'DefaultEditor',
      'DefaultEditorKit',
      'DefaultFocusManager',
      'DefaultFocusTraversalPolicy',
      'DefaultFormatter',
      'DefaultFormatterFactory',
      'DefaultHandler',
      'DefaultHighlightPainter',
      'DefaultHighlighter',
      'DefaultKeyTypedAction',
      'DefaultKeyboardFocusManager',
      'DefaultListCellRenderer',
      'DefaultListModel',
      'DefaultListSelectionModel',
      'DefaultMenuLayout',
      'DefaultMetalTheme',
      'DefaultMutableTreeNode',
      'DefaultPersistenceDelegate',
      'DefaultSelectionType',
      'DefaultSingleSelectionModel',
      'DefaultStyledDocument',
      'DefaultTableCellRenderer',
      'DefaultTableColumnModel',
      'DefaultTableModel',
      'DefaultTextUI',
      'DefaultTreeCellEditor',
      'DefaultTreeCellRenderer',
      'DefaultTreeModel',
      'DefaultTreeSelectionModel',
      'DefinitionKind',
      'DefinitionKindHelper',
      'Deflater',
      'DeflaterOutputStream',
      'Delegate',
      'Delegate',
      'Delegate',
      'DelegationPermission',
      'DesignMode',
      'DesktopIconUI',
      'DesktopManager',
      'DesktopPaneUI',
      'Destination',
      'DestinationType',
      'DestroyFailedException',
      'Destroyable',
      'Dialog',
      'DialogType',
      'Dictionary',
      'DigestException',
      'DigestInputStream',
      'DigestOutputStream',
      'Dimension',
      'Dimension2D',
      'DimensionUIResource',
      'DirContext',
      'DirObjectFactory',
      'DirStateFactory',
      'DirectColorModel',
      'DirectoryManager',
      'DisplayMode',
      'DnDConstants',
      'Doc',
      'DocAttribute',
      'DocAttributeSet',
      'DocFlavor',
      'DocPrintJob',
      'Document',
      'Document',
      'DocumentBuilder',
      'DocumentBuilderFactory',
      'DocumentEvent',
      'DocumentFilter',
      'DocumentFragment',
      'DocumentHandler',
      'DocumentListener',
      'DocumentName',
      'DocumentParser',
      'DocumentType',
      'DomainCombiner',
      'DomainManager',
      'DomainManagerOperations',
      'Double',
      'Double',
      'Double',
      'Double',
      'Double',
      'Double',
      'Double',
      'Double',
      'Double',
      'DoubleBuffer',
      'DoubleHolder',
      'DoubleSeqHelper',
      'DoubleSeqHolder',
      'DragGestureEvent',
      'DragGestureListener',
      'DragGestureRecognizer',
      'DragSource',
      'DragSourceAdapter',
      'DragSourceContext',
      'DragSourceDragEvent',
      'DragSourceDropEvent',
      'DragSourceEvent',
      'DragSourceListener',
      'DragSourceMotionListener',
      'Driver',
      'DriverManager',
      'DriverPropertyInfo',
      'DropTarget',
      'DropTargetAdapter',
      'DropTargetAutoScroller',
      'DropTargetContext',
      'DropTargetDragEvent',
      'DropTargetDropEvent',
      'DropTargetEvent',
      'DropTargetListener',
      'DuplicateName',
      'DuplicateNameHelper',
      'DynAny',
      'DynAny',
      'DynAnyFactory',
      'DynAnyFactoryHelper',
      'DynAnyFactoryOperations',
      'DynAnyHelper',
      'DynAnyOperations',
      'DynAnySeqHelper',
      'DynArray',
      'DynArray',
      'DynArrayHelper',
      'DynArrayOperations',
      'DynEnum',
      'DynEnum',
      'DynEnumHelper',
      'DynEnumOperations',
      'DynFixed',
      'DynFixed',
      'DynFixedHelper',
      'DynFixedOperations',
      'DynSequence',
      'DynSequence',
      'DynSequenceHelper',
      'DynSequenceOperations',
      'DynStruct',
      'DynStruct',
      'DynStructHelper',
      'DynStructOperations',
      'DynUnion',
      'DynUnion',
      'DynUnionHelper',
      'DynUnionOperations',
      'DynValue',
      'DynValue',
      'DynValueBox',
      'DynValueBoxOperations',
      'DynValueCommon',
      'DynValueCommonOperations',
      'DynValueHelper',
      'DynValueOperations',
      'DynamicImplementation',
      'DynamicImplementation',
      'DynamicUtilTreeNode',
      'ENCODING_CDR_ENCAPS',
      'EOFException',
      'EditorKit',
      'Element',
      'Element',
      'Element',
      'ElementChange',
      'ElementEdit',
      'ElementIterator',
      'ElementSpec',
      'Ellipse2D',
      'EmptyBorder',
      'EmptyBorderUIResource',
      'EmptySelectionModel',
      'EmptyStackException',
      'EncodedKeySpec',
      'Encoder',
      'Encoding',
      'Encoding',
      'EncryptedPrivateKeyInfo',
      'Engineering',
      'Entity',
      'Entity',
      'EntityReference',
      'EntityResolver',
      'Entry',
      'EnumControl',
      'EnumSyntax',
      'Enumeration',
      'Environment',
      'Error',
      'ErrorHandler',
      'ErrorListener',
      'ErrorManager',
      'EtchedBorder',
      'EtchedBorderUIResource',
      'Event',
      'EventContext',
      'EventDirContext',
      'EventHandler',
      'EventListener',
      'EventListenerList',
      'EventListenerProxy',
      'EventObject',
      'EventQueue',
      'EventSetDescriptor',
      'EventType',
      'EventType',
      'Exception',
      'ExceptionInInitializerError',
      'ExceptionList',
      'ExceptionListener',
      'ExemptionMechanism',
      'ExemptionMechanismException',
      'ExemptionMechanismSpi',
      'ExpandVetoException',
      'ExportException',
      'Expression',
      'ExtendedRequest',
      'ExtendedResponse',
      'Externalizable',
      'FREE_MEM',
      'FactoryConfigurationError',
      'FailedLoginException',
      'FeatureDescriptor',
      'Fidelity',
      'Field',
      'Field',
      'Field',
      'Field',
      'Field',
      'FieldBorder',
      'FieldNameHelper',
      'FieldNameHelper',
      'FieldPosition',
      'FieldView',
      'File',
      'FileCacheImageInputStream',
      'FileCacheImageOutputStream',
      'FileChannel',
      'FileChooserUI',
      'FileDescriptor',
      'FileDialog',
      'FileFilter',
      'FileFilter',
      'FileHandler',
      'FileIcon16',
      'FileImageInputStream',
      'FileImageOutputStream',
      'FileInputStream',
      'FileLock',
      'FileLockInterruptionException',
      'FileNameMap',
      'FileNotFoundException',
      'FileOutputStream',
      'FilePermission',
      'FileReader',
      'FileSystemView',
      'FileView',
      'FileWriter',
      'FilenameFilter',
      'Filler',
      'Filter',
      'Filter',
      'FilterBypass',
      'FilterBypass',
      'FilterInputStream',
      'FilterOutputStream',
      'FilterReader',
      'FilterWriter',
      'FilteredImageSource',
      'Finishings',
      'FixedHeightLayoutCache',
      'FixedHolder',
      'FlatteningPathIterator',
      'FlavorException',
      'FlavorMap',
      'FlavorTable',
      'FlipContents',
      'Float',
      'Float',
      'Float',
      'Float',
      'Float',
      'Float',
      'Float',
      'Float',
      'Float',
      'FloatBuffer',
      'FloatControl',
      'FloatHolder',
      'FloatSeqHelper',
      'FloatSeqHolder',
      'FlowLayout',
      'FlowStrategy',
      'FlowView',
      'Flush3DBorder',
      'FocusAdapter',
      'FocusEvent',
      'FocusListener',
      'FocusManager',
      'FocusTraversalPolicy',
      'FolderIcon16',
      'Font',
      'FontAttribute',
      'FontConstants',
      'FontFamilyAction',
      'FontFormatException',
      'FontMetrics',
      'FontRenderContext',
      'FontSizeAction',
      'FontUIResource',
      'ForegroundAction',
      'FormView',
      'Format',
      'FormatConversionProvider',
      'FormatMismatch',
      'FormatMismatchHelper',
      'Formatter',
      'ForwardRequest',
      'ForwardRequest',
      'ForwardRequestHelper',
      'ForwardRequestHelper',
      'Frame',
      'GSSContext',
      'GSSCredential',
      'GSSException',
      'GSSManager',
      'GSSName',
      'GZIPInputStream',
      'GZIPOutputStream',
      'GapContent',
      'GatheringByteChannel',
      'GeneralPath',
      'GeneralSecurityException',
      'GetField',
      'GlyphJustificationInfo',
      'GlyphMetrics',
      'GlyphPainter',
      'GlyphVector',
      'GlyphView',
      'GradientPaint',
      'GraphicAttribute',
      'Graphics',
      'Graphics2D',
      'GraphicsConfigTemplate',
      'GraphicsConfiguration',
      'GraphicsDevice',
      'GraphicsEnvironment',
      'GrayFilter',
      'GregorianCalendar',
      'GridBagConstraints',
      'GridBagLayout',
      'GridLayout',
      'Group',
      'Guard',
      'GuardedObject',
      'HTML',
      'HTMLDocument',
      'HTMLEditorKit',
      'HTMLEditorKit',
      'HTMLEditorKit',
      'HTMLFrameHyperlinkEvent',
      'HTMLWriter',
      'Handler',
      'HandlerBase',
      'HandshakeCompletedEvent',
      'HandshakeCompletedListener',
      'HasControls',
      'HashAttributeSet',
      'HashDocAttributeSet',
      'HashMap',
      'HashPrintJobAttributeSet',
      'HashPrintRequestAttributeSet',
      'HashPrintServiceAttributeSet',
      'HashSet',
      'Hashtable',
      'HeadlessException',
      'HierarchyBoundsAdapter',
      'HierarchyBoundsListener',
      'HierarchyEvent',
      'HierarchyListener',
      'Highlight',
      'HighlightPainter',
      'Highlighter',
      'HostnameVerifier',
      'HttpURLConnection',
      'HttpsURLConnection',
      'HyperlinkEvent',
      'HyperlinkListener',
      'ICC_ColorSpace',
      'ICC_Profile',
      'ICC_ProfileGray',
      'ICC_ProfileRGB',
      'IDLEntity',
      'IDLType',
      'IDLTypeHelper',
      'IDLTypeOperations',
      'ID_ASSIGNMENT_POLICY_ID',
      'ID_UNIQUENESS_POLICY_ID',
      'IIOByteBuffer',
      'IIOException',
      'IIOImage',
      'IIOInvalidTreeException',
      'IIOMetadata',
      'IIOMetadataController',
      'IIOMetadataFormat',
      'IIOMetadataFormatImpl',
      'IIOMetadataNode',
      'IIOParam',
      'IIOParamController',
      'IIOReadProgressListener',
      'IIOReadUpdateListener',
      'IIOReadWarningListener',
      'IIORegistry',
      'IIOServiceProvider',
      'IIOWriteProgressListener',
      'IIOWriteWarningListener',
      'IMPLICIT_ACTIVATION_POLICY_ID',
      'IMP_LIMIT',
      'INITIALIZE',
      'INPUT_STREAM',
      'INTERNAL',
      'INTF_REPOS',
      'INVALID_TRANSACTION',
      'INV_FLAG',
      'INV_IDENT',
      'INV_OBJREF',
      'INV_POLICY',
      'IOException',
      'IOR',
      'IORHelper',
      'IORHolder',
      'IORInfo',
      'IORInfoOperations',
      'IORInterceptor',
      'IORInterceptorOperations',
      'IRObject',
      'IRObjectOperations',
      'ISO',
      'Icon',
      'IconUIResource',
      'IconView',
      'IdAssignmentPolicy',
      'IdAssignmentPolicyOperations',
      'IdAssignmentPolicyValue',
      'IdUniquenessPolicy',
      'IdUniquenessPolicyOperations',
      'IdUniquenessPolicyValue',
      'IdentifierHelper',
      'Identity',
      'IdentityHashMap',
      'IdentityScope',
      'IllegalAccessError',
      'IllegalAccessException',
      'IllegalArgumentException',
      'IllegalBlockSizeException',
      'IllegalBlockingModeException',
      'IllegalCharsetNameException',
      'IllegalComponentStateException',
      'IllegalMonitorStateException',
      'IllegalPathStateException',
      'IllegalSelectorException',
      'IllegalStateException',
      'IllegalThreadStateException',
      'Image',
      'ImageCapabilities',
      'ImageConsumer',
      'ImageFilter',
      'ImageGraphicAttribute',
      'ImageIO',
      'ImageIcon',
      'ImageInputStream',
      'ImageInputStreamImpl',
      'ImageInputStreamSpi',
      'ImageObserver',
      'ImageOutputStream',
      'ImageOutputStreamImpl',
      'ImageOutputStreamSpi',
      'ImageProducer',
      'ImageReadParam',
      'ImageReader',
      'ImageReaderSpi',
      'ImageReaderWriterSpi',
      'ImageTranscoder',
      'ImageTranscoderSpi',
      'ImageTypeSpecifier',
      'ImageView',
      'ImageWriteParam',
      'ImageWriter',
      'ImageWriterSpi',
      'ImagingOpException',
      'ImplicitActivationPolicy',
      'ImplicitActivationPolicyOperations',
      'ImplicitActivationPolicyValue',
      'IncompatibleClassChangeError',
      'InconsistentTypeCode',
      'InconsistentTypeCode',
      'InconsistentTypeCodeHelper',
      'IndexColorModel',
      'IndexOutOfBoundsException',
      'IndexedPropertyDescriptor',
      'IndirectionException',
      'Inet4Address',
      'Inet6Address',
      'InetAddress',
      'InetSocketAddress',
      'Inflater',
      'InflaterInputStream',
      'Info',
      'Info',
      'Info',
      'Info',
      'Info',
      'InheritableThreadLocal',
      'InitialContext',
      'InitialContextFactory',
      'InitialContextFactoryBuilder',
      'InitialDirContext',
      'InitialLdapContext',
      'InlineView',
      'InputContext',
      'InputEvent',
      'InputMap',
      'InputMapUIResource',
      'InputMethod',
      'InputMethodContext',
      'InputMethodDescriptor',
      'InputMethodEvent',
      'InputMethodHighlight',
      'InputMethodListener',
      'InputMethodRequests',
      'InputSource',
      'InputStream',
      'InputStream',
      'InputStream',
      'InputStreamReader',
      'InputSubset',
      'InputVerifier',
      'InsertBreakAction',
      'InsertContentAction',
      'InsertHTMLTextAction',
      'InsertTabAction',
      'Insets',
      'InsetsUIResource',
      'InstantiationError',
      'InstantiationException',
      'Instrument',
      'InsufficientResourcesException',
      'IntBuffer',
      'IntHolder',
      'Integer',
      'IntegerSyntax',
      'Interceptor',
      'InterceptorOperations',
      'InternalError',
      'InternalFrameAdapter',
      'InternalFrameBorder',
      'InternalFrameEvent',
      'InternalFrameFocusTraversalPolicy',
      'InternalFrameListener',
      'InternalFrameUI',
      'InternationalFormatter',
      'InterruptedException',
      'InterruptedIOException',
      'InterruptedNamingException',
      'InterruptibleChannel',
      'IntrospectionException',
      'Introspector',
      'Invalid',
      'InvalidAddress',
      'InvalidAddressHelper',
      'InvalidAddressHolder',
      'InvalidAlgorithmParameterException',
      'InvalidAttributeIdentifierException',
      'InvalidAttributeValueException',
      'InvalidAttributesException',
      'InvalidClassException',
      'InvalidDnDOperationException',
      'InvalidKeyException',
      'InvalidKeySpecException',
      'InvalidMarkException',
      'InvalidMidiDataException',
      'InvalidName',
      'InvalidName',
      'InvalidName',
      'InvalidNameException',
      'InvalidNameHelper',
      'InvalidNameHelper',
      'InvalidNameHolder',
      'InvalidObjectException',
      'InvalidParameterException',
      'InvalidParameterSpecException',
      'InvalidPolicy',
      'InvalidPolicyHelper',
      'InvalidPreferencesFormatException',
      'InvalidSearchControlsException',
      'InvalidSearchFilterException',
      'InvalidSeq',
      'InvalidSlot',
      'InvalidSlotHelper',
      'InvalidTransactionException',
      'InvalidTypeForEncoding',
      'InvalidTypeForEncodingHelper',
      'InvalidValue',
      'InvalidValue',
      'InvalidValueHelper',
      'InvocationEvent',
      'InvocationHandler',
      'InvocationTargetException',
      'InvokeHandler',
      'IstringHelper',
      'ItalicAction',
      'ItemEvent',
      'ItemListener',
      'ItemSelectable',
      'Iterator',
      'Iterator',
      'IvParameterSpec',
      'JApplet',
      'JButton',
      'JCheckBox',
      'JCheckBoxMenuItem',
      'JColorChooser',
      'JComboBox',
      'JComponent',
      'JDesktopIcon',
      'JDesktopPane',
      'JDialog',
      'JEditorPane',
      'JFileChooser',
      'JFormattedTextField',
      'JFrame',
      'JIS',
      'JInternalFrame',
      'JLabel',
      'JLayeredPane',
      'JList',
      'JMenu',
      'JMenuBar',
      'JMenuItem',
      'JOptionPane',
      'JPEGHuffmanTable',
      'JPEGImageReadParam',
      'JPEGImageWriteParam',
      'JPEGQTable',
      'JPanel',
      'JPasswordField',
      'JPopupMenu',
      'JProgressBar',
      'JRadioButton',
      'JRadioButtonMenuItem',
      'JRootPane',
      'JScrollBar',
      'JScrollPane',
      'JSeparator',
      'JSlider',
      'JSpinner',
      'JSplitPane',
      'JTabbedPane',
      'JTable',
      'JTableHeader',
      'JTextArea',
      'JTextComponent',
      'JTextField',
      'JTextPane',
      'JToggleButton',
      'JToolBar',
      'JToolTip',
      'JTree',
      'JViewport',
      'JWindow',
      'JarEntry',
      'JarException',
      'JarFile',
      'JarInputStream',
      'JarOutputStream',
      'JarURLConnection',
      'JobAttributes',
      'JobHoldUntil',
      'JobImpressions',
      'JobImpressionsCompleted',
      'JobImpressionsSupported',
      'JobKOctets',
      'JobKOctetsProcessed',
      'JobKOctetsSupported',
      'JobMediaSheets',
      'JobMediaSheetsCompleted',
      'JobMediaSheetsSupported',
      'JobMessageFromOperator',
      'JobName',
      'JobOriginatingUserName',
      'JobPriority',
      'JobPrioritySupported',
      'JobSheets',
      'JobState',
      'JobStateReason',
      'JobStateReasons',
      'KerberosKey',
      'KerberosPrincipal',
      'KerberosTicket',
      'Kernel',
      'Key',
      'Key',
      'KeyAdapter',
      'KeyAgreement',
      'KeyAgreementSpi',
      'KeyBinding',
      'KeyEvent',
      'KeyEventDispatcher',
      'KeyEventPostProcessor',
      'KeyException',
      'KeyFactory',
      'KeyFactorySpi',
      'KeyGenerator',
      'KeyGeneratorSpi',
      'KeyListener',
      'KeyManagementException',
      'KeyManager',
      'KeyManagerFactory',
      'KeyManagerFactorySpi',
      'KeyPair',
      'KeyPairGenerator',
      'KeyPairGeneratorSpi',
      'KeySelectionManager',
      'KeySpec',
      'KeyStore',
      'KeyStoreException',
      'KeyStoreSpi',
      'KeyStroke',
      'KeyboardFocusManager',
      'Keymap',
      'LDAPCertStoreParameters',
      'LIFESPAN_POLICY_ID',
      'LOCATION_FORWARD',
      'Label',
      'LabelUI',
      'LabelView',
      'LanguageCallback',
      'LastOwnerException',
      'LayerPainter',
      'LayeredHighlighter',
      'LayoutFocusTraversalPolicy',
      'LayoutManager',
      'LayoutManager2',
      'LayoutQueue',
      'LazyInputMap',
      'LazyValue',
      'LdapContext',
      'LdapReferralException',
      'Lease',
      'Level',
      'LexicalHandler',
      'LifespanPolicy',
      'LifespanPolicyOperations',
      'LifespanPolicyValue',
      'LimitExceededException',
      'Line',
      'Line2D',
      'LineBorder',
      'LineBorderUIResource',
      'LineBreakMeasurer',
      'LineEvent',
      'LineListener',
      'LineMetrics',
      'LineNumberInputStream',
      'LineNumberReader',
      'LineUnavailableException',
      'LinkController',
      'LinkException',
      'LinkLoopException',
      'LinkRef',
      'LinkageError',
      'LinkedHashMap',
      'LinkedHashSet',
      'LinkedList',
      'List',
      'List',
      'ListCellRenderer',
      'ListDataEvent',
      'ListDataListener',
      'ListEditor',
      'ListIterator',
      'ListModel',
      'ListPainter',
      'ListResourceBundle',
      'ListSelectionEvent',
      'ListSelectionListener',
      'ListSelectionModel',
      'ListUI',
      'ListView',
      'LoaderHandler',
      'LocalObject',
      'Locale',
      'LocateRegistry',
      'Locator',
      'LocatorImpl',
      'LogManager',
      'LogRecord',
      'LogStream',
      'Logger',
      'LoggingPermission',
      'LoginContext',
      'LoginException',
      'LoginModule',
      'LoginModuleControlFlag',
      'Long',
      'LongBuffer',
      'LongHolder',
      'LongLongSeqHelper',
      'LongLongSeqHolder',
      'LongSeqHelper',
      'LongSeqHolder',
      'LookAndFeel',
      'LookAndFeelInfo',
      'LookupOp',
      'LookupTable',
      'MARSHAL',
      'Mac',
      'MacSpi',
      'MalformedInputException',
      'MalformedLinkException',
      'MalformedURLException',
      'ManagerFactoryParameters',
      'Manifest',
      'Map',
      'MapMode',
      'MappedByteBuffer',
      'MarginBorder',
      'MarshalException',
      'MarshalledObject',
      'MaskFormatter',
      'Matcher',
      'Math',
      'MatteBorder',
      'MatteBorderUIResource',
      'Media',
      'MediaName',
      'MediaPrintableArea',
      'MediaSize',
      'MediaSizeName',
      'MediaTracker',
      'MediaTray',
      'MediaType',
      'Member',
      'MemoryCacheImageInputStream',
      'MemoryCacheImageOutputStream',
      'MemoryHandler',
      'MemoryImageSource',
      'Menu',
      'MenuBar',
      'MenuBarBorder',
      'MenuBarBorder',
      'MenuBarUI',
      'MenuComponent',
      'MenuContainer',
      'MenuDragMouseEvent',
      'MenuDragMouseListener',
      'MenuElement',
      'MenuEvent',
      'MenuItem',
      'MenuItemBorder',
      'MenuItemUI',
      'MenuKeyEvent',
      'MenuKeyListener',
      'MenuListener',
      'MenuSelectionManager',
      'MenuShortcut',
      'MessageDigest',
      'MessageDigestSpi',
      'MessageFormat',
      'MessageProp',
      'MetaEventListener',
      'MetaMessage',
      'MetalBorders',
      'MetalButtonUI',
      'MetalCheckBoxIcon',
      'MetalCheckBoxUI',
      'MetalComboBoxButton',
      'MetalComboBoxEditor',
      'MetalComboBoxIcon',
      'MetalComboBoxUI',
      'MetalDesktopIconUI',
      'MetalFileChooserUI',
      'MetalIconFactory',
      'MetalInternalFrameTitlePane',
      'MetalInternalFrameUI',
      'MetalLabelUI',
      'MetalLookAndFeel',
      'MetalPopupMenuSeparatorUI',
      'MetalProgressBarUI',
      'MetalRadioButtonUI',
      'MetalRootPaneUI',
      'MetalScrollBarUI',
      'MetalScrollButton',
      'MetalScrollPaneUI',
      'MetalSeparatorUI',
      'MetalSliderUI',
      'MetalSplitPaneUI',
      'MetalTabbedPaneUI',
      'MetalTextFieldUI',
      'MetalTheme',
      'MetalToggleButtonUI',
      'MetalToolBarUI',
      'MetalToolTipUI',
      'MetalTreeUI',
      'Method',
      'MethodDescriptor',
      'MidiChannel',
      'MidiDevice',
      'MidiDeviceProvider',
      'MidiEvent',
      'MidiFileFormat',
      'MidiFileReader',
      'MidiFileWriter',
      'MidiMessage',
      'MidiSystem',
      'MidiUnavailableException',
      'MimeTypeParseException',
      'MinimalHTMLWriter',
      'MissingResourceException',
      'Mixer',
      'MixerProvider',
      'ModificationItem',
      'Modifier',
      'MouseAdapter',
      'MouseDragGestureRecognizer',
      'MouseEvent',
      'MouseInputAdapter',
      'MouseInputListener',
      'MouseListener',
      'MouseMotionAdapter',
      'MouseMotionListener',
      'MouseWheelEvent',
      'MouseWheelListener',
      'MultiButtonUI',
      'MultiColorChooserUI',
      'MultiComboBoxUI',
      'MultiDesktopIconUI',
      'MultiDesktopPaneUI',
      'MultiDoc',
      'MultiDocPrintJob',
      'MultiDocPrintService',
      'MultiFileChooserUI',
      'MultiInternalFrameUI',
      'MultiLabelUI',
      'MultiListUI',
      'MultiLookAndFeel',
      'MultiMenuBarUI',
      'MultiMenuItemUI',
      'MultiOptionPaneUI',
      'MultiPanelUI',
      'MultiPixelPackedSampleModel',
      'MultiPopupMenuUI',
      'MultiProgressBarUI',
      'MultiRootPaneUI',
      'MultiScrollBarUI',
      'MultiScrollPaneUI',
      'MultiSeparatorUI',
      'MultiSliderUI',
      'MultiSpinnerUI',
      'MultiSplitPaneUI',
      'MultiTabbedPaneUI',
      'MultiTableHeaderUI',
      'MultiTableUI',
      'MultiTextUI',
      'MultiToolBarUI',
      'MultiToolTipUI',
      'MultiTreeUI',
      'MultiViewportUI',
      'MulticastSocket',
      'MultipleComponentProfileHelper',
      'MultipleComponentProfileHolder',
      'MultipleDocumentHandling',
      'MultipleDocumentHandlingType',
      'MultipleMaster',
      'MutableAttributeSet',
      'MutableComboBoxModel',
      'MutableTreeNode',
      'NA',
      'NO_IMPLEMENT',
      'NO_MEMORY',
      'NO_PERMISSION',
      'NO_RESOURCES',
      'NO_RESPONSE',
      'NVList',
      'Name',
      'Name',
      'NameAlreadyBoundException',
      'NameCallback',
      'NameClassPair',
      'NameComponent',
      'NameComponentHelper',
      'NameComponentHolder',
      'NameDynAnyPair',
      'NameDynAnyPairHelper',
      'NameDynAnyPairSeqHelper',
      'NameHelper',
      'NameHolder',
      'NameNotFoundException',
      'NameParser',
      'NameValuePair',
      'NameValuePair',
      'NameValuePairHelper',
      'NameValuePairHelper',
      'NameValuePairSeqHelper',
      'NamedNodeMap',
      'NamedValue',
      'NamespaceChangeListener',
      'NamespaceSupport',
      'Naming',
      'NamingContext',
      'NamingContextExt',
      'NamingContextExtHelper',
      'NamingContextExtHolder',
      'NamingContextExtOperations',
      'NamingContextExtPOA',
      'NamingContextHelper',
      'NamingContextHolder',
      'NamingContextOperations',
      'NamingContextPOA',
      'NamingEnumeration',
      'NamingEvent',
      'NamingException',
      'NamingExceptionEvent',
      'NamingListener',
      'NamingManager',
      'NamingSecurityException',
      'NavigationFilter',
      'NegativeArraySizeException',
      'NetPermission',
      'NetworkInterface',
      'NoClassDefFoundError',
      'NoConnectionPendingException',
      'NoContext',
      'NoContextHelper',
      'NoInitialContextException',
      'NoPermissionException',
      'NoRouteToHostException',
      'NoServant',
      'NoServantHelper',
      'NoSuchAlgorithmException',
      'NoSuchAttributeException',
      'NoSuchElementException',
      'NoSuchFieldError',
      'NoSuchFieldException',
      'NoSuchMethodError',
      'NoSuchMethodException',
      'NoSuchObjectException',
      'NoSuchPaddingException',
      'NoSuchProviderException',
      'Node',
      'NodeChangeEvent',
      'NodeChangeListener',
      'NodeDimensions',
      'NodeList',
      'NonReadableChannelException',
      'NonWritableChannelException',
      'NoninvertibleTransformException',
      'NotActiveException',
      'NotBoundException',
      'NotContextException',
      'NotEmpty',
      'NotEmptyHelper',
      'NotEmptyHolder',
      'NotFound',
      'NotFoundHelper',
      'NotFoundHolder',
      'NotFoundReason',
      'NotFoundReasonHelper',
      'NotFoundReasonHolder',
      'NotOwnerException',
      'NotSerializableException',
      'NotYetBoundException',
      'NotYetConnectedException',
      'Notation',
      'NullCipher',
      'NullPointerException',
      'Number',
      'NumberEditor',
      'NumberFormat',
      'NumberFormatException',
      'NumberFormatter',
      'NumberOfDocuments',
      'NumberOfInterveningJobs',
      'NumberUp',
      'NumberUpSupported',
      'NumericShaper',
      'OBJECT_NOT_EXIST',
      'OBJ_ADAPTER',
      'OMGVMCID',
      'ORB',
      'ORB',
      'ORBInitInfo',
      'ORBInitInfoOperations',
      'ORBInitializer',
      'ORBInitializerOperations',
      'ObjID',
      'Object',
      'Object',
      'ObjectAlreadyActive',
      'ObjectAlreadyActiveHelper',
      'ObjectChangeListener',
      'ObjectFactory',
      'ObjectFactoryBuilder',
      'ObjectHelper',
      'ObjectHolder',
      'ObjectIdHelper',
      'ObjectImpl',
      'ObjectImpl',
      'ObjectInput',
      'ObjectInputStream',
      'ObjectInputValidation',
      'ObjectNotActive',
      'ObjectNotActiveHelper',
      'ObjectOutput',
      'ObjectOutputStream',
      'ObjectStreamClass',
      'ObjectStreamConstants',
      'ObjectStreamException',
      'ObjectStreamField',
      'ObjectView',
      'Observable',
      'Observer',
      'OctetSeqHelper',
      'OctetSeqHolder',
      'Oid',
      'OpenType',
      'Operation',
      'OperationNotSupportedException',
      'Option',
      'OptionDialogBorder',
      'OptionPaneUI',
      'OptionalDataException',
      'OrientationRequested',
      'OrientationRequestedType',
      'OriginType',
      'Other',
      'OutOfMemoryError',
      'OutputDeviceAssigned',
      'OutputKeys',
      'OutputStream',
      'OutputStream',
      'OutputStream',
      'OutputStreamWriter',
      'OverlappingFileLockException',
      'OverlayLayout',
      'Owner',
      'PBEKey',
      'PBEKeySpec',
      'PBEParameterSpec',
      'PDLOverrideSupported',
      'PERSIST_STORE',
      'PKCS8EncodedKeySpec',
      'PKIXBuilderParameters',
      'PKIXCertPathBuilderResult',
      'PKIXCertPathChecker',
      'PKIXCertPathValidatorResult',
      'PKIXParameters',
      'POA',
      'POAHelper',
      'POAManager',
      'POAManagerOperations',
      'POAOperations',
      'PRIVATE_MEMBER',
      'PSSParameterSpec',
      'PUBLIC_MEMBER',
      'Package',
      'PackedColorModel',
      'PageAttributes',
      'PageFormat',
      'PageRanges',
      'Pageable',
      'PagesPerMinute',
      'PagesPerMinuteColor',
      'Paint',
      'PaintContext',
      'PaintEvent',
      'PaletteBorder',
      'PaletteCloseIcon',
      'Panel',
      'PanelUI',
      'Paper',
      'ParagraphAttribute',
      'ParagraphConstants',
      'ParagraphView',
      'ParagraphView',
      'Parameter',
      'ParameterBlock',
      'ParameterDescriptor',
      'ParameterMetaData',
      'ParameterMode',
      'ParameterModeHelper',
      'ParameterModeHolder',
      'ParseException',
      'ParsePosition',
      'Parser',
      'Parser',
      'Parser',
      'ParserAdapter',
      'ParserCallback',
      'ParserConfigurationException',
      'ParserDelegator',
      'ParserFactory',
      'PartialResultException',
      'PasswordAuthentication',
      'PasswordCallback',
      'PasswordView',
      'PasteAction',
      'Patch',
      'PathIterator',
      'Pattern',
      'PatternSyntaxException',
      'Permission',
      'Permission',
      'PermissionCollection',
      'Permissions',
      'PersistenceDelegate',
      'PhantomReference',
      'Pipe',
      'PipedInputStream',
      'PipedOutputStream',
      'PipedReader',
      'PipedWriter',
      'PixelGrabber',
      'PixelInterleavedSampleModel',
      'PlainDocument',
      'PlainView',
      'Point',
      'Point2D',
      'Policy',
      'Policy',
      'Policy',
      'PolicyError',
      'PolicyErrorCodeHelper',
      'PolicyErrorHelper',
      'PolicyErrorHolder',
      'PolicyFactory',
      'PolicyFactoryOperations',
      'PolicyHelper',
      'PolicyHolder',
      'PolicyListHelper',
      'PolicyListHolder',
      'PolicyNode',
      'PolicyOperations',
      'PolicyQualifierInfo',
      'PolicyTypeHelper',
      'Polygon',
      'PooledConnection',
      'Popup',
      'PopupFactory',
      'PopupMenu',
      'PopupMenuBorder',
      'PopupMenuEvent',
      'PopupMenuListener',
      'PopupMenuUI',
      'Port',
      'PortUnreachableException',
      'PortableRemoteObject',
      'PortableRemoteObjectDelegate',
      'Position',
      'PreferenceChangeEvent',
      'PreferenceChangeListener',
      'Preferences',
      'PreferencesFactory',
      'PreparedStatement',
      'PresentationDirection',
      'Principal',
      'Principal',
      'PrincipalHolder',
      'PrintEvent',
      'PrintException',
      'PrintGraphics',
      'PrintJob',
      'PrintJobAdapter',
      'PrintJobAttribute',
      'PrintJobAttributeEvent',
      'PrintJobAttributeListener',
      'PrintJobAttributeSet',
      'PrintJobEvent',
      'PrintJobListener',
      'PrintQuality',
      'PrintQualityType',
      'PrintRequestAttribute',
      'PrintRequestAttributeSet',
      'PrintService',
      'PrintServiceAttribute',
      'PrintServiceAttributeEvent',
      'PrintServiceAttributeListener',
      'PrintServiceAttributeSet',
      'PrintServiceLookup',
      'PrintStream',
      'PrintWriter',
      'Printable',
      'PrinterAbortException',
      'PrinterException',
      'PrinterGraphics',
      'PrinterIOException',
      'PrinterInfo',
      'PrinterIsAcceptingJobs',
      'PrinterJob',
      'PrinterLocation',
      'PrinterMakeAndModel',
      'PrinterMessageFromOperator',
      'PrinterMoreInfo',
      'PrinterMoreInfoManufacturer',
      'PrinterName',
      'PrinterResolution',
      'PrinterState',
      'PrinterStateReason',
      'PrinterStateReasons',
      'PrinterURI',
      'PrivateCredentialPermission',
      'PrivateKey',
      'PrivilegedAction',
      'PrivilegedActionException',
      'PrivilegedExceptionAction',
      'Process',
      'ProcessingInstruction',
      'ProfileDataException',
      'ProfileIdHelper',
      'ProgressBarUI',
      'ProgressMonitor',
      'ProgressMonitorInputStream',
      'Properties',
      'PropertyChangeEvent',
      'PropertyChangeListener',
      'PropertyChangeListenerProxy',
      'PropertyChangeSupport',
      'PropertyDescriptor',
      'PropertyEditor',
      'PropertyEditorManager',
      'PropertyEditorSupport',
      'PropertyPermission',
      'PropertyResourceBundle',
      'PropertyVetoException',
      'ProtectionDomain',
      'ProtocolException',
      'Provider',
      'ProviderException',
      'Proxy',
      'ProxyLazyValue',
      'PublicKey',
      'PushbackInputStream',
      'PushbackReader',
      'PutField',
      'QuadCurve2D',
      'QueuedJobCount',
      'RC2ParameterSpec',
      'RC5ParameterSpec',
      'READER',
      'REQUEST_PROCESSING_POLICY_ID',
      'RGBImageFilter',
      'RMIClassLoader',
      'RMIClassLoaderSpi',
      'RMIClientSocketFactory',
      'RMIFailureHandler',
      'RMISecurityException',
      'RMISecurityManager',
      'RMIServerSocketFactory',
      'RMISocketFactory',
      'RSAKey',
      'RSAKeyGenParameterSpec',
      'RSAMultiPrimePrivateCrtKey',
      'RSAMultiPrimePrivateCrtKeySpec',
      'RSAOtherPrimeInfo',
      'RSAPrivateCrtKey',
      'RSAPrivateCrtKeySpec',
      'RSAPrivateKey',
      'RSAPrivateKeySpec',
      'RSAPublicKey',
      'RSAPublicKeySpec',
      'RTFEditorKit',
      'RadioButtonBorder',
      'Random',
      'RandomAccess',
      'RandomAccessFile',
      'Raster',
      'RasterFormatException',
      'RasterOp',
      'ReadOnlyBufferException',
      'ReadableByteChannel',
      'Reader',
      'Receiver',
      'Rectangle',
      'Rectangle2D',
      'RectangularShape',
      'Ref',
      'RefAddr',
      'Reference',
      'Reference',
      'ReferenceQueue',
      'ReferenceUriSchemesSupported',
      'Referenceable',
      'ReferralException',
      'ReflectPermission',
      'RefreshFailedException',
      'Refreshable',
      'RegisterableService',
      'Registry',
      'RegistryHandler',
      'RemarshalException',
      'Remote',
      'RemoteCall',
      'RemoteException',
      'RemoteObject',
      'RemoteRef',
      'RemoteServer',
      'RemoteStub',
      'RenderContext',
      'RenderableImage',
      'RenderableImageOp',
      'RenderableImageProducer',
      'RenderedImage',
      'RenderedImageFactory',
      'Renderer',
      'RenderingHints',
      'RepaintManager',
      'ReplicateScaleFilter',
      'RepositoryIdHelper',
      'Request',
      'RequestInfo',
      'RequestInfoOperations',
      'RequestProcessingPolicy',
      'RequestProcessingPolicyOperations',
      'RequestProcessingPolicyValue',
      'RequestingUserName',
      'RescaleOp',
      'ResolutionSyntax',
      'ResolveResult',
      'Resolver',
      'ResourceBundle',
      'ResponseHandler',
      'Result',
      'Result',
      'ResultSet',
      'ResultSetMetaData',
      'ReverbType',
      'Robot',
      'RolloverButtonBorder',
      'RolloverButtonBorder',
      'RootPaneContainer',
      'RootPaneUI',
      'RoundRectangle2D',
      'RowMapper',
      'RowSet',
      'RowSetEvent',
      'RowSetInternal',
      'RowSetListener',
      'RowSetMetaData',
      'RowSetReader',
      'RowSetWriter',
      'RuleBasedCollator',
      'RunTime',
      'RunTimeOperations',
      'Runnable',
      'Runtime',
      'RuntimeException',
      'RuntimePermission',
      'SAXException',
      'SAXNotRecognizedException',
      'SAXNotSupportedException',
      'SAXParseException',
      'SAXParser',
      'SAXParserFactory',
      'SAXResult',
      'SAXSource',
      'SAXTransformerFactory',
      'SERVANT_RETENTION_POLICY_ID',
      'SERVICE_FORMATTED',
      'SQLData',
      'SQLException',
      'SQLInput',
      'SQLOutput',
      'SQLPermission',
      'SQLWarning',
      'SSLContext',
      'SSLContextSpi',
      'SSLException',
      'SSLHandshakeException',
      'SSLKeyException',
      'SSLPeerUnverifiedException',
      'SSLPermission',
      'SSLProtocolException',
      'SSLServerSocket',
      'SSLServerSocketFactory',
      'SSLSession',
      'SSLSessionBindingEvent',
      'SSLSessionBindingListener',
      'SSLSessionContext',
      'SSLSocket',
      'SSLSocketFactory',
      'STRING',
      'SUCCESSFUL',
      'SYNC_WITH_TRANSPORT',
      'SYSTEM_EXCEPTION',
      'SampleModel',
      'Savepoint',
      'ScatteringByteChannel',
      'SchemaViolationException',
      'ScrollBarUI',
      'ScrollPane',
      'ScrollPaneAdjustable',
      'ScrollPaneBorder',
      'ScrollPaneConstants',
      'ScrollPaneLayout',
      'ScrollPaneUI',
      'Scrollable',
      'Scrollbar',
      'SealedObject',
      'SearchControls',
      'SearchResult',
      'SecretKey',
      'SecretKeyFactory',
      'SecretKeyFactorySpi',
      'SecretKeySpec',
      'SecureClassLoader',
      'SecureRandom',
      'SecureRandomSpi',
      'Security',
      'SecurityException',
      'SecurityManager',
      'SecurityPermission',
      'Segment',
      'SelectableChannel',
      'SelectionKey',
      'Selector',
      'SelectorProvider',
      'Separator',
      'Separator',
      'SeparatorUI',
      'Sequence',
      'SequenceInputStream',
      'Sequencer',
      'Serializable',
      'SerializablePermission',
      'Servant',
      'ServantActivator',
      'ServantActivatorHelper',
      'ServantActivatorOperations',
      'ServantActivatorPOA',
      'ServantAlreadyActive',
      'ServantAlreadyActiveHelper',
      'ServantLocator',
      'ServantLocatorHelper',
      'ServantLocatorOperations',
      'ServantLocatorPOA',
      'ServantManager',
      'ServantManagerOperations',
      'ServantNotActive',
      'ServantNotActiveHelper',
      'ServantObject',
      'ServantRetentionPolicy',
      'ServantRetentionPolicyOperations',
      'ServantRetentionPolicyValue',
      'ServerCloneException',
      'ServerError',
      'ServerException',
      'ServerNotActiveException',
      'ServerRef',
      'ServerRequest',
      'ServerRequestInfo',
      'ServerRequestInfoOperations',
      'ServerRequestInterceptor',
      'ServerRequestInterceptorOperations',
      'ServerRuntimeException',
      'ServerSocket',
      'ServerSocketChannel',
      'ServerSocketFactory',
      'ServiceContext',
      'ServiceContextHelper',
      'ServiceContextHolder',
      'ServiceContextListHelper',
      'ServiceContextListHolder',
      'ServiceDetail',
      'ServiceDetailHelper',
      'ServiceIdHelper',
      'ServiceInformation',
      'ServiceInformationHelper',
      'ServiceInformationHolder',
      'ServicePermission',
      'ServiceRegistry',
      'ServiceUI',
      'ServiceUIFactory',
      'ServiceUnavailableException',
      'Set',
      'SetOfIntegerSyntax',
      'SetOverrideType',
      'SetOverrideTypeHelper',
      'Severity',
      'Shape',
      'ShapeGraphicAttribute',
      'SheetCollate',
      'Short',
      'ShortBuffer',
      'ShortBufferException',
      'ShortHolder',
      'ShortLookupTable',
      'ShortMessage',
      'ShortSeqHelper',
      'ShortSeqHolder',
      'Sides',
      'SidesType',
      'Signature',
      'SignatureException',
      'SignatureSpi',
      'SignedObject',
      'Signer',
      'SimpleAttributeSet',
      'SimpleBeanInfo',
      'SimpleDateFormat',
      'SimpleDoc',
      'SimpleFormatter',
      'SimpleTimeZone',
      'SinglePixelPackedSampleModel',
      'SingleSelectionModel',
      'SinkChannel',
      'Size2DSyntax',
      'SizeLimitExceededException',
      'SizeRequirements',
      'SizeSequence',
      'Skeleton',
      'SkeletonMismatchException',
      'SkeletonNotFoundException',
      'SliderUI',
      'Socket',
      'SocketAddress',
      'SocketChannel',
      'SocketException',
      'SocketFactory',
      'SocketHandler',
      'SocketImpl',
      'SocketImplFactory',
      'SocketOptions',
      'SocketPermission',
      'SocketSecurityException',
      'SocketTimeoutException',
      'SoftBevelBorder',
      'SoftReference',
      'SortedMap',
      'SortedSet',
      'SortingFocusTraversalPolicy',
      'Soundbank',
      'SoundbankReader',
      'SoundbankResource',
      'Source',
      'SourceChannel',
      'SourceDataLine',
      'SourceLocator',
      'SpinnerDateModel',
      'SpinnerListModel',
      'SpinnerModel',
      'SpinnerNumberModel',
      'SpinnerUI',
      'SplitPaneBorder',
      'SplitPaneUI',
      'Spring',
      'SpringLayout',
      'Stack',
      'StackOverflowError',
      'StackTraceElement',
      'StartTlsRequest',
      'StartTlsResponse',
      'State',
      'StateEdit',
      'StateEditable',
      'StateFactory',
      'Statement',
      'Statement',
      'StreamCorruptedException',
      'StreamHandler',
      'StreamPrintService',
      'StreamPrintServiceFactory',
      'StreamResult',
      'StreamSource',
      'StreamTokenizer',
      'Streamable',
      'StreamableValue',
      'StrictMath',
      'String',
      'StringBuffer',
      'StringBufferInputStream',
      'StringCharacterIterator',
      'StringContent',
      'StringHolder',
      'StringIndexOutOfBoundsException',
      'StringNameHelper',
      'StringReader',
      'StringRefAddr',
      'StringSelection',
      'StringSeqHelper',
      'StringSeqHolder',
      'StringTokenizer',
      'StringValueHelper',
      'StringWriter',
      'Stroke',
      'Struct',
      'StructMember',
      'StructMemberHelper',
      'Stub',
      'StubDelegate',
      'StubNotFoundException',
      'Style',
      'StyleConstants',
      'StyleContext',
      'StyleSheet',
      'StyledDocument',
      'StyledEditorKit',
      'StyledTextAction',
      'Subject',
      'SubjectDomainCombiner',
      'Subset',
      'SupportedValuesAttribute',
      'SwingConstants',
      'SwingPropertyChangeSupport',
      'SwingUtilities',
      'SyncFailedException',
      'SyncMode',
      'SyncScopeHelper',
      'Synthesizer',
      'SysexMessage',
      'System',
      'SystemColor',
      'SystemException',
      'SystemFlavorMap',
      'TAG_ALTERNATE_IIOP_ADDRESS',
      'TAG_CODE_SETS',
      'TAG_INTERNET_IOP',
      'TAG_JAVA_CODEBASE',
      'TAG_MULTIPLE_COMPONENTS',
      'TAG_ORB_TYPE',
      'TAG_POLICIES',
      'TCKind',
      'THREAD_POLICY_ID',
      'TRANSACTION_REQUIRED',
      'TRANSACTION_ROLLEDBACK',
      'TRANSIENT',
      'TRANSPORT_RETRY',
      'TabExpander',
      'TabSet',
      'TabStop',
      'TabableView',
      'TabbedPaneUI',
      'TableCellEditor',
      'TableCellRenderer',
      'TableColumn',
      'TableColumnModel',
      'TableColumnModelEvent',
      'TableColumnModelListener',
      'TableHeaderBorder',
      'TableHeaderUI',
      'TableModel',
      'TableModelEvent',
      'TableModelListener',
      'TableUI',
      'TableView',
      'Tag',
      'TagElement',
      'TaggedComponent',
      'TaggedComponentHelper',
      'TaggedComponentHolder',
      'TaggedProfile',
      'TaggedProfileHelper',
      'TaggedProfileHolder',
      'TargetDataLine',
      'Templates',
      'TemplatesHandler',
      'Text',
      'TextAction',
      'TextArea',
      'TextAttribute',
      'TextComponent',
      'TextEvent',
      'TextField',
      'TextFieldBorder',
      'TextHitInfo',
      'TextInputCallback',
      'TextLayout',
      'TextListener',
      'TextMeasurer',
      'TextOutputCallback',
      'TextSyntax',
      'TextUI',
      'TexturePaint',
      'Thread',
      'ThreadDeath',
      'ThreadGroup',
      'ThreadLocal',
      'ThreadPolicy',
      'ThreadPolicyOperations',
      'ThreadPolicyValue',
      'Throwable',
      'Tie',
      'TileObserver',
      'Time',
      'TimeLimitExceededException',
      'TimeZone',
      'Timer',
      'Timer',
      'TimerTask',
      'Timestamp',
      'TitledBorder',
      'TitledBorderUIResource',
      'ToggleButtonBorder',
      'ToggleButtonBorder',
      'ToggleButtonModel',
      'TooManyListenersException',
      'ToolBarBorder',
      'ToolBarUI',
      'ToolTipManager',
      'ToolTipUI',
      'Toolkit',
      'Track',
      'TransactionRequiredException',
      'TransactionRolledbackException',
      'TransactionService',
      'TransferHandler',
      'Transferable',
      'TransformAttribute',
      'Transformer',
      'TransformerConfigurationException',
      'TransformerException',
      'TransformerFactory',
      'TransformerFactoryConfigurationError',
      'TransformerHandler',
      'Transmitter',
      'Transparency',
      'TreeCellEditor',
      'TreeCellRenderer',
      'TreeControlIcon',
      'TreeExpansionEvent',
      'TreeExpansionListener',
      'TreeFolderIcon',
      'TreeLeafIcon',
      'TreeMap',
      'TreeModel',
      'TreeModelEvent',
      'TreeModelListener',
      'TreeNode',
      'TreePath',
      'TreeSelectionEvent',
      'TreeSelectionListener',
      'TreeSelectionModel',
      'TreeSet',
      'TreeUI',
      'TreeWillExpandListener',
      'TrustAnchor',
      'TrustManager',
      'TrustManagerFactory',
      'TrustManagerFactorySpi',
      'Type',
      'Type',
      'Type',
      'Type',
      'Type',
      'Type',
      'Type',
      'TypeCode',
      'TypeCodeHolder',
      'TypeMismatch',
      'TypeMismatch',
      'TypeMismatch',
      'TypeMismatchHelper',
      'TypeMismatchHelper',
      'Types',
      'UID',
      'UIDefaults',
      'UIManager',
      'UIResource',
      'UIResource',
      'UIResource',
      'UIResource',
      'UIResource',
      'UIResource',
      'UIResource',
      'ULongLongSeqHelper',
      'ULongLongSeqHolder',
      'ULongSeqHelper',
      'ULongSeqHolder',
      'UNKNOWN',
      'UNSUPPORTED_POLICY',
      'UNSUPPORTED_POLICY_VALUE',
      'URI',
      'URIException',
      'URIResolver',
      'URISyntax',
      'URISyntaxException',
      'URL',
      'URL',
      'URLClassLoader',
      'URLConnection',
      'URLDecoder',
      'URLEncoder',
      'URLStreamHandler',
      'URLStreamHandlerFactory',
      'URLStringHelper',
      'USER_EXCEPTION',
      'UShortSeqHelper',
      'UShortSeqHolder',
      'UTFDataFormatException',
      'UndeclaredThrowableException',
      'UnderlineAction',
      'UndoManager',
      'UndoableEdit',
      'UndoableEditEvent',
      'UndoableEditListener',
      'UndoableEditSupport',
      'UnexpectedException',
      'UnicastRemoteObject',
      'UnicodeBlock',
      'UnionMember',
      'UnionMemberHelper',
      'UnknownEncoding',
      'UnknownEncodingHelper',
      'UnknownError',
      'UnknownException',
      'UnknownGroupException',
      'UnknownHostException',
      'UnknownHostException',
      'UnknownObjectException',
      'UnknownServiceException',
      'UnknownTag',
      'UnknownUserException',
      'UnknownUserExceptionHelper',
      'UnknownUserExceptionHolder',
      'UnmappableCharacterException',
      'UnmarshalException',
      'UnmodifiableSetException',
      'UnrecoverableKeyException',
      'Unreferenced',
      'UnresolvedAddressException',
      'UnresolvedPermission',
      'UnsatisfiedLinkError',
      'UnsolicitedNotification',
      'UnsolicitedNotificationEvent',
      'UnsolicitedNotificationListener',
      'UnsupportedAddressTypeException',
      'UnsupportedAudioFileException',
      'UnsupportedCallbackException',
      'UnsupportedCharsetException',
      'UnsupportedClassVersionError',
      'UnsupportedEncodingException',
      'UnsupportedFlavorException',
      'UnsupportedLookAndFeelException',
      'UnsupportedOperationException',
      'UserException',
      'Util',
      'UtilDelegate',
      'Utilities',
      'VMID',
      'VM_ABSTRACT',
      'VM_CUSTOM',
      'VM_NONE',
      'VM_TRUNCATABLE',
      'ValueBase',
      'ValueBaseHelper',
      'ValueBaseHolder',
      'ValueFactory',
      'ValueHandler',
      'ValueMember',
      'ValueMemberHelper',
      'VariableHeightLayoutCache',
      'Vector',
      'VerifyError',
      'VersionSpecHelper',
      'VetoableChangeListener',
      'VetoableChangeListenerProxy',
      'VetoableChangeSupport',
      'View',
      'ViewFactory',
      'ViewportLayout',
      'ViewportUI',
      'VirtualMachineError',
      'Visibility',
      'VisibilityHelper',
      'VoiceStatus',
      'Void',
      'VolatileImage',
      'WCharSeqHelper',
      'WCharSeqHolder',
      'WStringSeqHelper',
      'WStringSeqHolder',
      'WStringValueHelper',
      'WeakHashMap',
      'WeakReference',
      'Window',
      'WindowAdapter',
      'WindowConstants',
      'WindowEvent',
      'WindowFocusListener',
      'WindowListener',
      'WindowStateListener',
      'WrappedPlainView',
      'WritableByteChannel',
      'WritableRaster',
      'WritableRenderedImage',
      'WriteAbortedException',
      'Writer',
      'WrongAdapter',
      'WrongAdapterHelper',
      'WrongPolicy',
      'WrongPolicyHelper',
      'WrongTransaction',
      'WrongTransactionHelper',
      'WrongTransactionHolder',
      'X500Principal',
      'X500PrivateCredential',
      'X509CRL',
      'X509CRLEntry',
      'X509CRLSelector',
      'X509CertSelector',
      'X509Certificate',
      'X509Certificate',
      'X509EncodedKeySpec',
      'X509Extension',
      'X509KeyManager',
      'X509TrustManager',
      'XAConnection',
      'XADataSource',
      'XAException',
      'XAResource',
      'XMLDecoder',
      'XMLEncoder',
      'XMLFilter',
      'XMLFilterImpl',
      'XMLFormatter',
      'XMLReader',
      'XMLReaderAdapter',
      'XMLReaderFactory',
      'Xid',
      'ZipEntry',
      'ZipException',
      'ZipFile',
      'ZipInputStream',
      'ZipOutputStream',
      'ZoneView',
      '_BindingIteratorImplBase',
      '_BindingIteratorStub',
      '_DynAnyFactoryStub',
      '_DynAnyStub',
      '_DynArrayStub',
      '_DynEnumStub',
      '_DynFixedStub',
      '_DynSequenceStub',
      '_DynStructStub',
      '_DynUnionStub',
      '_DynValueStub',
      '_IDLTypeStub',
      '_NamingContextExtStub',
      '_NamingContextImplBase',
      '_NamingContextStub',
      '_PolicyStub',
      '_Remote_Stub',
      '_ServantActivatorStub',
      '_ServantLocatorStub',
   );
   $self->listAdd('java-1.4.2-keywords',
      'abstract',
      'assert',
      'break',
      'case',
      'catch',
      'class',
      'continue',
      'default',
      'do',
      'else',
      'extends',
      'false',
      'finally',
      'for',
      'goto',
      'if',
      'implements',
      'import',
      'instanceof',
      'interface',
      'native',
      'new',
      'null',
      'package',
      'private',
      'protected',
      'public',
      'return',
      'strictfp',
      'super',
      'switch',
      'synchronized',
      'this',
      'throw',
      'throws',
      'transient',
      'true',
      'try',
      'volatile',
      'while',
   );
   $self->listAdd('java-1.4.2-types',
      'boolean',
      'byte',
      'char',
      'const',
      'double',
      'final',
      'float',
      'int',
      'long',
      'short',
      'static',
      'void',
   );
   $self->listAdd('jsp-reserved-words',
      'and',
      'div',
      'empty',
      'eq',
      'false',
      'ge',
      'gt',
      'instanceof',
      'le',
      'lt',
      'mod',
      'ne',
      'not',
      'null',
      'or',
      'true',
   );
   $self->contextdata({
      'Html Attribute' => {
         callback => \&parseHtmlAttribute,
         attribute => 'Identifier',
      },
      'Html Comment' => {
         callback => \&parseHtmlComment,
         attribute => 'Html Comment',
      },
      'Html Double Quoted Value' => {
         callback => \&parseHtmlDoubleQuotedValue,
         attribute => 'Types',
      },
      'Html Single Quoted Value' => {
         callback => \&parseHtmlSingleQuotedValue,
         attribute => 'Types',
      },
      'Html Unquoted Value' => {
         callback => \&parseHtmlUnquotedValue,
         attribute => 'Types',
      },
      'Html Value' => {
         callback => \&parseHtmlValue,
         attribute => 'Types',
      },
      'Java Multi-Line Comment' => {
         callback => \&parseJavaMultiLineComment,
         attribute => 'Java Comment',
      },
      'Java Single-Line Comment' => {
         callback => \&parseJavaSingleLineComment,
         attribute => 'Java Comment',
         lineending => '#pop',
      },
      'Java String' => {
         callback => \&parseJavaString,
         attribute => 'String',
      },
      'Jsp Comment' => {
         callback => \&parseJspComment,
         attribute => 'Jsp Comment',
      },
      'Jsp Custom Tag' => {
         callback => \&parseJspCustomTag,
         attribute => 'Identifier',
      },
      'Jsp Custom Tag Value' => {
         callback => \&parseJspCustomTagValue,
         attribute => 'Normal Text',
      },
      'Jsp Double Quoted Custom Tag Value' => {
         callback => \&parseJspDoubleQuotedCustomTagValue,
         attribute => 'Types',
      },
      'Jsp Double Quoted Param Value' => {
         callback => \&parseJspDoubleQuotedParamValue,
         attribute => 'Jsp Param Value',
      },
      'Jsp Expression' => {
         callback => \&parseJspExpression,
         attribute => 'Normal Text',
      },
      'Jsp Scriptlet' => {
         callback => \&parseJspScriptlet,
         attribute => 'Normal Text',
      },
      'Jsp Single Quoted Custom Tag Value' => {
         callback => \&parseJspSingleQuotedCustomTagValue,
         attribute => 'Types',
      },
      'Jsp Single Quoted Param Value' => {
         callback => \&parseJspSingleQuotedParamValue,
         attribute => 'Jsp Param Value',
      },
      'Jsp Standard Directive' => {
         callback => \&parseJspStandardDirective,
         attribute => 'Jsp Param Name',
      },
      'Jsp Standard Directive Value' => {
         callback => \&parseJspStandardDirectiveValue,
         attribute => 'Jsp Param Value',
      },
      'Jsp Xml Directive' => {
         callback => \&parseJspXmlDirective,
         attribute => 'Jsp Param Name',
      },
      'Jsp Xml Directive Value' => {
         callback => \&parseJspXmlDirectiveValue,
         attribute => 'Jsp Param Value',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|-|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'JSP';
}

sub parseHtmlAttribute {
   my ($self, $text) = @_;
   # String => '\/?>'
   # attribute => 'Normal Text'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/?>', 0, 0, 0, undef, 0, '#pop', 'Normal Text')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'Html Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'Html Value', 'Normal Text')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseHtmlComment {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '\/*-->'
   # attribute => 'Html Comment'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/*-->', 0, 0, 0, undef, 0, '#pop', 'Html Comment')) {
      return 1
   }
   return 0;
};

sub parseHtmlDoubleQuotedValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?\w*:\$?\w*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?\\w*:\\$?\\w*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   # String => '("|&quot;|&#34;)'
   # attribute => 'Types'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '("|&quot;|&#34;)', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};

sub parseHtmlSingleQuotedValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?\w*:\$?\w*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?\\w*:\\$?\\w*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   # String => '('|&#39;)'
   # attribute => 'Types'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\'|&#39;)', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};

sub parseHtmlUnquotedValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?\w*:\$?\w*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?\\w*:\\$?\\w*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   # String => '\/?>'
   # attribute => 'Normal Text'
   # context => '#pop#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/?>', 0, 0, 0, undef, 0, '#pop#pop#pop', 'Normal Text')) {
      return 1
   }
   # String => '\s+'
   # attribute => 'Types'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s+', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   return 0;
};

sub parseHtmlValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?\w*:\$?\w*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?\\w*:\\$?\\w*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   # String => '("|&quot;|&#34;)'
   # attribute => 'Types'
   # context => 'Html Double Quoted Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '("|&quot;|&#34;)', 0, 0, 0, undef, 0, 'Html Double Quoted Value', 'Types')) {
      return 1
   }
   # String => '('|&#39;)'
   # attribute => 'Types'
   # context => 'Html Single Quoted Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(\'|&#39;)', 0, 0, 0, undef, 0, 'Html Single Quoted Value', 'Types')) {
      return 1
   }
   # String => '\s*#?-?_?\.?[a-zA-Z0-9]*'
   # attribute => 'Types'
   # context => 'Html Unquoted Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*#?-?_?\\.?[a-zA-Z0-9]*', 0, 0, 0, undef, 0, 'Html Unquoted Value', 'Types')) {
      return 1
   }
   # String => '\/?>'
   # attribute => 'Normal Text'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/?>', 0, 0, 0, undef, 0, '#pop#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseJavaMultiLineComment {
   my ($self, $text) = @_;
   # attribute => 'Java Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Java Comment')) {
      return 1
   }
   return 0;
};

sub parseJavaSingleLineComment {
   my ($self, $text) = @_;
   return 0;
};

sub parseJavaString {
   my ($self, $text) = @_;
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

sub parseJspComment {
   my ($self, $text) = @_;
   # String => '--%>'
   # attribute => 'Jsp Comment'
   # context => '#pop'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '--%>', 0, 0, 0, undef, 0, '#pop', 'Jsp Comment')) {
      return 1
   }
   return 0;
};

sub parseJspCustomTag {
   my ($self, $text) = @_;
   # String => '\/?>'
   # attribute => 'Keyword'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/?>', 0, 0, 0, undef, 0, '#pop', 'Keyword')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'Jsp Custom Tag Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'Jsp Custom Tag Value', 'Normal Text')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspCustomTagValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # attribute => 'Types'
   # char => '"'
   # context => 'Jsp Double Quoted Custom Tag Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Jsp Double Quoted Custom Tag Value', 'Types')) {
      return 1
   }
   # attribute => 'Types'
   # char => '''
   # context => 'Jsp Single Quoted Custom Tag Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Jsp Single Quoted Custom Tag Value', 'Types')) {
      return 1
   }
   # String => '\/?>'
   # attribute => 'Normal Text'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\/?>', 0, 0, 0, undef, 0, '#pop#pop', 'Normal Text')) {
      return 1
   }
   return 0;
};

sub parseJspDoubleQuotedCustomTagValue {
   my ($self, $text) = @_;
   # attribute => 'Types'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspDoubleQuotedParamValue {
   my ($self, $text) = @_;
   # attribute => 'Jsp Param Value'
   # char => '"'
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop#pop', 'Jsp Param Value')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspExpression {
   my ($self, $text) = @_;
   # String => ''${''
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '\'${\'', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Jsp Scriptlet'
   # char => '}'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#pop', 'Jsp Scriptlet')) {
      return 1
   }
   # String => 'java-1.4.2-keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'jsp-reserved-words'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'jsp-reserved-words', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'java-1.4.2-types'
   # attribute => 'Types'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-types', 0, undef, 0, '#stay', 'Types')) {
      return 1
   }
   # String => 'java-1.4.2-classes'
   # attribute => 'Java 1.4.2 Classes'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-classes', 0, undef, 0, '#stay', 'Java 1.4.2 Classes')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x19b69e0)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x19bc750)'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      # String => 'ULL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'ULL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LUL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LUL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LLU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LLU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'UL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'UL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'U'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'U', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'L'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'L', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'Java String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Java String', 'String')) {
      return 1
   }
   # String => '!%&()+,-<=>?[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<=>?[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   return 0;
};

sub parseJspScriptlet {
   my ($self, $text) = @_;
   # attribute => 'Jsp Scriptlet'
   # char => '%'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '>', 0, 0, 0, undef, 0, '#pop', 'Jsp Scriptlet')) {
      return 1
   }
   # String => '<\s*jsp:(declaration|expression|scriptlet)\s*>'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*jsp:(declaration|expression|scriptlet)\\s*>', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # String => 'java-1.4.2-keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'jsp-reserved-words'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'jsp-reserved-words', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'java-1.4.2-types'
   # attribute => 'Types'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-types', 0, undef, 0, '#stay', 'Types')) {
      return 1
   }
   # String => 'java-1.4.2-classes'
   # attribute => 'Java 1.4.2 Classes'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'java-1.4.2-classes', 0, undef, 0, '#stay', 'Java 1.4.2 Classes')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # items => 'ARRAY(0x12a3610)'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      # String => 'fF'
      # attribute => 'Float'
      # context => '#stay'
      # type => 'AnyChar'
      if ($self->testAnyChar($text, 'fF', 0, 0, undef, 0, '#stay', 'Float')) {
         return 1
      }
   }
   # attribute => 'Octal'
   # context => '#stay'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#stay', 'Octal')) {
      return 1
   }
   # attribute => 'Hex'
   # context => '#stay'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#stay', 'Hex')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # items => 'ARRAY(0x19ad810)'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      # String => 'ULL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'ULL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LUL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LUL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LLU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LLU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'UL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'UL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LU'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LU', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'LL'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'LL', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'U'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'U', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
      # String => 'L'
      # attribute => 'Decimal'
      # context => '#stay'
      # insensitive => 'true'
      # type => 'StringDetect'
      if ($self->testStringDetect($text, 'L', 1, 0, 0, undef, 0, '#stay', 'Decimal')) {
         return 1
      }
   }
   # attribute => 'Char'
   # context => '#stay'
   # type => 'HlCChar'
   if ($self->testHlCChar($text, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # String => '//\s*BEGIN.*$'
   # attribute => 'Decimal'
   # beginRegion => 'Region1'
   # context => '#stay'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*BEGIN.*$', 0, 0, 0, undef, 1, '#stay', 'Decimal')) {
      return 1
   }
   # String => '//\s*END.*$'
   # attribute => 'Decimal'
   # context => '#stay'
   # endRegion => 'Region1'
   # firstNonSpace => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '//\\s*END.*$', 0, 0, 0, undef, 1, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'Java String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Java String', 'String')) {
      return 1
   }
   # attribute => 'Normal Text'
   # beginRegion => 'Brace1'
   # char => '{'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '{', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # attribute => 'Normal Text'
   # char => '}'
   # context => '#stay'
   # endRegion => 'Brace1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '}', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '!%&()+,-<=>?[]^{|}~'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '!%&()+,-<=>?[]^{|}~', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # attribute => 'Java Comment'
   # char => '/'
   # char1 => '/'
   # context => 'Java Single-Line Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '/', 0, 0, 0, undef, 0, 'Java Single-Line Comment', 'Java Comment')) {
      return 1
   }
   # attribute => 'Java Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Java Multi-Line Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Java Multi-Line Comment', 'Java Comment')) {
      return 1
   }
   return 0;
};

sub parseJspSingleQuotedCustomTagValue {
   my ($self, $text) = @_;
   # attribute => 'Types'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Types')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspSingleQuotedParamValue {
   my ($self, $text) = @_;
   # attribute => 'Jsp Param Value'
   # char => '''
   # context => '#pop#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop#pop', 'Jsp Param Value')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspStandardDirective {
   my ($self, $text) = @_;
   # attribute => 'Jsp Directive'
   # char => '%'
   # char1 => '>'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '>', 0, 0, 0, undef, 0, '#pop', 'Jsp Directive')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'Jsp Standard Directive Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'Jsp Standard Directive Value', 'Normal Text')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?\w*:\$?\w*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?\\w*:\\$?\\w*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   return 0;
};

sub parseJspStandardDirectiveValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # attribute => 'Jsp Param Value'
   # char => '"'
   # context => 'Jsp Double Quoted Param Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Jsp Double Quoted Param Value', 'Jsp Param Value')) {
      return 1
   }
   # attribute => 'Jsp Param Value'
   # char => '''
   # context => 'Jsp Single Quoted Param Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Jsp Single Quoted Param Value', 'Jsp Param Value')) {
      return 1
   }
   # attribute => 'Jsp Directive'
   # char => '%'
   # char1 => '>'
   # context => '#pop#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '%', '>', 0, 0, 0, undef, 0, '#pop#pop', 'Jsp Directive')) {
      return 1
   }
   return 0;
};

sub parseJspXmlDirective {
   my ($self, $text) = @_;
   # String => '\s*\/?\s*>'
   # attribute => 'Jsp Directive'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\/?\\s*>', 0, 0, 0, undef, 0, '#pop', 'Jsp Directive')) {
      return 1
   }
   # String => '\s*=\s*'
   # attribute => 'Normal Text'
   # context => 'Jsp Xml Directive Value'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*=\\s*', 0, 0, 0, undef, 0, 'Jsp Xml Directive Value', 'Normal Text')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   return 0;
};

sub parseJspXmlDirectiveValue {
   my ($self, $text) = @_;
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # attribute => 'Jsp Param Value'
   # char => '"'
   # context => 'Jsp Double Quoted Param Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Jsp Double Quoted Param Value', 'Jsp Param Value')) {
      return 1
   }
   # attribute => 'Jsp Param Value'
   # char => '''
   # context => 'Jsp Single Quoted Param Value'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'Jsp Single Quoted Param Value', 'Jsp Param Value')) {
      return 1
   }
   # String => '\s*\/?\s*>'
   # attribute => 'Jsp Directive'
   # context => '#pop#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*\\/?\\s*>', 0, 0, 0, undef, 0, '#pop#pop', 'Jsp Directive')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '<%@\s*[a-zA-Z0-9_\.]*'
   # attribute => 'Jsp Directive'
   # context => 'Jsp Standard Directive'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%@\\s*[a-zA-Z0-9_\\.]*', 0, 0, 0, undef, 0, 'Jsp Standard Directive', 'Jsp Directive')) {
      return 1
   }
   # String => '<\s*jsp:(declaration|expression|scriptlet)\s*>'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*jsp:(declaration|expression|scriptlet)\\s*>', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # String => '<\s*\/?s*jsp:[a-zA-Z0-9_\.]*'
   # attribute => 'Jsp Directive'
   # context => 'Jsp Xml Directive'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?s*jsp:[a-zA-Z0-9_\\.]*', 0, 0, 0, undef, 0, 'Jsp Xml Directive', 'Jsp Directive')) {
      return 1
   }
   # String => '<%--'
   # attribute => 'Jsp Comment'
   # context => 'Jsp Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<%--', 0, 0, 0, undef, 0, 'Jsp Comment', 'Jsp Comment')) {
      return 1
   }
   # String => '<%(!|=)?'
   # attribute => 'Jsp Scriptlet'
   # context => 'Jsp Scriptlet'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<%(!|=)?', 0, 0, 0, undef, 0, 'Jsp Scriptlet', 'Jsp Scriptlet')) {
      return 1
   }
   # String => '<!--'
   # attribute => 'Html Comment'
   # context => 'Html Comment'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<!--', 0, 0, 0, undef, 0, 'Html Comment', 'Html Comment')) {
      return 1
   }
   # attribute => 'Jsp Expression'
   # char => '$'
   # char1 => '{'
   # context => 'Jsp Expression'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '$', '{', 0, 0, 0, undef, 0, 'Jsp Expression', 'Jsp Expression')) {
      return 1
   }
   # String => '<\s*\/?\s*\$?[a-zA-Z0-9_]*:\$?[a-zA-Z0-9_]*'
   # attribute => 'Keyword'
   # context => 'Jsp Custom Tag'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*\\$?[a-zA-Z0-9_]*:\\$?[a-zA-Z0-9_]*', 0, 0, 0, undef, 0, 'Jsp Custom Tag', 'Keyword')) {
      return 1
   }
   # String => '<![CDATA['
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, '<![CDATA[', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => ']]>'
   # attribute => 'Normal Text'
   # context => '#stay'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, ']]>', 0, 0, 0, undef, 0, '#stay', 'Normal Text')) {
      return 1
   }
   # String => '<\s*\/?\s*[a-zA-Z0-9_]*'
   # attribute => 'Normal Text'
   # context => 'Html Attribute'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '<\\s*\\/?\\s*[a-zA-Z0-9_]*', 0, 0, 0, undef, 0, 'Html Attribute', 'Normal Text')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::JSP - a Plugin for JSP syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::JSP;
 my $sh = new Syntax::Highlight::Engine::Kate::JSP([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::JSP is a  plugin module that provides syntax highlighting
for JSP to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author