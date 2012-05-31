{**
@Abstract(String consts)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.07.2011)
@LastMod(19.07.2011)
@Version(0.5)

Prototype:
Borland Delphi Visual Component Library
Copyright (c) 1995,99 Inprise Corporation
Руссификация: 1998-99 Polaris Software http://members.xoom.com/PolarisSoft

0.0.5.7 - 19.07.2011
[*] Rename Consts.pas -> AStrConsts.pas
}

(*
Delphi7
{*******************************************************}
{       Borland Delphi Visual Component Library         }
{  Copyright (c) 1995-2001 Borland Software Corporation }
{*******************************************************}

unit Consts;

interface

resourcestring
  SOpenFileTitle = 'Open';
  SCantWriteResourceStreamError = 'Can''t write to a read-only resource stream';
  SDuplicateReference = 'WriteObject called twice for the same instance';
  SClassMismatch = 'Resource %s is of incorrect class';
  SInvalidTabIndex = 'Tab index out of bounds';
  SInvalidTabPosition = 'Tab position incompatible with current tab style';
  SInvalidTabStyle = 'Tab style incompatible with current tab position';
  SInvalidBitmap = 'Bitmap image is not valid';
  SInvalidIcon = 'Icon image is not valid';
  SInvalidMetafile = 'Metafile is not valid';
  SInvalidPixelFormat = 'Invalid pixel format';
  SInvalidImage = 'Invalid image';
  SBitmapEmpty = 'Bitmap is empty';
  SScanLine = 'Scan line index out of range';
  SChangeIconSize = 'Cannot change the size of an icon';
  SOleGraphic = 'Invalid operation on TOleGraphic';
  SUnknownExtension = 'Unknown picture file extension (.%s)';
  SUnknownClipboardFormat = 'Unsupported clipboard format';
  SOutOfResources = 'Out of system resources';
  SNoCanvasHandle = 'Canvas does not allow drawing';
  SInvalidImageSize = 'Invalid image size';
  STooManyImages = 'Too many images';
  SDimsDoNotMatch = 'Image dimensions do not match image list dimensions';
  SInvalidImageList = 'Invalid ImageList';
  SReplaceImage = 'Unable to Replace Image';
  SImageIndexError = 'Invalid ImageList Index';
  SImageReadFail = 'Failed to read ImageList data from stream';
  SImageWriteFail = 'Failed to write ImageList data to stream';
  SWindowDCError = 'Error creating window device context';
  SClientNotSet = 'Client of TDrag not initialized';
  SWindowClass = 'Error creating window class';
  SWindowCreate = 'Error creating window';
  SCannotFocus = 'Cannot focus a disabled or invisible window';
  SParentRequired = 'Control ''%s'' has no parent window';
  SParentGivenNotAParent = 'Parent given is not a parent of ''%s''';
  SMDIChildNotVisible = 'Cannot hide an MDI Child Form';
  SVisibleChanged = 'Cannot change Visible in OnShow or OnHide';
  SCannotShowModal = 'Cannot make a visible window modal';
  SScrollBarRange = 'Scrollbar property out of range';
  SPropertyOutOfRange = '%s property out of range';
  SMenuIndexError = 'Menu index out of range';
  SMenuReinserted = 'Menu inserted twice';
  SMenuNotFound = 'Sub-menu is not in menu';
  SNoTimers = 'Not enough timers available';
  SNotPrinting = 'Printer is not currently printing';
  SPrinting = 'Printing in progress';
  SPrinterIndexError = 'Printer index out of range';
  SInvalidPrinter = 'Printer selected is not valid';
  SDeviceOnPort = '%s on %s';
  SGroupIndexTooLow = 'GroupIndex cannot be less than a previous menu item''s GroupIndex';
  STwoMDIForms = 'Cannot have more than one MDI form per application';
  SNoMDIForm = 'Cannot create form. No MDI forms are currently active';
  SImageCanvasNeedsBitmap = 'Can only modify an image if it contains a bitmap';
  SControlParentSetToSelf = 'A control cannot have itself as its parent';
  SOKButton = 'OK';
  SCancelButton = 'Cancel';
  SYesButton = '&Yes';
  SNoButton = '&No';
  SHelpButton = '&Help';
  SCloseButton = '&Close';
  SIgnoreButton = '&Ignore';
  SRetryButton = '&Retry';
  SAbortButton = 'Abort';
  SAllButton = '&All';

  SCannotDragForm = 'Cannot drag a form';
  SPutObjectError = 'PutObject to undefined item';
  SCardDLLNotLoaded = 'Could not load CARDS.DLL';
  SDuplicateCardId = 'Duplicate CardId found';

  SDdeErr = 'An error returned from DDE  ($0%x)';
  SDdeConvErr = 'DDE Error - conversation not established ($0%x)';
  SDdeMemErr = 'Error occurred when DDE ran out of memory ($0%x)';
  SDdeNoConnect = 'Unable to connect DDE conversation';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'Cannot load older version of TShape';
  SVMetafiles = 'Metafiles';
  SVEnhMetafiles = 'Enhanced Metafiles';
  SVIcons = 'Icons';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Grid too large for operation';
  STooManyDeleted = 'Too many rows or columns deleted';
  SIndexOutOfRange = 'Grid index out of range';
  SFixedColTooBig = 'Fixed column count must be less than column count';
  SFixedRowTooBig = 'Fixed row count must be less than row count';
  SInvalidStringGridOp = 'Cannot insert or delete rows from grid';
  SInvalidEnumValue = 'Invalid Enum Value';
  SInvalidNumber = 'Invalid numeric value';
  SOutlineIndexError = 'Outline index not found';
  SOutlineExpandError = 'Parent must be expanded';
  SInvalidCurrentItem = 'Invalid value for current item';
  SMaskErr = 'Invalid input value';
  SMaskEditErr = 'Invalid input value.  Use escape key to abandon changes';
  SOutlineError = 'Invalid outline index';
  SOutlineBadLevel = 'Incorrect level assignment';
  SOutlineSelection = 'Invalid selection';
  SOutlineFileLoad = 'File load error';
  SOutlineLongLine = 'Line too long';
  SOutlineMaxLevels = 'Maximum outline depth exceeded';

  SMsgDlgWarning = 'Warning';
  SMsgDlgError = 'Error';
  SMsgDlgInformation = 'Information';
  SMsgDlgConfirm = 'Confirm';
  SMsgDlgYes = '&Yes';
  SMsgDlgNo = '&No';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Cancel';
  SMsgDlgHelp = '&Help';
  SMsgDlgHelpNone = 'No help available';
  SMsgDlgHelpHelp = 'Help';
  SMsgDlgAbort = '&Abort';
  SMsgDlgRetry = '&Retry';
  SMsgDlgIgnore = '&Ignore';
  SMsgDlgAll = '&All';
  SMsgDlgNoToAll = 'N&o to All';
  SMsgDlgYesToAll = 'Yes to &All';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Unknown)';
  srNone = '(None)';
  SOutOfRange = 'Value must be between %d and %d';

  SDateEncodeError = 'Invalid argument to date encode';
  sAllFilter = 'All';
  SNoVolumeLabel = ': [ - no volume label - ]';
  SInsertLineError = 'Unable to insert a line';

  SConfirmCreateDir = 'The specified directory does not exist. Create it?';
  SSelectDirCap = 'Select Directory';
  SDirNameCap = 'Directory &Name:';
  SDrivesCap = 'D&rives:';
  SDirsCap = '&Directories:';
  SNetworkCap = 'Ne&twork...';

  SColorPrefix = 'Color';               //!! obsolete - delete in 5.0
  SColorTags = 'ABCDEFGHIJKLMNOP';      //!! obsolete - delete in 5.0

  SInvalidClipFmt = 'Invalid clipboard format';
  SIconToClipboard = 'Clipboard does not support Icons';
  SCannotOpenClipboard = 'Cannot open clipboard';

  SDefault = 'Default';

  SInvalidMemoSize = 'Text exceeds memo capacity';
  SCustomColors = 'Custom Colors';
  SInvalidPrinterOp = 'Operation not supported on selected printer';
  SNoDefaultPrinter = 'There is no default printer currently selected';

  SIniFileWriteError = 'Unable to write to %s';

  SBitsIndexError = 'Bits index out of range';

  SUntitled = '(Untitled)';

  SInvalidRegType = 'Invalid data type for ''%s''';

  SUnknownConversion = 'Unknown RichEdit conversion file extension (.%s)';
  SDuplicateMenus = 'Menu ''%s'' is already being used by another form';

  SPictureLabel = 'Picture:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Preview';

  SCannotOpenAVI = 'Cannot open AVI';

  SNotOpenErr = 'No MCI device open';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVideo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'DigitalVideo';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Other';
  SMCIOverlay = 'Overlay';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Sequencer';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Videodisc';
  SMCIWaveAudio = 'WaveAudio';
  SMCIUnknownError = 'Unknown error code';

  SBoldItalicFont = 'Bold Italic';
  SBoldFont = 'Bold';
  SItalicFont = 'Italic';
  SRegularFont = 'Regular';

  SPropertiesVerb = 'Properties';

  SServiceFailed = 'Service failed on %s: %s';
  SExecute = 'execute';
  SStart = 'start';
  SStop = 'stop';
  SPause = 'pause';
  SContinue = 'continue';
  SInterrogate = 'interrogate';
  SShutdown = 'shutdown';
  SCustomError = 'Service failed in custom message(%d): %s';
  SServiceInstallOK = 'Service installed successfully';
  SServiceInstallFailed = 'Service "%s" failed to install with error: "%s"';
  SServiceUninstallOK = 'Service uninstalled successfully';
  SServiceUninstallFailed = 'Service "%s" failed to uninstall with error: "%s"';

  SInvalidActionRegistration = 'Invalid action registration';
  SInvalidActionUnregistration = 'Invalid action unregistration';
  SInvalidActionEnumeration = 'Invalid action enumeration';
  SInvalidActionCreation = 'Invalid action creation';

  SDockedCtlNeedsName = 'Docked control must have a name';
  SDockTreeRemoveError = 'Error removing control from dock tree';
  SDockZoneNotFound = ' - Dock zone not found';
  SDockZoneHasNoCtl = ' - Dock zone has no control';

  SAllCommands = 'All Commands';

  SDuplicateItem = 'List does not allow duplicates ($0%x)';

  STextNotFound = 'Text not found: "%s"';
  SBrowserExecError = 'No default browser is specified';

  SColorBoxCustomCaption = 'Custom...';

  SMultiSelectRequired = 'Multiselect mode must be on for this feature';

  SKeyCaption = 'Key';
  SValueCaption = 'Value';
  SKeyConflict = 'A key with the name of "%s" already exists';
  SKeyNotFound = 'Key "%s" not found';
  SNoColumnMoving = 'goColMoving is not a supported option';
  SNoEqualsInKey = 'Key may not contain equals sign ("=")';

  SSendError = 'Error sending mail';
  SAssignSubItemError = 'Cannot assign a subitem to an actionbar when one of it''s parent''s is already assigned to an actionbar';
  SDeleteItemWithSubItems = 'Item %s has subitems, delete anyway?';
  SDeleteNotAllowed = 'You are not allowed to delete this item';
  SMoveNotAllowed = 'Item %s is not allowed to be moved';    
  SMoreButtons = 'More Buttons';
  SErrorDownloadingURL = 'Error downloading URL: %s';
  SUrlMonDllMissing = 'Unable to load %s';
  SAllActions = '(All Actions)';
  SNoCategory = '(No Category)';
  SExpand = 'Expand';
  SErrorSettingPath = 'Error setting path: "%s"';
  SLBPutError = 'Attempting to put items into a virtual style listbox';
  SErrorLoadingFile = 'Error loading previously saved settings file: %s'#13'Would you like to delete it?';
  SResetUsageData = 'Reset all usage data?';
  SFileRunDialogTitle = 'Run';
  SNoName = '(No Name)';
  SErrorActionManagerNotAssigned = 'ActionManager must first be assigned';
  SAddRemoveButtons = '&Add or Remove Buttons';
  SResetActionToolBar = 'Reset Toolbar';
  SCustomize = '&Customize';
  SSeparator = 'Separator';
  SCirularReferencesNotAllowed = 'Circular references not allowed';
  SCannotHideActionBand = '%s does not allow hiding';
  SErrorSettingCount = 'Error setting %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) style must be virtual in order to set Count';
  SUnableToSaveSettings = 'Unable to save settings';
  SRestoreDefaultSchedule = 'Would you like to reset to the default Priority Schedule?';
  SNoGetItemEventHandler = 'No OnGetItem event handler assigned';
  SInvalidColorMap = 'Invalid Colormap this ActionBand requires ColorMaps of type TCustomActionBarColorMapEx';
  SDuplicateActionBarStyleName = 'A style named %s has already been registered';
  SStandardStyleActionBars = 'Standard Style';
  SXPStyleActionBars = 'XP Style';
  SActionBarStyleMissing = 'No ActionBand style unit present in the uses clause.'#13 +
    'Your application must include either XPStyleActnCtrls, StdStyleActnCtrls or ' +
    'a third party ActionBand style unit in its uses clause.';

