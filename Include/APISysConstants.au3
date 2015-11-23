#include-once

; #INDEX# =======================================================================================================================
; Title .........: WinAPISys Constants UDF Library for AutoIt3
; AutoIt Version : 3.3.15.0
; Language ......: English
; Description ...: Constants that can be used with UDF library
; Author(s) .....: Yashied, Jpm
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================

; _WinAPI_ActivateKeyboardLayout(), _WinAPI_LoadKeyboardLayout()
Global Const $KLF_ACTIVATE = 0x00000001
Global Const $KLF_NOTELLSHELL = 0x00000080
Global Const $KLF_REORDER = 0x00000008
Global Const $KLF_REPLACELANG = 0x00000010
Global Const $KLF_RESET = 0x40000000
Global Const $KLF_SETFORPROCESS = 0x00000100
Global Const $KLF_SHIFTLOCK = 0x00010000
Global Const $KLF_SUBSTITUTE_OK = 0x00000002

Global Const $HKL_NEXT = 1
Global Const $HKL_PREV = 0

; _WinAPI_AnimateWindow()
Global Const $AW_ACTIVATE = 0x00020000
Global Const $AW_BLEND = 0x00080000
Global Const $AW_CENTER = 0x00000010
Global Const $AW_HIDE = 0x00010000
Global Const $AW_HOR_NEGATIVE = 0x00000002
Global Const $AW_HOR_POSITIVE = 0x00000001
Global Const $AW_SLIDE = 0x00040000
Global Const $AW_VER_NEGATIVE = 0x00000008
Global Const $AW_VER_POSITIVE = 0x00000004

; _WinAPI_BroadcastSystemMessage()
Global Const $BSF_ALLOWSFW = 0x0080
Global Const $BSF_FLUSHDISK = 0x0004
Global Const $BSF_FORCEIFHUNG = 0x0020
Global Const $BSF_IGNORECURRENTTASK = 0x0002
Global Const $BSF_NOHANG = 0x0008
Global Const $BSF_NOTIMEOUTIFNOTHUNG = 0x0040
Global Const $BSF_POSTMESSAGE = 0x0010
Global Const $BSF_QUERY = 0x0001
Global Const $BSF_SENDNOTIFYMESSAGE = 0x0100

Global Const $BSM_ALLCOMPONENTS = 0x00
Global Const $BSM_ALLDESKTOPS = 0x08
Global Const $BSM_APPLICATIONS = 0x10
Global Const $BSM_INSTALLABLEDRIVERS = 0x04
Global Const $BSM_NETDRIVER = 0x02
Global Const $BSM_VXDS = 0x01

; _WinAPI_CascadeWindows(), _WinAPI_TileWindows()
Global Const $MDITILE_HORIZONTAL = 0x01
Global Const $MDITILE_SKIPDISABLED = 0x02
Global Const $MDITILE_VERTICAL = 0x00
Global Const $MDITILE_ZORDER = 0x04

; _WinAPI_ChangeWindowMessageFilterEx()
Global Const $MSGFLT_ALLOW = 1
Global Const $MSGFLT_DISALLOW = 2
Global Const $MSGFLT_RESET = 0

Global Const $MSGFLTINFO_ALLOWED_HIGHER = 3
Global Const $MSGFLTINFO_ALREADYALLOWED_FORWND = 1
Global Const $MSGFLTINFO_ALREADYDISALLOWED_FORWND = 2
Global Const $MSGFLTINFO_NONE = 0

; _WinAPI_ChildWindowFromPointEx()
Global Const $CWP_ALL = 0x00
Global Const $CWP_SKIPINVISIBLE = 0x01
Global Const $CWP_SKIPDISABLED = 0x02
Global Const $CWP_SKIPTRANSPARENT = 0x04

; _WinAPI_CompressBuffer(), _WinAPI_DecompressBuffer(), _WinAPI_GetCompression(), _WinAPI_SetCompression()
Global Const $COMPRESSION_FORMAT_NONE = 0x0000
Global Const $COMPRESSION_FORMAT_DEFAULT = 0x0001
Global Const $COMPRESSION_FORMAT_LZNT1 = 0x0002
Global Const $COMPRESSION_FORMAT_XPRESS = 0x0003
Global Const $COMPRESSION_FORMAT_XPRESS_HUFF = 0x0004

