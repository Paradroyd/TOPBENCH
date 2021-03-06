{$O+,F+}
Unit DetectBios;
{ In dieser Unit steht praktisch nur ein Record, der die Bios-Data-Area
  beschreibt. 歜er einen Pointer zur BIOS-DATA-AREA kann er dann angesprochen
  werden.
 }

Interface

Type pBiosRecord = ^tBiosRecord;
     tBiosRecord = Record
        Com            : ARRAY [1..4] OF Word; { Die Com-Port Adressen }
        Lpt            : ARRAY [1..4] OF Word; { Die LPT-Port Adressen }
        Equipment      : Word; { 񽼖񽔼񼭢񼆈� 40:10 (Wert wird auch mit INT 11 Register AL zur乧kgegeben)
                                  � � � � � � � 滥� IPL diskette installiert
                                  � � � � � � 滥哪� Koprozessor
                                  � � � � 媚拍哪哪� (Altes PC System) OnBoard RAM < 256K
                                  � � � � � 滥哪哪� "Zeiger-Device" installiert (PS/2)
                                  � � � � 滥哪哪哪� reserviert
                                  � � 滥聊哪哪哪哪� Startvideomodus
                                  滥聊哪哪哪哪哪哪� Wieviele Diskettenlaufwerke ?
                                 񽼖񽔼񼭢񼆈� 40:11  (Wert wird auch mit INT 11 Register AL zur乧kgegeben)
                                  � � � � � � � 滥� 0 wenn DMA installiert
                                  � � � � 滥聊聊哪� Anzahl der seriellen Schnittstellen
                                  � � � 滥哪哪哪哪� Gameport ja/nein
                                  � � 滥哪哪哪哪哪� nicht benutzt, internes modem auf dem PS/2
                                  滥聊哪哪哪哪哪哪� Anzahl der parallelen Ports }
        PCjr_ErrorCNT  : Byte;
        MemorySize     : Word;
        Reserved1      : Byte;
        PS2BiosFlag    : Byte;
        KeyboardFlag   : ARRAY [1..2] OF Byte;
                               { 񽼖񽔼񼭢񼆈� keyboard flag byte 1
                                  � � � � � � � 滥� rechte Shift-Taste gedr乧kt
                                  � � � � � � 滥哪� linke Shift-Taste gedr乧kt
                                  � � � � � 滥哪哪� CTRL-Taste gedr乧kt
                                  � � � � 滥哪哪哪� ALT-Taste gedr乧kt
                                  � � � 滥哪哪哪哪� Scroll-lock ist aktiv
                                  � � 滥哪哪哪哪哪� Num-lock ist aktiv
                                  � 滥哪哪哪哪哪哪� Caps-Lock ist aktiv
                                  滥哪哪哪哪哪哪哪� Insert ist aktiv
                                 񽼖񽔼񼭢񼆈� keyboard flag byte
                                  � � � � � � � 滥� Linke CTRL-Taste gedr乧kt
                                  � � � � � � 滥哪� Linke ALT-Taste gedr乧kt
                                  � � � � � 滥哪哪� System-Taste gedr乧kt und gehalten
                                  � � � � 滥哪哪哪� Pause-Taste ist umgestellt
                                  � � � 滥哪哪哪哪� Scroll Lock-Taste gedr乧kt
                                  � � 滥哪哪哪哪哪� Num-lock-Taste gedr乧kt
                                  � 滥哪哪哪哪哪哪� Caps-lock-Taste gedr乧kt
                                  滥哪哪哪哪哪哪哪� Insert-Taste gedr乧kt }
        AlternatePad   : Byte;
        KeybufHead     : Word;
        KeybufTail     : Word;
        Keybuf         : ARRAY [1..32] OF Byte;
        SeekState      : Byte; { 񽼖񽔼񼭢񼆈� Laufwerkrekalibrationsstatus
                                  � � � � � � � 滥� 1=Rekalibration von Laufwerk 0
                                  � � � � � � 滥哪� 1=Rekalibration von Laufwerk 1
                                  � � � � � 滥哪哪� 1=Rekalibration von Laufwerk 2
                                  � � � � 滥哪哪哪� 1=Rekalibration von Laufwerk 3
                                  � 滥聊聊哪哪哪哪� unbenutzt
                                  滥哪哪哪哪哪哪哪� 1=Wird gerade ein LW benutzt ? }
        DiskState      : Byte; { 񽼖񽔼񼭢񼆈� diskette motor status
                                  � � � � � � � 滥� 1=drive 0 motor on
                                  � � � � � � 滥哪� 1=drive 1 motor on
                                  � � � � � 滥哪哪� 1=drive 2 motor on
                                  � � � � 滥哪哪哪� 1=drive 3 motor on
                                  � 滥聊聊哪哪哪哪� unused
                                  滥哪哪哪哪哪哪哪� 1=write operation }
        MotorTimeout   : Byte;
        DiskOpState    : Byte; { 񽼖񽔼񼭢񼆈� status of last diskette operation
                                  � � � � � � � 滥� invalid diskette command
                                  � � � � � � 滥哪� diskette address mark not found
                                  � � � � � 滥哪哪� sector not found
                                  � � � � 滥哪哪哪� diskette DMA error
                                  � � � 滥哪哪哪哪� CRC check / data error
                                  � � 滥哪哪哪哪哪� diskette controller failure
                                  � 滥哪哪哪哪哪哪� seek to track failed
                                  滥哪哪哪哪哪哪哪� diskette time-out    }
        NECController  : ARRAY [1..7] OF Byte;
        VideoMode      : Byte;
        Columns        : Word;
        ScreenBufSize  : Word;
        ScreenPageOfs  : Word;
        Cursorpos      : ARRAY [0..7] OF Word;
        LowScan,UpScan : Byte;
        ScreenPage     : Byte;
        CRTBase        : Word;
        CRTMode        : Byte;
        Palettemask    : Byte;
        Dummy1         : ARRAY [1..5] OF Byte;
                               { Fuer verschiedene Dinge benutzt }
        Timer          : ARRAY [1..2] OF Word;
        MidnightFlag   : Byte;
        BiosBreak      : Byte;  { Bit 7 set, when CTRL-Break *ever* hit }
        SoftReset      : Word;  { 0000 Kaltstart            }
                                { 1234
                                  1200
                                  EDCB Warmstart            }
                                { 4321 Speicher vorbereiten }
                                { 5678 System Suspend       }
                                { 9ABC Hersteller-Test      }
                                { ABCD Conv. Post-Loop      }
                                {   64 BurnIn - Modus       }
        FixedState     : Byte;  {   00 no error
                                    01 bad command passed to driver
                                    02 address mark not found or bad sector
                                    03 diskette write protect error
                                    04 sector not found
                                    05 fixed disk reset failed
                                    06 diskette changed or removed
                                    07 bad fixed disk parameter table
                                    08 DMA overrun
                                    09 DMA access across 64k boundary
                                    0A bad fixed disk sector flag
                                    0B bad fixed disk cylinder
                                    0C unsupported track/invalid media
                                    0D invalid number of sectors on fixed disk format
                                    0E fixed disk controlled data address mark detected
                                    0F fixed disk DMA arbitration level out of range
                                    10 ECC/CRC error on disk read
                                    11 recoverable fixed disk data error, data fixed by ECC
                                    20 controller error (NEC for floppies)
                                    40 seek failure
                                    80 time out, drive not ready
                                    AA fixed disk drive not ready
                                    BB fixed disk undefined error
                                    CC fixed disk write fault on selected drive
                                    E0 fixed disk status error/Error reg = 0
                                    FF sense operation failed }
        NumberFixed    : Byte;
        XTFixedControl : Byte;
        FixedAdapter   : Byte;
        LPTTimeout     : ARRAY [1..4] OF Byte;
        COMTimeout     : ARRAY [1..4] OF Byte;
        KeyBufbegin    : Word; { BIOS 10-27-82 }
        KeyBufend      : Word;
        Rows           : Byte;
        CharHeight     : Word; { EGA+,
	                 Byte    PCjr: character to be repeated if the typematic
			         repeat key takes effect
                         Byte    PCjr: initial delay before repeat key action begins }
        VideoOptions   : Byte; { EGA+, PCjr: current Fn function key number
		                 񽼖񽔼񼭢񼆈� Video mode options (EGA+)
                                  � � � � � � � 滥� 1=alphanumeric cursor emulation enabled
                                  � � � � � � 滥哪� 1=video subsystem attached to monochrome
                                  � � � � � 滥哪哪� reserved
                                  � � � � 滥哪哪哪� 1=video subsystem is inactive
                                  � � � 滥哪哪哪哪� reserved
                                  � 滥聊哪哪哪哪哪� video RAM  00-64K  10-192K  01-128K  11-256K
                                  滥哪哪哪哪哪哪哪� video mode number passed to INT 10, function 0 }
        EGASwitches    : Byte; { EGA+, PCjr: third keyboard status byte
                                 񽼖񽔼񼭢񼆈� EGA feature bit switches (EGA+)
                                  � � � � � � � 滥� EGA SW1 config (1=off)
                                  � � � � � � 滥哪� EGA SW2 config (1=off)
                                  � � � � � 滥哪哪� EGA SW3 config (1=off)
                                  � � � � 滥哪哪哪� EGA SW4 config (1=off)
                                  � � � 滥哪哪哪哪� Input FEAT0 (ISR0 bit 5) after output on FCR0
                                  � � 滥哪哪哪哪哪� Input FEAT0 (ISR0 bit 6) after output on FCR0
                                  � 滥哪哪哪哪哪哪� Input FEAT1 (ISR0 bit 5) after output on FCR1
                                  滥哪哪哪哪哪哪哪� Input FEAT1 (ISR0 bit 6) after output on FCR1 }
        VideoDataArea  : Byte; { MCGA and VGA
                                 񽼖񽔼񼭢񼆈� Video display data area (MCGA and VGA)
                                  � � � � � � � 滥� 1=VGA is active
                                  � � � � � � 滥哪� 1=gray scale is enabled
                                  � � � � � 滥哪哪� 1=using monochrome monitor
                                  � � � � 滥哪哪哪� 1=default palette loading is disabled
                                  � � � 滥哪哪哪哪� see table below
                                  � � 滥哪哪哪哪哪� reserved
                                  � 滥哪哪哪哪哪哪�  1=display switching enabled
                                  滥哪哪哪哪哪哪哪� alphanumeric scan lines (see table below)

                                  Bit7    Bit4    Scan Lines
                                   0       0      350 line mode
                                   0       1      400 line mode
                                   1       0      200 line mode
                                   1       1      reserved     }
        EGADCC_Index   : Byte; { Display Combination Code (DCC) table index (EGA+) }
        DiskDataRate   : Byte; { 񽼖񽔼񼭢񼆈� last diskette data rate selected
                                  � � � � 滥聊聊聊� reserved
                                  � � 滥聊哪哪哪哪� last floppy drive step rate selected
                                  滥聊哪哪哪哪哪哪� last floppy data rate selected

                                  Data Rate      Step Rate
                                  00  500K bps   00  step rate time of 0C
                                  01  300K bps   01  step rate time of 0D
                                  10  250K bps   10  step rate time of 0A
                                  11  reserved   11  reserved }
        HDCtrlState    : Byte;
        HDCtrlError    : Byte;
        HDIntFlag      : Byte; { bit 7 set }
        HD_FD_Combicard: Byte; { bit 0 set }
        DriveMediaState: ARRAY [0..3] OF Byte;
                               { 񽼖񽔼񼭢񼆈� drive media state (4 copies)
                                  � � � � � 滥聊聊� drive/media state (see below)
                                  � � � � 滥哪哪哪� reserved
                                  � � � 滥哪哪哪哪� 1=media/drive established
                                  � � 滥哪哪哪哪哪� double stepping required
                                  滥聊哪哪哪哪哪哪� data rate:	00=500K bps    01=300K bps
                                                                10=250K bps    11=reserved
                                 Bits
                                 210  Drive Media State
                                 000  360Kb diskette/360Kb drive not established
                                 001  360Kb diskette/1.2Mb drive not established
                                 010  1.2Mb diskette/1.2Mb drive not established
                                 011  360Kb diskette/360Kb drive established
                                 100  360Kb diskette/1.2Mb drive established
                                 101  1.2Mb diskette/1.2Mb drive established
                                 110  Reserved
                                 111  None of the above }
        Drive0Track    : Byte;
        Drive1Track    : Byte;
        KeyboardMode   : Byte; { 񽼖񽔼񼭢񼆈� Keyboard mode/type
                                  � � � � � � � 滥哪 last code was the E1 hidden code
                                  � � � � � � 滥哪哪 last code was the E0 hidden code
                                  � � � � � 滥哪哪哪 right CTRL key depressed
                                  � � � � 滥哪哪哪哪 right ALT key depressed
                                  � � � 滥哪哪哪哪哪 101/102 enhanced keyboard installed
                                  � � 滥哪哪哪哪哪哪 force num-lock if Rd ID & KBX
                                  � 滥哪哪哪哪哪哪哪 last char was first ID char
                                  滥哪哪哪哪哪哪哪哪 read ID in process }
        KeyboardLeds   : Byte; { 񽼖񽔼񼭢񼆈� Keyboard LED flags
                                  � � � � � � � 滥� scroll lock indicator
                                  � � � � � � 滥哪� num-lock indicator
                                  � � � � � 滥哪哪� caps-lock indicator
                                  � � � � 滥哪哪哪� circus system indicator
                                  � � � 滥哪哪哪哪� ACK received
                                  � � 滥哪哪哪哪哪� re-send received flag
                                  � 滥哪哪哪哪哪哪� mode indicator update
                                  滥哪哪哪哪哪哪哪� keyboard transmit error flag }
        UserWaitFlag  : Pointer;
        UserWaitTOut  : LongInt; { unsigned ! in microseconds }
        RTCWaitFlag   : Byte; { 񽼖񽔼񼭢񼆈� RTC wait function flag
                                 � � � � � � � 滥哪 1= wait pending
                                 � 滥聊聊聊聊聊哪哪 not used
                                 滥哪哪哪哪哪哪哪哪 1=INT 15,86 wait time elapsed }
        LANA_DMAFlags : Byte;
        LANA_States   : ARRAY [0..1] OF BYTE;
        HDIntVector   : Pointer;
        VideoTable    : Pointer;
        Reserved      : ARRAY [1..8] OF Byte;
        KBD_NMIFlags  : Byte;
        KBD_BreakFlags: ARRAY [1..2] OF Word;
        Port60Queue   : Byte;
        LastScancode  : Byte;
        NMI_BufHead   : Byte;
        NMI_BufTail   : Byte;
        NMI_Buffer    : ARRAY [1..16] OF Byte;
        Dummy2        : Byte;
        DayCounter    : Word;
     End;



Function GetBiosRecord : pBiosRecord;

Implementation


Function GetBiosRecord;
Begin
  GetBiosRecord := Ptr ($0040,$0000);
End;

End.