implementation

end.
*)
unit AStrConsts;

interface

resourcestring
{$IFNDEF VER100}
  SOpenFileTitle = 'Открыть';
{$ENDIF}
  SAssignError = 'Не могу значение %s присвоить %s';
  SFCreateError = 'Не могу создать файл %s';
  SFOpenError = 'Не могу открыть файл %s';
  SReadError = 'Ошибка чтения потока';
  SWriteError = 'Ошибка записи потока';
  SMemoryStreamError = 'Не хватает памяти при расширении memory stream';
  SCantWriteResourceStreamError = 'Не могу записывать в поток ресурсов read only';
  SDuplicateReference = 'WriteObject вызван дважды для одного и того же экземпляра';
  SClassNotFound = 'Класс %s не найден';
  SInvalidImage = 'Неверный формат потока';
  SResNotFound = 'Ресурс %s не найден';
  SClassMismatch = 'Неверный класс ресурса %s';
  SListIndexError = 'Индекс списка вышел за границы (%d)';
  SListCapacityError = 'Размер списка вышел за границы (%d)';
  SListCountError = 'Счетчик списка вышел за границы (%d)';
  SSortedListError = 'Операция недопустима для отсортированного списка строк';
  SDuplicateString = 'Список строк не допускает дубликатов';
  SInvalidTabIndex = 'Tab индекс вышел за границы';
{$IFNDEF VER100}
  SInvalidTabPosition = 'Позиция tab несовместима с текущим стилем tab';
  SInvalidTabStyle = 'Cтиль tab несовместим с текущей позицией tab';
{$ENDIF}
  SDuplicateName = 'Компонент с именем %s уже существует';
  SInvalidName = '''''%s'''' недопустимо в качестве имени компонента';
  SDuplicateClass = 'Класс с именем %s уже существует';
  SNoComSupport = '%s не зарегистрирован как COM класс';
  SInvalidInteger = '''''%s'''' - неверное целое число';
  SLineTooLong = 'Строка слишком длинная';
  SInvalidPropertyValue = 'Неверное значение свойства';
  SInvalidPropertyPath = 'Неверный путь к свойству';
{$IFDEF VER130}
  SInvalidPropertyType = 'Неверный тип свойства: %s';
  SInvalidPropertyElement = 'Неверный элемент свойства: %s';
{$ENDIF}
  SUnknownProperty = 'Свойство не существует';
  SReadOnlyProperty = 'Свойство только для чтения';
  SPropertyException = 'Ошибка чтения %s.%s: %s';
  SAncestorNotFound = 'Предок для ''%s'' не найден';
  SInvalidBitmap = 'Изображение Bitmap имеет неверный формат';
  SInvalidIcon = 'Иконка (Icon) имеет неверный формат';
  SInvalidMetafile = 'Метафайл имеет неверный формат';
  SInvalidPixelFormat = 'Неверный точечный (pixel) формат';
  SBitmapEmpty = 'Изображение Bitmap пустое';
  SScanLine = 'Scan line индекс вышел за границы';
  SChangeIconSize = 'Не могу изменить размер иконки';
  SOleGraphic = 'Неверная операция с TOleGraphic';
  SUnknownExtension = 'Неизвестное расширение файла изображения (.%s)';
  SUnknownClipboardFormat = 'Неподдерживаемый формат буфера обмена';
  SOutOfResources = 'Не хватает системных ресурсов';
  SNoCanvasHandle = 'Canvas не позволяет рисовать';
  SInvalidImageSize = 'Неверный размер изображения';
  STooManyImages = 'Слишком много изображений';
  SDimsDoNotMatch = 'Размеры изображения не совпадают с размерами в image list';
  SInvalidImageList = 'Неверный ImageList';
  SReplaceImage = 'Невозможно заменить изображение';
  SImageIndexError = 'Неверный индекс ImageList';
  SImageReadFail = 'Ошибка чтения данных ImageList из потока';
  SImageWriteFail = 'Ошибка записи данных ImageList в поток';
  SWindowDCError = 'Ошибка создания контекста окна (window device context)';
  SClientNotSet = 'Клиент TDrag не инициализирован';
  SWindowClass = 'Ошибка создания оконного класса';
  SWindowCreate = 'Ошибка создания окна';
  SCannotFocus = 'Не могу передать фокус ввода отключенному или невидимому окну';
  SParentRequired = 'Элемент управления ''%s'' не имеет родительского окна';
  SMDIChildNotVisible = 'Не могу скрыть дочернюю форму MDI';
  SVisibleChanged = 'Не могу изменить Visible в OnShow или OnHide';
  SCannotShowModal = 'Не могу сделать видимым модальное окно';
  SScrollBarRange = 'Свойство Scrollbar вышло за границы';
  SPropertyOutOfRange = 'Свойство %s вышло за границы';
  SMenuIndexError = 'Индекс меню вышел за границы';
  SMenuReinserted = 'Меню вставлено дважды';
  SMenuNotFound = 'Подменю - не в меню';
  SNoTimers = 'Нет доступных таймеров';
  SNotPrinting = 'Принтер не находится сейчас в состоянии печати';
  SPrinting = 'Идет печать...';
  SPrinterIndexError = 'Индекс принтера вышел за границы';
  SInvalidPrinter = 'Выбран неверный принтер';
  SDeviceOnPort = '%s on %s';
  SGroupIndexTooLow = 'GroupIndex не может быть меньше, чем GroupIndex предыдущего пункта меню';
  STwoMDIForms = 'Нельзя иметь более одной основной MDI формы в программе';
  SNoMDIForm = 'Не могу создать форму. Нет активных MDI форм';
  SRegisterError = 'Неверная регистрация компонента';
  SImageCanvasNeedsBitmap = 'Можно редактировать только изображения, которые содержат bitmap';
  SControlParentSetToSelf = 'Элемент управления не может быть родителем самого себя';
  SOKButton = 'OK';
  SCancelButton = 'Отмена';
  SYesButton = '&Да';
  SNoButton = '&Нет';
  SHelpButton = '&Справка';
  SCloseButton = '&Закрыть';
  SIgnoreButton = 'Про&должить';
  SRetryButton = '&Повторить';
  SAbortButton = 'Прервать';
  SAllButton = '&Все';

  SCannotDragForm = 'Не могу перемещать форму';
  SPutObjectError = 'PutObject для неопределенного типа';
  SCardDLLNotLoaded = 'Не могу загрузить CARDS.DLL';
  SDuplicateCardId = 'Найден дубликат CardId';

  SDdeErr = 'Возвращена ошибка DDE  ($0%x)';
  SDdeConvErr = 'Ошибка DDE - диалог не установлен ($0%x)';
  SDdeMemErr = 'Ошибка - нехватка памяти для DDE ($0%x)';
  SDdeNoConnect = 'Не могу присоединить DDE диалог (conversation)';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'Не могу загрузить старую версию TShape';
  SVMetafiles = 'Метафайлы';
  SVEnhMetafiles = 'Расширенные метафайлы';
  SVIcons = 'Иконки';
  SVBitmaps = 'Картинки';
  SGridTooLarge = 'Таблица (Grid) слишком большая для работы';
  STooManyDeleted = 'Удаляется слишком много строк или столбцов';
  SIndexOutOfRange = 'Индекс Grid вышел за границы';
  SFixedColTooBig = 'Число фиксированных столбцов должно быть меньше общего числа столбцов';
  SFixedRowTooBig = 'Число фиксированных строк должно быть меньше общего числа строк';
  SInvalidStringGridOp = 'Не могу вставить или удалить строки из таблицы (grid)';
  SParseError = '%s в строке %d';
  SIdentifierExpected = 'Ожидается идентификатор';
  SStringExpected = 'Ожидается строка';
  SNumberExpected = 'Ожидается число';
  SCharExpected = 'Ожидается ''''%s''''';
  SSymbolExpected = 'Ожидается %s';
  SInvalidNumber = 'Неверное числовое значение';
  SInvalidString = 'Неверная строковая константа';
  SInvalidProperty = 'Неверное значение свойства';
  SInvalidBinary = 'Неверное двоичное значение';
  SOutlineIndexError = 'Индекс Outline не найден';
  SOutlineExpandError = 'Родительский узел должен быть раскрыт';
  SInvalidCurrentItem = 'Неверное значение для текущего элемента';
  SMaskErr = 'Введено неверное значение';
  SMaskEditErr = 'Введено неверное значение.  Нажмите Esc для отмены изменений';
  SOutlineError = 'Неверный индекс outline';
  SOutlineBadLevel = 'Неверное определение уровня';
  SOutlineSelection = 'Неверный выбор';
  SOutlineFileLoad = 'Ошибка загрузки файла';
  SOutlineLongLine = 'Строка слишком длинная';
  SOutlineMaxLevels = 'Достигнута максимальная глубина outline';

  SMsgDlgWarning = 'Предупреждение';
  SMsgDlgError = 'Ошибка';
  SMsgDlgInformation = 'Информация';
  SMsgDlgConfirm = 'Подтверждение';
  SMsgDlgYes = '&Да';
  SMsgDlgNo = '&Нет';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Отмена';
  SMsgDlgHelp = '&Справка';
  SMsgDlgHelpNone = 'Справка недоступна';
  SMsgDlgHelpHelp = 'Справка';
  SMsgDlgAbort = 'П&рервать';
  SMsgDlgRetry = '&Повторить';
  SMsgDlgIgnore = 'Про&должить';
  SMsgDlgAll = '&Все';
  SMsgDlgNoToAll = 'Н&ет для всех';
  SMsgDlgYesToAll = 'Д&а для всех';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Неизвестно)';
  srNone = '(Нет)';
  SOutOfRange = 'Значение должно быть между %d и %d';
  SCannotCreateName = 'Не могу создать имя метода по умолчанию для безымянного компонента';

  SDateEncodeError = 'Неверный аргумент для формирования даты';
  STimeEncodeError = 'Неверный аргумент для формирования времени';
  SInvalidDate = '''''%s'''' - неверная дата';
  SInvalidTime = '''''%s'''' - неверное время';
  SInvalidDateTime = '''''%s'''' - неверные дата и время';
  SInvalidFileName = 'Неверное имя файла - %s';
  SDefaultFilter = 'Все файлы (*.*)|*.*';
  sAllFilter = 'Все';
  SNoVolumeLabel = ': [ - нет метки тома - ]';
  SInsertLineError = 'Невозможно вставить строку';

  SConfirmCreateDir = 'Указанная папка не существует. Создать ее?';
  SSelectDirCap = 'Выбор папки';
  SCannotCreateDir = 'Не могу создать папку';
  SDirNameCap = '&Имя папки:';
  SDrivesCap = '&Устройства:';
  SDirsCap = '&Папки:';
  SFilesCap = '&Файлы: (*.*)';
  SNetworkCap = '&Сеть...';

  SColorPrefix = 'Color';
  SColorTags = 'ABCDEFGHIJKLMNOP';

  SInvalidClipFmt = 'Неверный формат буфера обмена';
  SIconToClipboard = 'Буфер обмена не поддерживает иконки';
{$IFNDEF VER100}
  SCannotOpenClipboard = 'Не могу открыть буфер обмена';
{$ENDIF}

  SDefault = 'Default';

  SInvalidMemoSize = 'Текст превысил емкость memo';
  SCustomColors = 'Custom Colors';
  SInvalidPrinterOp = 'Операция не поддерживается на выбранном принтере';
  SNoDefaultPrinter = 'Нет выбранного по умолчанию принтера';

  SIniFileWriteError = 'Не могу записать в %s';

  SBitsIndexError = 'Индекс Bits вышел за границы';

  SUntitled = '(Без имени)';

  SInvalidRegType = 'Неверный тип данных для ''%s''';
  SRegCreateFailed = 'Ошибка создания ключа %s';
  SRegSetDataFailed = 'Ошибка записи значения для ''%s''';
  SRegGetDataFailed = 'Ошибка чтения значения для ''%s''';

  SUnknownConversion = 'Неизвестное расширение файла для конвертирования RichEdit (.%s)';
  SDuplicateMenus = 'Меню ''%s'' уже создано другой формой';

  SPictureLabel = 'Картинка:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Просмотр';

  SCannotOpenAVI = 'Не могу открыть AVI';

  SNotOpenErr = 'Нет открытых устройств MCI';
  SMPOpenFilter = 'Все файлы (*.*)|*.*|Аудио файлы (*.wav)|*.wav|Midi файлы (*.mid)|*.mid|Видео для Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVideo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'DigitalVideo';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Other';
  SMCIOverlay = 'Overlay';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Sequencer';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Videodisc';
  SMCIWaveAudio = 'WaveAudio';
  SMCIUnknownError = 'Неизвестный код ошибки';

  SBoldItalicFont = 'Bold Italic';
  SBoldFont = 'Bold';
  SItalicFont = 'Italic';
  SRegularFont = 'Regular';

  SPropertiesVerb = 'Свойства';