Global Const $COMPRESSION_ENGINE_STANDARD = 0x0000
Global Const $COMPRESSION_ENGINE_MAXIMUM = 0x0100
Global Const $COMPRESSION_ENGINE_HIBER = 0x0200

; _WinAPI_CreateWindowStation(), _WinAPI_OpenWindowStation()
Global Const $WINSTA_ACCESSCLIPBOARD = 0x0004
Global Const $WINSTA_ACCESSGLOBALATOMS = 0x0020
Global Const $WINSTA_CREATEDESKTOP = 0x0008
Global Const $WINSTA_ENUMDESKTOPS = 0x0001
Global Const $WINSTA_ENUMERATE = 0x0100
Global Const $WINSTA_EXITWINDOWS = 0x0040
Global Const $WINSTA_READATTRIBUTES = 0x0002
Global Const $WINSTA_READSCREEN = 0x0200
Global Const $WINSTA_WRITEATTRIBUTES = 0x0010
Global Const $WINSTA_ALL_ACCESS = BitOR($WINSTA_ACCESSCLIPBOARD, $WINSTA_ACCESSGLOBALATOMS, $WINSTA_CREATEDESKTOP, $WINSTA_ENUMDESKTOPS, $WINSTA_ENUMERATE, $WINSTA_EXITWINDOWS, $WINSTA_READATTRIBUTES, $WINSTA_READSCREEN, $WINSTA_WRITEATTRIBUTES)

Global Const $CWF_CREATE_ONLY = 0x01

; _WinAPI_GetClassLongEx(), _WinAPI_SetClassLongEx()
Global Const $GCL_CBCLSEXTRA = -20
Global Const $GCL_CBWNDEXTRA = -18
Global Const $GCL_HBRBACKGROUND = -10
Global Const $GCL_HCURSOR = -12
Global Const $GCL_HICON = -14
Global Const $GCL_HICONSM = -34
Global Const $GCL_HMODULE = -16
Global Const $GCL_MENUNAME = -8
Global Const $GCL_STYLE = -26
Global Const $GCL_WNDPROC = -24

; _WinAPI_GetCurrentHwProfile()
Global Const $DOCKINFO_DOCKED = 0x02
Global Const $DOCKINFO_UNDOCKED = 0x01
Global Const $DOCKINFO_USER_SUPPLIED = 0x04
Global Const $DOCKINFO_USER_DOCKED = 0x05
Global Const $DOCKINFO_USER_UNDOCKED = 0x06

; _WinAPI_GetGUIThreadInfo()
Global Const $GUI_CARETBLINKING = 0x0001
Global Const $GUI_INMENUMODE = 0x0004
Global Const $GUI_INMOVESIZE = 0x0002
Global Const $GUI_POPUPMENUMODE = 0x0010
Global Const $GUI_SYSTEMMENUMODE = 0x0008

; _WinAPI_GetHandleInformation(), _WinAPI_SetHandleInformation()
Global Const $HANDLE_FLAG_INHERIT = 0x00000001
Global Const $HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002

; _WinAPI_GetModuleHandleEx()
Global Const $GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS = 0x0004
Global Const $GET_MODULE_HANDLE_EX_FLAG_PIN = 0x0001
Global Const $GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT = 0x0002
Global Const $GET_MODULE_HANDLE_EX_FLAG_DEFAULT = 0x0000

; _WinAPI_GetSystemInfo()
Global Const $PROCESSOR_ARCHITECTURE_AMD64 = 9
Global Const $PROCESSOR_ARCHITECTURE_IA64 = 6
Global Const $PROCESSOR_ARCHITECTURE_INTEL = 0
Global Const $PROCESSOR_ARCHITECTURE_UNKNOWN = 0xFFFF

