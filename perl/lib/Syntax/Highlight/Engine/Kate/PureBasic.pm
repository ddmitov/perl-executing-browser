# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'purebasic.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 3.91
#kate version 2.3
#kate author Sven Langenkamp (ace@kylixforum.de)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::PureBasic;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Comment' => 'Comment',
      'Constant' => 'DataType',
      'Functions' => 'Function',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Number' => 'DecVal',
      'Region Marker ' => 'RegionMarker',
      'String' => 'String',
   });
   $self->listAdd('functions',
      'ACos',
      'ASin',
      'ATan',
      'Abs',
      'ActivateGadget',
      'ActivateRichEdit',
      'ActivateWindow',
      'Add3DArchive',
      'AddBillboard',
      'AddDate',
      'AddElement',
      'AddGadgetColumn',
      'AddGadgetItem',
      'AddKeyboardShortcut',
      'AddMaterialLayer',
      'AddPackFile',
      'AddPackMemory',
      'AddStatusBarField',
      'AddSysTrayIcon',
      'AdvancedGadgetEvents',
      'AllocateMemory',
      'AmbientColor',
      'AnimateEntity',
      'Asc',
      'AvailableScreenMemory',
      'BackColor',
      'Base64Encoder',
      'BillboardGroupLocate',
      'BillboardGroupMaterial',
      'BillboardGroupX',
      'BillboardGroupY',
      'BillboardGroupZ',
      'BillboardHeight',
      'BillboardLocate',
      'BillboardWidth',
      'BillboardX',
      'BillboardY',
      'BillboardZ',
      'Bin',
      'Blue',
      'Box',
      'ButtonGadget',
      'ButtonImageGadget',
      'CDAudioLength',
      'CDAudioName',
      'CDAudioStatus',
      'CDAudioTrackLength',
      'CDAudioTrackSeconds',
      'CDAudioTracks',
      'CRC32Fingerprint',
      'CallCFunction',
      'CallCFunctionFast',
      'CallCOM',
      'CallDX',
      'CallFunction',
      'CallFunctionFast',
      'CameraBackColor',
      'CameraFOV',
      'CameraLocate',
      'CameraLookAt',
      'CameraProjection',
      'CameraRange',
      'CameraRenderMode',
      'CameraX',
      'CameraY',
      'CameraZ',
      'CatchImage',
      'CatchSound',
      'CatchSprite',
      'ChangeAlphaIntensity',
      'ChangeAlphaIntensity',
      'ChangeCurrentElement',
      'ChangeGamma',
      'ChangeListIconGadgetDisplay',
      'ChangeRichEditOptions',
      'ChangeSysTrayIcon',
      'CheckBoxGadget',
      'Chr',
      'Circle',
      'ClearBillboards',
      'ClearClipboard',
      'ClearConsole',
      'ClearError',
      'ClearGadgetItemList',
      'ClearList',
      'ClearScreen',
      'ClipSprite',
      'CloseConsole',
      'CloseDatabase',
      'CloseFile',
      'CloseFont',
      'CloseGadgetList',
      'CloseHelp',
      'CloseLibrary',
      'CloseNetworkConnection',
      'CloseNetworkServer',
      'ClosePack',
      'ClosePreferences',
      'CloseRichEdit',
      'CloseScreen',
      'CloseSubMenu',
      'CloseTreeGadgetNode',
      'CloseWindow',
      'ColorRequester',
      'ComboBoxGadget',
      'CompareMemory',
      'CompareMemoryString',
      'ConsoleColor',
      'ConsoleCursor',
      'ConsoleLocate',
      'ConsoleTitle',
      'ContainerGadget',
      'CopyDirectory',
      'CopyEntity',
      'CopyFile',
      'CopyImage',
      'CopyLight',
      'CopyMaterial',
      'CopyMemory',
      'CopyMemoryString',
      'CopyMesh',
      'CopySprite',
      'CopyTexture',
      'Cos',
      'CountBillboards',
      'CountGadgetItems',
      'CountLibraryFunctions',
      'CountList',
      'CountMaterialLayers',
      'CountRenderedTriangles',
      'CountString',
      'CountTreeGadgetNodeItems',
      'CreateBillboardGroup',
      'CreateCamera',
      'CreateDirectory',
      'CreateEntity',
      'CreateFile',
      'CreateGadgetList',
      'CreateImage',
      'CreateLight',
      'CreateMaterial',
      'CreateMenu',
      'CreateMesh',
      'CreateNetworkServer',
      'CreatePack',
      'CreatePalette',
      'CreateParticleEmitter',
      'CreatePopupMenu',
      'CreatePreferences',
      'CreateSprite',
      'CreateSprite3D',
      'CreateStatusBar',
      'CreateTerrain',
      'CreateTexture',
      'CreateThread',
      'CreateToolBar',
      'DESFingerprint',
      'DatabaseColumnName',
      'DatabaseColumnType',
      'DatabaseColumns',
      'DatabaseDriverDescription',
      'DatabaseDriverName',
      'DatabaseError',
      'DatabaseQuery',
      'DatabaseUpdate',
      'Date',
      'Day',
      'DayOfWeek',
      'DayOfYear',
      'DefaultPrinter',
      'Delay',
      'DeleteDirectory',
      'DeleteElement',
      'DeleteFile',
      'DetachMenu',
      'DirectoryEntryAttributes',
      'DirectoryEntryAttributes',
      'DirectoryEntryName',
      'DirectoryEntrySize',
      'DisASMCommand',
      'DisableGadget',
      'DisableMaterialLighting',
      'DisableMenuItem',
      'DisableToolBarButton',
      'DisplayAlphaSprite',
      'DisplayAlphaSprite',
      'DisplayPalette',
      'DisplayPopupMenu',
      'DisplayRGBFilter',
      'DisplayShadowSprite',
      'DisplayShadowSprite',
      'DisplaySolidSprite',
      'DisplaySprite',
      'DisplaySprite3D',
      'DisplayTranslucideSprite',
      'DisplayTransparentSprite',
      'DrawImage',
      'DrawText',
      'DrawingBuffer',
      'DrawingBufferPitch',
      'DrawingBufferPixelFormat',
      'DrawingFont',
      'DrawingMode',
      'EditorGadget',
      'EjectCDAudio',
      'ElapsedMilliseconds',
      'Ellipse',
      'EndTimer',
      'Engine3DFrameRate',
      'EntityAnimationLength',
      'EntityLocate',
      'EntityMaterial',
      'EntityMesh',
      'EntityX',
      'EntityY',
      'EntityZ',
      'Eof',
      'EventGadgetID',
      'EventMenuID',
      'EventType',
      'EventWindowID',
      'EventlParam',
      'EventwParam',
      'ExamineDatabaseDrivers',
      'ExamineDirectory',
      'ExamineIPAddresses',
      'ExamineJoystick',
      'ExamineKeyboard',
      'ExamineLibraryFunctions',
      'ExamineMouse',
      'ExamineScreenModes',
      'ExplorerComboGadget',
      'ExplorerListGadget',
      'ExplorerTreeGadget',
      'FileSeek',
      'FileSize',
      'FillArea',
      'FindString',
      'FindText',
      'FirstDatabaseRow',
      'FirstElement',
      'FlipBuffers',
      'Fog',
      'FontDialog',
      'FontID',
      'FontRequester',
      'FormatDate',
      'Frame3DGadget',
      'FreeBillboardGroup',
      'FreeCamera',
      'FreeEntity',
      'FreeGadget',
      'FreeImage',
      'FreeLight',
      'FreeMaterial',
      'FreeMemory',
      'FreeMenu',
      'FreeMesh',
      'FreeModule',
      'FreeMovie',
      'FreePalette',
      'FreeParticleEmitter',
      'FreeSound',
      'FreeSprite',
      'FreeSprite3D',
      'FreeStatusBar',
      'FreeTexture',
      'FreeToolBar',
      'FrontColor',
      'GadgetHeight',
      'GadgetID',
      'GadgetItemID',
      'GadgetToolTip',
      'GadgetWidth',
      'GadgetX',
      'GadgetY',
      'GetClipboardData',
      'GetClipboardText',
      'GetCurrentEIP',
      'GetDatabaseFloat',
      'GetDatabaseLong',
      'GetDatabaseString',
      'GetDisASMString',
      'GetEntityAnimationTime',
      'GetErrorAddress',
      'GetErrorCounter',
      'GetErrorDLL',
      'GetErrorDescription',
      'GetErrorLineNR',
      'GetErrorModuleName',
      'GetErrorNumber',
      'GetErrorRegister',
      'GetExtensionPart',
      'GetFilePart',
      'GetGadgetAttribute',
      'GetGadgetItemAttribute',
      'GetGadgetItemState',
      'GetGadgetItemText',
      'GetGadgetState',
      'GetGadgetText',
      'GetMaxTimerResolution',
      'GetMenuItemState',
      'GetMinTimerResolution',
      'GetModulePosition',
      'GetModuleRow',
      'GetPaletteColor',
      'GetPathPart',
      'GetRichEditStyle',
      'GetRichEditText',
      'GetSelectedText',
      'GetWindowTitle',
      'GoToEIP',
      'GrabImage',
      'GrabSprite',
      'Green',
      'Hex',
      'HideBillboardGroup',
      'HideEntity',
      'HideGadget',
      'HideLight',
      'HideMenu',
      'HideParticleEmitter',
      'HideWindow',
      'Hostname',
      'Hour',
      'HyperLinkGadget',
      'IPAddressField',
      'IPAddressGadget',
      'IPString',
      'IPString',
      'ImageDepth',
      'ImageGadget',
      'ImageHeight',
      'ImageID',
      'ImageOutput',
      'ImageWidth',
      'InitCDAudio',
      'InitDatabase',
      'InitEngine3D',
      'InitJoystick',
      'InitKeyboard',
      'InitModule',
      'InitMouse',
      'InitMovie',
      'InitNetwork',
      'InitPalette',
      'InitSound',
      'InitSprite',
      'InitSprite3D',
      'Inkey',
      'Input',
      'InputRequester',
      'InsertElement',
      'Int',
      'IsDatabase',
      'IsDirectory',
      'IsFile',
      'IsFilename',
      'IsFont',
      'IsFunction',
      'IsFunctionEntry',
      'IsGadget',
      'IsImage',
      'IsLibrary',
      'IsMenu',
      'IsModule',
      'IsMovie',
      'IsPalette',
      'IsScreenActive',
      'IsSprite',
      'IsSprite3D',
      'IsStatusBar',
      'IsSysTrayIcon',
      'IsToolBar',
      'IsWindow',
      'JoystickAxisX',
      'JoystickAxisY',
      'JoystickButton',
      'KeyboardInkey',
      'KeyboardMode',
      'KeyboardPushed',
      'KeyboardReleased',
      'KillThread',
      'LCase',
      'LSet',
      'LTrim',
      'LastElement',
      'Left',
      'Len',
      'LibraryFunctionAddress',
      'LibraryFunctionName',
      'LightColor',
      'LightLocate',
      'LightSpecularColor',
      'Line',
      'LineXY',
      'ListIconGadget',
      'ListIndex',
      'ListViewGadget',
      'LoadFont',
      'LoadImage',
      'LoadMesh',
      'LoadModule',
      'LoadMovie',
      'LoadPalette',
      'LoadSound',
      'LoadSprite',
      'LoadTexture',
      'LoadWorld',
      'Loc',
      'Locate',
      'Lof',
      'Log',
      'Log10',
      'MD5FileFingerprint',
      'MD5Fingerprint',
      'MDIGadget',
      'MakeIPAddress',
      'MakeIPAddress',
      'MaterialAmbientColor',
      'MaterialBlendingMode',
      'MaterialDiffuseColor',
      'MaterialFilteringMode',
      'MaterialID',
      'MaterialShadingMode',
      'MaterialSpecularColor',
      'MemoryStringLength',
      'MenuBar',
      'MenuHeight',
      'MenuID',
      'MenuItem',
      'MenuTitle',
      'MeshID',
      'MessageRequester',
      'Mid',
      'Minute',
      'ModuleVolume',
      'Month',
      'MouseButton',
      'MouseDeltaX',
      'MouseDeltaY',
      'MouseLocate',
      'MouseWheel',
      'MouseX',
      'MouseY',
      'MoveBillboard',
      'MoveBillboardGroup',
      'MoveCamera',
      'MoveEntity',
      'MoveLight',
      'MoveParticleEmitter',
      'MoveWindow',
      'MovieAudio',
      'MovieHeight',
      'MovieInfo',
      'MovieLength',
      'MovieSeek',
      'MovieStatus',
      'MovieWidth',
      'NetworkClientEvent',
      'NetworkClientID',
      'NetworkServerEvent',
      'NewPrinterPage',
      'NextDatabaseDriver',
      'NextDatabaseRow',
      'NextDirectoryEntry',
      'NextElement',
      'NextIPAddress',
      'NextLibraryFunction',
      'NextPackFile',
      'NextScreenMode',
      'NextSelectedFileName',
      'OSVersion',
      'OffsetOf',
      'OnErrorExit',
      'OnErrorGosub',
      'OnErrorGoto',
      'OnErrorResume',
      'OpenComPort',
      'OpenConsole',
      'OpenDatabase',
      'OpenDatabaseRequester',
      'OpenFile',
      'OpenFileRequester',
      'OpenGadgetList',
      'OpenHelp',
      'OpenLibrary',
      'OpenNetworkConnection',
      'OpenPack',
      'OpenPreferences',
      'OpenRichEdit',
      'OpenScreen',
      'OpenSubMenu',
      'OpenTreeGadgetNode',
      'OpenWindow',
      'OpenWindowedScreen',
      'OptionGadget',
      'PackFileSize',
      'PackMemory',
      'PackerCallback',
      'PanelGadget',
      'ParseDate',
      'ParticleColorFader',
      'ParticleColorRange',
      'ParticleEmissionRate',
      'ParticleEmitterLocate',
      'ParticleEmitterX',
      'ParticleEmitterY',
      'ParticleEmitterZ',
      'ParticleMaterial',
      'ParticleSize',
      'ParticleTimeToLive',
      'ParticleVelocity',
      'PathRequester',
      'PauseCDAudio',
      'PauseMovie',
      'PauseThread',
      'PeekB',
      'PeekF',
      'PeekL',
      'PeekS',
      'PeekW',
      'PlayCDAudio',
      'PlayModule',
      'PlayMovie',
      'PlaySound',
      'Plot',
      'Point',
      'PokeB',
      'PokeF',
      'PokeL',
      'PokeS',
      'PokeW',
      'Pow',
      'PreferenceComment',
      'PreferenceGroup',
      'PreviousDatabaseRow',
      'PreviousElement',
      'Print',
      'PrintN',
      'PrintRequester',
      'PrinterOutput',
      'PrinterPageHeight',
      'PrinterPageWidth',
      'ProgramParameter',
      'ProgressBarGadget',
      'RGB',
      'RSet',
      'RTrim',
      'Random',
      'RandomSeed',
      'ReAllocateMemory',
      'ReadByte',
      'ReadData',
      'ReadFile',
      'ReadFloat',
      'ReadLong',
      'ReadPreferenceFloat',
      'ReadPreferenceLong',
      'ReadPreferenceString',
      'ReadString',
      'ReadWord',
      'ReceiveNetworkData',
      'ReceiveNetworkFile',
      'Red',
      'ReleaseMouse',
      'RemoveBillboard',
      'RemoveGadgetColumn',
      'RemoveGadgetItem',
      'RemoveKeyboardShortcut',
      'RemoveMaterialLayer',
      'RemoveString',
      'RemoveSysTrayIcon',
      'RenameFile',
      'RenderMovieFrame',
      'RenderWorld',
      'ReplaceString',
      'ReplaceText',
      'ResetList',
      'ResizeBillboard',
      'ResizeEntity',
      'ResizeGadget',
      'ResizeImage',
      'ResizeMovie',
      'ResizeParticleEmitter',
      'ResizeRichEdit',
      'ResizeWindow',
      'ResumeCDAudio',
      'ResumeMovie',
      'ResumeThread',
      'RichEditBackground',
      'RichEditBackgroundColor',
      'RichEditFont',
      'RichEditFontFace',
      'RichEditFontSize',
      'RichEditHeight',
      'RichEditID',
      'RichEditIndex',
      'RichEditLocate',
      'RichEditMouseX',
      'RichEditMouseY',
      'RichEditOptions',
      'RichEditParent',
      'RichEditTextColor',
      'RichEditWidth',
      'RichEditX',
      'RichEditY',
      'Right',
      'RotateBillboardGroup',
      'RotateCamera',
      'RotateEntity',
      'RotateMaterial',
      'RotateParticleEmitter',
      'RotateSprite3D',
      'Round',
      'RunProgram',
      'SaveFileRequester',
      'SaveImage',
      'SaveSprite',
      'ScaleEntity',
      'ScaleMaterial',
      'ScreenID',
      'ScreenModeDepth',
      'ScreenModeHeight',
      'ScreenModeRefreshRate',
      'ScreenModeWidth',
      'ScreenOutput',
      'ScrollAreaGadget',
      'ScrollBarGadget',
      'ScrollMaterial',
      'Second',
      'SelectElement',
      'SelectText',
      'SelectedFilePattern',
      'SelectedFontColor',
      'SelectedFontName',
      'SelectedFontSize',
      'SelectedFontStyle',
      'SelectedRange',
      'SendNetworkData',
      'SendNetworkFile',
      'SendNetworkString',
      'Set/GetWindowTitle',
      'SetClipboardData',
      'SetClipboardText',
      'SetEntityAnimationTime',
      'SetErrorNumber',
      'SetFrameRate',
      'SetGadgetAttribute',
      'SetGadgetFont',
      'SetGadgetItemAttribute',
      'SetGadgetItemState',
      'SetGadgetItemText',
      'SetGadgetState',
      'SetGadgetText',
      'SetMenuItemState',
      'SetMeshData',
      'SetModulePosition',
      'SetPaletteColor',
      'SetRefreshRate',
      'SetRichEditCallback',
      'SetRichEditText',
      'SetWindowCallback',
      'SetWindowTitle',
      'Sin',
      'SizeOf',
      'SkyBox',
      'SkyDome',
      'SortArray',
      'SortList',
      'SoundFrequency',
      'SoundPan',
      'SoundVolume',
      'Space',
      'SpinGadget',
      'SplitterGadget',
      'Sprite3DBlendingMode',
      'Sprite3DQuality',
      'SpriteCollision',
      'SpriteDepth',
      'SpriteHeight',
      'SpriteOutput',
      'SpritePixelCollision',
      'SpriteWidth',
      'Sqr',
      'Start3D',
      'StartDrawing',
      'StartPrinting',
      'StartSpecialFX',
      'StartTimer',
      'StatusBarIcon',
      'StatusBarText',
      'Stop3D',
      'StopCDAudio',
      'StopDrawing',
      'StopModule',
      'StopMovie',
      'StopPrinting',
      'StopSound',
      'StopSpecialFX',
      'Str',
      'StrF',
      'StrU',
      'StreamFileIn',
      'StreamFileOut',
      'StringField',
      'StringGadget',
      'SysTrayIconToolTip',
      'Tan',
      'TerrainHeight',
      'TextGadget',
      'TextLength',
      'TextureHeight',
      'TextureID',
      'TextureOutput',
      'TextureWidth',
      'ThreadPriority',
      'ToolBarImageButton',
      'ToolBarSeparator',
      'ToolBarStandardButton',
      'ToolBarToolTip',
      'TrackBarGadget',
      'TransformSprite3D',
      'TransparentSpriteColor',
      'TreeGadget',
      'TreeGadgetItemNumber',
      'Trim',
      'UCase',
      'UnpackMemory',
      'UseBuffer',
      'UseCDAudio',
      'UseDatabase',
      'UseDirectory',
      'UseFile',
      'UseFont',
      'UseGadgetList',
      'UseImage',
      'UseJPEGImageDecoder',
      'UseJPEGImageEncoder',
      'UseMovie',
      'UseOGGSoundDecoder',
      'UsePNGImageDecoder',
      'UsePNGImageEncoder',
      'UsePalette',
      'UseRichEdit',
      'UseTGAImageDecoder',
      'UseTIFFImageDecoder',
      'UseWindow',
      'Val',
      'ValF',
      'WaitThread',
      'WaitWindowEvent',
      'WebGadget',
      'WindowEvent',
      'WindowHeight',
      'WindowID',
      'WindowMouseX',
      'WindowMouseY',
      'WindowOutput',
      'WindowWidth',
      'WindowX',
      'WindowY',
      'WriteByte',
      'WriteData',
      'WriteFloat',
      'WriteLong',
      'WritePreferenceFloat',
      'WritePreferenceLong',
      'WritePreferenceString',
      'WriteString',
      'WriteStringN',
      'WriteWord',
      'Year',
      'ZoomSprite3D',
   );
   $self->listAdd('keywords',
      'Break',
      'Case',
      'CompilerCase',
      'CompilerDefault',
      'CompilerElse',
      'CompilerEndIf',
      'CompilerEndSelect',
      'CompilerIf',
      'CompilerSelect',
      'Continue',
      'Data',
      'DataSection',
      'Debug',
      'Declare',
      'DefType',
      'Default',
      'Dim',
      'Else',
      'ElseIf',
      'End',
      'EndDataSection',
      'EndEnumeration',
      'EndIf',
      'EndInterface',
      'EndProcedure',
      'EndSelect',
      'EndStructure',
      'Enumeration',
      'Extends',
      'FakeReturn',
      'For',
      'ForEach',
      'Global',
      'Gosub',
      'Goto',
      'If',
      'IncludeBinary',
      'IncludeFile',
      'IncludePath',
      'Interface',
      'NewList',
      'Next',
      'Procedure',
      'ProcedureDLL',
      'ProcedureReturn',
      'Protected',
      'Read',
      'Repeat',
      'Restore',
      'Return',
      'Select',
      'Shared',
      'Static',
      'Step',
      'Structure',
      'To',
      'Until',
      'Wend',
      'While',
      'XIncludeFile',
   );
   $self->contextdata({
      'Comment1' => {
         callback => \&parseComment1,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
         lineending => '#pop',
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
   return 'PureBasic';
}

sub parseComment1 {
   my ($self, $text) = @_;
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => '\b(if)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'IfRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(if)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endif)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'IfRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endif)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(while)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'WhileRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(while)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(wend)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'WhileRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(wend)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(repeat)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'RepeatRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(repeat)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(until)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'RepeatRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(until)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(select)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'SelectRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(select)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endselect)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'SelectRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endselect)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(for|foreach)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'ForRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(for|foreach)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(next)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'ForRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(next)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(procedure|proceduredll)([.\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'ProcedureRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(procedure|proceduredll)([.\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endprocedure)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'ProcedureRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endprocedure)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(structure)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'StructureRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(structure)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endstructure)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'StructureRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endstructure)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(interface)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'InterfaceRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(interface)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endinterface)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'InterfaceRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endinterface)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(enumeration)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'EnumerationRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(enumeration)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(endenumeration)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'EnumerationRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(endenumeration)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(datasection)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'DataSectionRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(datasection)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(enddatasection)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'DataSectionRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(enddatasection)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(compilerif)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'CompilerIfRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(compilerif)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(compilerendif)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'CompilerIfRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(compilerendif)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(compilerselect)([\s]|$)'
   # attribute => 'Keyword'
   # beginRegion => 'CompilerSelectRegion'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(compilerselect)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => '\b(compilerendselect)([\s]|$)'
   # attribute => 'Keyword'
   # context => '#stay'
   # endRegion => 'CompilerEndSelectRegion'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\b(compilerendselect)([\\s]|$)', 1, 0, 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Functions'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Functions')) {
      return 1
   }
   # String => '\#+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*'
   # attribute => 'Constant'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\#+[a-zA-Z_\\x7f-\\xff][a-zA-Z0-9_\\x7f-\\xff]*', 0, 0, 0, undef, 0, '#stay', 'Constant')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'Number'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Number')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '^\s*;+\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'marker'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*;+\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => '^\s*;+\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'marker'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^\\s*;+\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # attribute => 'Comment'
   # char => ';'
   # context => 'Comment1'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ';', 0, 0, 0, undef, 0, 'Comment1', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::PureBasic - a Plugin for PureBasic syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::PureBasic;
 my $sh = new Syntax::Highlight::Engine::Kate::PureBasic([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::PureBasic is a  plugin module that provides syntax highlighting
for PureBasic to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author