{$IFNDEF VER100}
  sWindowsSocketError = 'Ошибка Windows socket: %s (%d), при вызове ''%s''';
  sAsyncSocketError = 'Ошибка asynchronous socket %d';
  sNoAddress = 'Не определен адрес';
  sCannotListenOnOpen = 'Не могу прослушивать открытый socket';
  sCannotCreateSocket = 'Не могу создать новый socket';
  sSocketAlreadyOpen = 'Socket уже открыт';
  sCantChangeWhileActive = 'Не могу изменить значение пока socket активен';
  sSocketMustBeBlocking = 'Socket должен быть в режиме блокировки';
  sSocketIOError = '%s ошибка %d, %s';
  sSocketRead = 'Read';
  sSocketWrite = 'Write';

  SServiceFailed = 'Сбой служба на %s: %s';
  SExecute = 'execute';
  SStart = 'start';
  SStop = 'stop';
  SPause = 'pause';
  SContinue = 'continue';
  SInterrogate = 'interrogate';
  SShutdown = 'shutdown';
  SCustomError = 'Сбой службы в custom message(%d): %s';
  SServiceInstallOK = 'Служба установлена успешно';
  SServiceInstallFailed = 'Сбой при установке службы "%s", ошибка: "%s"';
  SServiceUninstallOK = 'Служба снята успешно';
  SServiceUninstallFailed = 'Сбой при снятии службы "%s", ошибка: "%s"';

  SInvalidActionRegistration = 'Неверная регистрация действия (action)';
  SInvalidActionUnregistration = 'Неверная отмена регистрации действия (action)';
  SInvalidActionEnumeration = 'Неверный перечень действий (action)';
  SInvalidActionCreation = 'Неверное создание действия (action)';

  SDockedCtlNeedsName = 'Docked элемент должен иметь имя';
  SDockTreeRemoveError = 'Ошибка удаления элемента из dock tree';
  SDockZoneNotFound = ' - Dock zone не найдена';
  SDockZoneHasNoCtl = ' - Dock zone не имеет элементов управления';

  SAllCommands = 'All Commands';
{$ENDIF}