Global Const $PROCESSOR_INTEL_386 = 386
Global Const $PROCESSOR_INTEL_486 = 486
Global Const $PROCESSOR_INTEL_PENTIUM = 586
Global Const $PROCESSOR_INTEL_IA64 = 2200
Global Const $PROCESSOR_AMD_X8664 = 8664

; _WinAPI_GetUserObjectInformation(), _WinAPI_SetUserObjectInformation()
Global Const $UOI_FLAGS = 1
Global Const $UOI_HEAPSIZE = 5
Global Const $UOI_IO = 6
Global Const $UOI_NAME = 2
Global Const $UOI_TYPE = 3
Global Const $UOI_USER_SID = 4

Global Const $DF_ALLOWOTHERACCOUNTHOOK = 0x01
Global Const $WSF_VISIBLE = 0x01

; _WinAPI_GetVersionEx()
Global Const $VER_SUITE_BACKOFFICE = 0x00000004
Global Const $VER_SUITE_BLADE = 0x00000400
Global Const $VER_SUITE_COMPUTE_SERVER = 0x00004000
Global Const $VER_SUITE_DATACENTER = 0x00000080
Global Const $VER_SUITE_ENTERPRISE = 0x00000002
Global Const $VER_SUITE_EMBEDDEDNT = 0x00000040
Global Const $VER_SUITE_PERSONAL = 0x00000200
Global Const $VER_SUITE_SINGLEUSERTS = 0x00000100
Global Const $VER_SUITE_SMALLBUSINESS = 0x00000001
Global Const $VER_SUITE_SMALLBUSINESS_RESTRICTED = 0x00000020
Global Const $VER_SUITE_STORAGE_SERVER = 0x00002000
Global Const $VER_SUITE_TERMINAL = 0x00000010
Global Const $VER_SUITE_WH_SERVER = 0x00008000

Global Const $VER_NT_DOMAIN_CONTROLLER = 0x0000002
Global Const $VER_NT_SERVER = 0x0000003
Global Const $VER_NT_WORKSTATION = 0x0000001

; _WinAPI_GetWindowDisplayAffinity(), _WinAPI_SetWindowDisplayAffinity()
Global Const $WDA_MONITOR = 0x01
Global Const $WDA_NONE = 0x00

; _WinAPI_IsProcessorFeaturePresent()
Global Const $PF_3DNOW_INSTRUCTIONS_AVAILABLE = 7
Global Const $PF_CHANNELS_ENABLED = 16
Global Const $PF_COMPARE_EXCHANGE_DOUBLE = 2
Global Const $PF_COMPARE_EXCHANGE128 = 14
Global Const $PF_COMPARE64_EXCHANGE128 = 15
Global Const $PF_FLOATING_POINT_EMULATED = 1
Global Const $PF_FLOATING_POINT_PRECISION_ERRATA = 0
Global Const $PF_MMX_INSTRUCTIONS_AVAILABLE = 3
Global Const $PF_NX_ENABLED = 12
Global Const $PF_PAE_ENABLED = 9
Global Const $PF_RDTSC_INSTRUCTION_AVAILABLE = 8
Global Const $PF_SSE3_INSTRUCTIONS_AVAILABLE = 13
Global Const $PF_XMMI_INSTRUCTIONS_AVAILABLE = 6
Global Const $PF_XMMI64_INSTRUCTIONS_AVAILABLE = 10
Global Const $PF_XSAVE_ENABLED = 17

; _WinAPI_Keybd_Event()
Global Const $KEYEVENTF_EXTENDEDKEY = 0x01
Global Const $KEYEVENTF_KEYUP = 0x02

; _WinAPI_LoadIconMetric()
Global Const $LIM_SMALL = 0
Global Const $LIM_LARGE = 1

; _WinAPI_MapVirtualKey()
Global Const $MAPVK_VK_TO_CHAR = 2
Global Const $MAPVK_VK_TO_VSC = 0
Global Const $MAPVK_VK_TO_VSC_EX = 4
Global Const $MAPVK_VSC_TO_VK = 1
Global Const $MAPVK_VSC_TO_VK_EX = 3

; _WinAPI_RegisterHotKey()
Global Const $MOD_ALT = 0x0001
Global Const $MOD_CONTROL = 0x0002
Global Const $MOD_NOREPEAT = 0x4000
Global Const $MOD_SHIFT = 0x0004
Global Const $MOD_WIN = 0x0008

; _WinAPI_RegisterPowerSettingNotification()
Global Const $GUID_ACDC_POWER_SOURCE = '{5D3E9A59-E9D5-4B00-A6BD-FF34FF516548}'
Global Const $GUID_BATTERY_PERCENTAGE_REMAINING = '{A7AD8041-B45A-4CAE-87A3-EECBB468A9E1}'
Global Const $GUID_IDLE_BACKGROUND_TASK = '{515C31D8-F734-163D-A0FD-11A08C91E8F1}'
Global Const $GUID_MONITOR_POWER_ON = '{02731015-4510-4526-99E6-E5A17EBD1AEA}'
Global Const $GUID_POWERSCHEME_PERSONALITY = '{245D8541-3943-4422-B025-13A784F679B7}'
Global Const $GUID_SYSTEM_AWAYMODE = '{98A7F580-01F7-48AA-9C0F-44352C29E5C0}'

Global Const $GUID_MIN_POWER_SAVINGS = '{8C5E7FDA-E8BF-4A96-9A85-A6E23A8C635C}'
Global Const $GUID_MAX_POWER_SAVINGS = '{A1841308-3541-4FAB-BC81-F71556F20B4A}'
Global Const $GUID_TYPICAL_POWER_SAVINGS = '{381B4222-F694-41F0-9685-FF5BB260DF2E}'

; _WinAPI_RegisterShellHookWindow()
Global Const $HSHELL_WINDOWCREATED = 1
Global Const $HSHELL_WINDOWDESTROYED = 2
Global Const $HSHELL_ACTIVATESHELLWINDOW = 3
Global Const $HSHELL_WINDOWACTIVATED = 4
Global Const $HSHELL_GETMINRECT = 5
Global Const $HSHELL_REDRAW = 6
Global Const $HSHELL_TASKMAN = 7
Global Const $HSHELL_LANGUAGE = 8
Global Const $HSHELL_SYSMENU = 9
Global Const $HSHELL_ENDTASK = 10
Global Const $HSHELL_ACCESSIBILITYSTATE = 11
Global Const $HSHELL_APPCOMMAND = 12
Global Const $HSHELL_WINDOWREPLACED = 13
Global Const $HSHELL_WINDOWREPLACING = 14
Global Const $HSHELL_RUDEAPPACTIVATED = 32772
Global Const $HSHELL_FLASH = 32774

; _WinAPI_SendMessageTimeout()
Global Const $HWND_BROADCAST = 0xFFFF

Global Const $SMTO_BLOCK = 0x0001
Global Const $SMTO_NORMAL = 0x0000
Global Const $SMTO_ABORTIFHUNG = 0x0002
Global Const $SMTO_NOTIMEOUTIFNOTHUNG = 0x0008
Global Const $SMTO_ERRORONEXIT = 0x0020

; _WinAPI_SetKeyboardLayout()
Global Const $INPUTLANGCHANGE_BACKWARD = 0x0004
Global Const $INPUTLANGCHANGE_FORWARD = 0x0002
Global Const $INPUTLANGCHANGE_SYSCHARSET = 0x0001