{$IFDEF VER130}
  SDuplicateItem = 'Список не допускает дубликатов ($0%x)';

  SDuplicatePropertyCategory = 'Категория свойства, названная %s, уже создана';
  SUnknownPropertyCategory = 'Категория свойства не найдена (%s)';

  SActionCategoryName = 'Action';
  SActionCategoryDesc = 'Свойства и/или события категории Action';
  SDataCategoryName = 'Data';
  SDataCategoryDesc = 'Свойства и/или события категории Data';
  SDatabaseCategoryName = 'Database';
  SDatabaseCategoryDesc = 'Свойства и/или события категории Database';
  SDragNDropCategoryName = 'Drag, Drop and Docking';
  SDragNDropCategoryDesc = 'Свойства и/или события категории Drag, Drop and Docking';
  SHelpCategoryName = 'Help and Hints';
  SHelpCategoryDesc = 'Свойства и/или события категории Help and Hint';
  SLayoutCategoryName = 'Layout';
  SLayoutCategoryDesc = 'Свойства и/или события категории Layout';
  SLegacyCategoryName = 'Legacy';
  SLegacyCategoryDesc = 'Свойства и/или события категории Legacy';
  SLinkageCategoryName = 'Linkage';
  SLinkageCategoryDesc = 'Свойства и/или события категории Linkage';
  SLocaleCategoryName = 'Locale';
  SLocaleCategoryDesc = 'Свойства и/или события категории Locale';
  SLocalizableCategoryName = 'Localizable';
  SLocalizableCategoryDesc = 'Свойства и/или события категории Localizable';
  SMiscellaneousCategoryName = 'Miscellaneous';
  SMiscellaneousCategoryDesc = 'Свойства и/или события категории Miscellaneous';
  SVisualCategoryName = 'Visual';
  SVisualCategoryDesc = 'Свойства и/или события категории Visual';
  SInputCategoryName = 'Input';
  SInputCategoryDesc = 'Свойства и/или события категории Input';

  SInvalidMask = '''%s'' - неверная маска в позиции %d';
  SInvalidFilter = 'Фильтром свойств может быть только имя, класс или тип по базе (%d:%d)';
  SInvalidCategory = 'Категории должны определять свои имя и описание';

  sOperationNotAllowed = 'Операция не допустима во время отправки событий приложения';
{$ENDIF}
// Delphi 7
  SColorBoxCustomCaption = 'Выбор...'; //'Custom...';
  STextNotFound = 'Текст не найден: "%s"'; //'Text not found: "%s"';
  SFileRunDialogTitle = 'Run';
  SSendError = 'Error sending mail';
  SInvalidEnumValue = 'Invalid Enum Value';
  SErrorDownloadingURL = 'Error downloading URL: %s';
  SUrlMonDllMissing = 'Unable to load %s';
  SMultiSelectRequired = 'Multiselect mode must be on for this feature';
  SSeparator = 'Separator';
  SNoGetItemEventHandler = 'No OnGetItem event handler assigned';
  SErrorSettingCount = 'Error setting %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) style must be virtual in order to set Count';
  SParentGivenNotAParent = 'Parent given is not a parent of ''%s''';

implementation

end.