; _WinAPI_SetWinEventHook()
Global Const $EVENT_MIN = 0x00000001
Global Const $EVENT_SYSTEM_SOUND = 0x00000001
Global Const $EVENT_SYSTEM_ALERT = 0x00000002
Global Const $EVENT_SYSTEM_FOREGROUND = 0x00000003
Global Const $EVENT_SYSTEM_MENUSTART = 0x00000004
Global Const $EVENT_SYSTEM_MENUEND = 0x00000005
Global Const $EVENT_SYSTEM_MENUPOPUPSTART = 0x00000006
Global Const $EVENT_SYSTEM_MENUPOPUPEND = 0x00000007
Global Const $EVENT_SYSTEM_CAPTURESTART = 0x00000008
Global Const $EVENT_SYSTEM_CAPTUREEND = 0x00000009
Global Const $EVENT_SYSTEM_MOVESIZESTART = 0x0000000A
Global Const $EVENT_SYSTEM_MOVESIZEEND = 0x0000000B
Global Const $EVENT_SYSTEM_CONTEXTHELPSTART = 0x0000000C
Global Const $EVENT_SYSTEM_CONTEXTHELPEND = 0x0000000D
Global Const $EVENT_SYSTEM_DRAGDROPSTART = 0x0000000E
Global Const $EVENT_SYSTEM_DRAGDROPEND = 0x0000000F
Global Const $EVENT_SYSTEM_DIALOGSTART = 0x00000010
Global Const $EVENT_SYSTEM_DIALOGEND = 0x00000011
Global Const $EVENT_SYSTEM_SCROLLINGSTART = 0x00000012
Global Const $EVENT_SYSTEM_SCROLLINGEND = 0x00000013
Global Const $EVENT_SYSTEM_SWITCHSTART = 0x00000014
Global Const $EVENT_SYSTEM_SWITCHEND = 0x00000015
Global Const $EVENT_SYSTEM_MINIMIZESTART = 0x00000016
Global Const $EVENT_SYSTEM_MINIMIZEEND = 0x00000017
Global Const $EVENT_SYSTEM_DESKTOPSWITCH = 0x00000020
Global Const $EVENT_OBJECT_CREATE = 0x00008000
Global Const $EVENT_OBJECT_DESTROY = 0x00008001
Global Const $EVENT_OBJECT_SHOW = 0x00008002
Global Const $EVENT_OBJECT_HIDE = 0x00008003
Global Const $EVENT_OBJECT_REORDER = 0x00008004
Global Const $EVENT_OBJECT_FOCUS = 0x00008005
Global Const $EVENT_OBJECT_SELECTION = 0x00008006
Global Const $EVENT_OBJECT_SELECTIONADD = 0x00008007
Global Const $EVENT_OBJECT_SELECTIONREMOVE = 0x00008008
Global Const $EVENT_OBJECT_SELECTIONWITHIN = 0x00008009
Global Const $EVENT_OBJECT_STATECHANGE = 0x0000800A
Global Const $EVENT_OBJECT_LOCATIONCHANGE = 0x0000800B
Global Const $EVENT_OBJECT_NAMECHANGE = 0x0000800C
Global Const $EVENT_OBJECT_DESCRIPTIONCHANGE = 0x0000800D
Global Const $EVENT_OBJECT_VALUECHANGE = 0x0000800E
Global Const $EVENT_OBJECT_PARENTCHANGE = 0x0000800F
Global Const $EVENT_OBJECT_HELPCHANGE = 0x00008010
Global Const $EVENT_OBJECT_DEFACTIONCHANGE = 0x00008011
Global Const $EVENT_OBJECT_ACCELERATORCHANGE = 0x00008012
Global Const $EVENT_OBJECT_INVOKED = 0x00008013
Global Const $EVENT_OBJECT_TEXTSELECTIONCHANGED = 0x00008014
Global Const $EVENT_OBJECT_CONTENTSCROLLED = 0x00008015
Global Const $EVENT_MAX = 0x7FFFFFFF

Global Const $WINEVENT_INCONTEXT = 0x04
Global Const $WINEVENT_OUTOFCONTEXT = 0x00
Global Const $WINEVENT_SKIPOWNPROCESS = 0x02
Global Const $WINEVENT_SKIPOWNTHREAD = 0x01

; _WinAPI_TrackMouseEvent()
Global Const $TME_CANCEL = 0x80000000
Global Const $TME_HOVER = 0x00000001
Global Const $TME_LEAVE = 0x00000002
Global Const $TME_NONCLIENT = 0x00000010
Global Const $TME_QUERY = 0x40000000

; _WinAPI_*Desktop*()
Global Const $DESKTOP_CREATEMENU = 0x0004
Global Const $DESKTOP_CREATEWINDOW = 0x0002
Global Const $DESKTOP_ENUMERATE = 0x0040
Global Const $DESKTOP_HOOKCONTROL = 0x0008
Global Const $DESKTOP_JOURNALPLAYBACK = 0x0020
Global Const $DESKTOP_JOURNALRECORD = 0x0010
Global Const $DESKTOP_READOBJECTS = 0x0001
Global Const $DESKTOP_SWITCHDESKTOP = 0x0100
Global Const $DESKTOP_WRITEOBJECTS = 0x0080
Global Const $DESKTOP_ALL_ACCESS = BitOR($DESKTOP_CREATEMENU, $DESKTOP_CREATEWINDOW, $DESKTOP_ENUMERATE, $DESKTOP_HOOKCONTROL, $DESKTOP_JOURNALPLAYBACK, $DESKTOP_JOURNALRECORD, $DESKTOP_READOBJECTS, $DESKTOP_SWITCHDESKTOP, $DESKTOP_WRITEOBJECTS)

; _WinAPI_*RowInput*()
Global Const $RIDEV_APPKEYS = 0x00000400
Global Const $RIDEV_CAPTUREMOUSE = 0x00000200
Global Const $RIDEV_DEVNOTIFY = 0x00002000
Global Const $RIDEV_EXCLUDE = 0x00000010
Global Const $RIDEV_EXINPUTSINK = 0x00001000
Global Const $RIDEV_INPUTSINK = 0x00000100
Global Const $RIDEV_NOHOTKEYS = 0x00000200
Global Const $RIDEV_NOLEGACY = 0x00000030
Global Const $RIDEV_PAGEONLY = 0x00000020
Global Const $RIDEV_REMOVE = 0x00000001

Global Const $RID_HEADER = 0x10000005
Global Const $RID_INPUT = 0x10000003

Global Const $RIM_TYPEHID = 2
Global Const $RIM_TYPEKEYBOARD = 1
Global Const $RIM_TYPEMOUSE = 0

Global Const $RIDI_DEVICENAME = 0x20000007
Global Const $RIDI_DEVICEINFO = 0x2000000B
Global Const $RIDI_PREPARSEDDATA = 0x20000005

Global Const $MOUSE_ATTRIBUTES_CHANGED = 0x04
Global Const $MOUSE_MOVE_ABSOLUTE = 0x01
Global Const $MOUSE_MOVE_RELATIVE = 0x00
Global Const $MOUSE_VIRTUAL_DESKTOP = 0x02

Global Const $RI_MOUSE_LEFT_BUTTON_DOWN = 0x0001
Global Const $RI_MOUSE_LEFT_BUTTON_UP = 0x0002
Global Const $RI_MOUSE_MIDDLE_BUTTON_DOWN = 0x0010
Global Const $RI_MOUSE_MIDDLE_BUTTON_UP = 0x0020
Global Const $RI_MOUSE_RIGHT_BUTTON_DOWN = 0x0004
Global Const $RI_MOUSE_RIGHT_BUTTON_UP = 0x0008
Global Const $RI_MOUSE_BUTTON_1_DOWN = $RI_MOUSE_LEFT_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_1_UP = $RI_MOUSE_LEFT_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_2_DOWN = $RI_MOUSE_RIGHT_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_2_UP = $RI_MOUSE_RIGHT_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_3_DOWN = $RI_MOUSE_MIDDLE_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_3_UP = $RI_MOUSE_MIDDLE_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_4_DOWN = 0x0040
Global Const $RI_MOUSE_BUTTON_4_UP = 0x0080
Global Const $RI_MOUSE_BUTTON_5_DOWN = 0x0100
Global Const $RI_MOUSE_BUTTON_5_UP = 0x0200
Global Const $RI_MOUSE_WHEEL = 0x0400

Global Const $RI_KEY_BREAK = 1
Global Const $RI_KEY_E0 = 2
Global Const $RI_KEY_E1 = 4
Global Const $RI_KEY_MAKE = 0
; ===============================================================================================================================
