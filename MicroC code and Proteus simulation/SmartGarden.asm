
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L_interrupt0
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      46
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt81
	MOVLW      224
	SUBWF      _counter+0, 0
L__interrupt81:
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt1
	CLRF       _counter+0
	CLRF       _counter+1
	MOVLW      1
	MOVWF      _flag+0
	MOVLW      0
	MOVWF      _flag+1
L_interrupt1:
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
	MOVLW      63
	MOVWF      TMR0+0
L_interrupt0:
L_end_interrupt:
L__interrupt80:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_CopyConst2Ram:

	MOVF       FARG_CopyConst2Ram_dest+0, 0
	MOVWF      R3+0
L_CopyConst2Ram2:
	MOVF       FARG_CopyConst2Ram_dest+0, 0
	MOVWF      R2+0
	INCF       FARG_CopyConst2Ram_dest+0, 1
	MOVF       FARG_CopyConst2Ram_src+0, 0
	MOVWF      R0+0
	MOVF       FARG_CopyConst2Ram_src+1, 0
	MOVWF      R0+1
	INCF       FARG_CopyConst2Ram_src+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_CopyConst2Ram_src+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_CopyConst2Ram3
	GOTO       L_CopyConst2Ram2
L_CopyConst2Ram3:
	MOVF       R3+0, 0
	MOVWF      R0+0
L_end_CopyConst2Ram:
	RETURN
; end of _CopyConst2Ram

_Start_Signal:

	BCF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_Start_Signal5:
	DECFSZ     R13+0, 1
	GOTO       L_Start_Signal5
	DECFSZ     R12+0, 1
	GOTO       L_Start_Signal5
	NOP
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
	MOVLW      16
	MOVWF      R13+0
L_Start_Signal6:
	DECFSZ     R13+0, 1
	GOTO       L_Start_Signal6
	NOP
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
L_end_Start_Signal:
	RETURN
; end of _Start_Signal

_Check_Response:

	CLRF       TMR1H+0
	CLRF       TMR1L+0
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
L_Check_Response7:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_Check_Response8
	MOVLW      100
	SUBWF      TMR1L+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response8
L__Check_Response75:
	GOTO       L_Check_Response7
L_Check_Response8:
	MOVF       TMR1L+0, 0
	SUBLW      99
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response11
	CLRF       R0+0
	GOTO       L_end_Check_Response
L_Check_Response11:
	CLRF       TMR1H+0
	CLRF       TMR1L+0
L_Check_Response13:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_Check_Response14
	MOVLW      100
	SUBWF      TMR1L+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response14
L__Check_Response74:
	GOTO       L_Check_Response13
L_Check_Response14:
	MOVF       TMR1L+0, 0
	SUBLW      99
	BTFSC      STATUS+0, 0
	GOTO       L_Check_Response17
	CLRF       R0+0
	GOTO       L_end_Check_Response
L_Check_Response17:
	MOVLW      1
	MOVWF      R0+0
L_end_Check_Response:
	RETURN
; end of _Check_Response

_Read_Data:

	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	CLRF       INDF+0
	CLRF       R2+0
L_Read_Data19:
	MOVLW      128
	XORWF      R2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data20
	CLRF       TMR1H+0
	CLRF       TMR1L+0
L_Read_Data22:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_Read_Data23
	MOVF       TMR1L+0, 0
	SUBLW      100
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data24
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_Read_Data
L_Read_Data24:
	GOTO       L_Read_Data22
L_Read_Data23:
	CLRF       TMR1H+0
	CLRF       TMR1L+0
L_Read_Data25:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_Read_Data26
	MOVF       TMR1L+0, 0
	SUBLW      100
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data27
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_Read_Data
L_Read_Data27:
	GOTO       L_Read_Data25
L_Read_Data26:
	MOVF       TMR1L+0, 0
	SUBLW      50
	BTFSC      STATUS+0, 0
	GOTO       L_Read_Data28
	MOVF       R2+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Read_Data86:
	BTFSC      STATUS+0, 2
	GOTO       L__Read_Data87
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Read_Data86
L__Read_Data87:
	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	IORWF      R0+0, 1
	MOVF       FARG_Read_Data_dht_data+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_Read_Data28:
	INCF       R2+0, 1
	GOTO       L_Read_Data19
L_Read_Data20:
	CLRF       R0+0
L_end_Read_Data:
	RETURN
; end of _Read_Data

_readDataFromDHT22:

	CALL       _Start_Signal+0
	CALL       _Check_Response+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readDataFromDHT2229
	MOVLW      _RH_byte1+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2276
	MOVLW      _RH_byte2+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2276
	MOVLW      _T_byte1+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2276
	MOVLW      _T_byte2+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2276
	MOVLW      _CheckSum+0
	MOVWF      FARG_Read_Data_dht_data+0
	CALL       _Read_Data+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2276
	GOTO       L_readDataFromDHT2232
L__readDataFromDHT2276:
	GOTO       L_readDataFromDHT2233
L_readDataFromDHT2232:
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVLW      0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__readDataFromDHT2289
	MOVF       R2+0, 0
	XORWF      _CheckSum+0, 0
L__readDataFromDHT2289:
	BTFSS      STATUS+0, 2
	GOTO       L_readDataFromDHT2234
	MOVLW      10
	MOVWF      R4+0
	MOVF       _T_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _temp+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _T_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _temp+1
	MOVLW      10
	MOVWF      R4+0
	MOVF       _T_byte2+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _temp+3
	MOVLW      10
	MOVWF      R4+0
	MOVF       _RH_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _humidity+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _RH_byte1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _humidity+1
	MOVLW      10
	MOVWF      R4+0
	MOVF       _RH_byte2+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _humidity+3
	GOTO       L_readDataFromDHT2235
L_readDataFromDHT2234:
L_readDataFromDHT2235:
L_readDataFromDHT2233:
	GOTO       L_readDataFromDHT2236
L_readDataFromDHT2229:
L_readDataFromDHT2236:
	BCF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_readDataFromDHT2237:
	DECFSZ     R13+0, 1
	GOTO       L_readDataFromDHT2237
	DECFSZ     R12+0, 1
	GOTO       L_readDataFromDHT2237
	DECFSZ     R11+0, 1
	GOTO       L_readDataFromDHT2237
	NOP
	NOP
L_end_readDataFromDHT22:
	RETURN
; end of _readDataFromDHT22

_sendData:

	CLRF       _i+0
	CLRF       _i+1
L_sendData38:
	MOVF       _i+0, 0
	ADDWF      FARG_sendData_text+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_sendData39
	BTFSS      TRMT_bit+0, BitPos(TRMT_bit+0)
	GOTO       L_sendData41
	MOVF       _i+0, 0
	ADDWF      FARG_sendData_text+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
L_sendData41:
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_sendData42:
	DECFSZ     R13+0, 1
	GOTO       L_sendData42
	DECFSZ     R12+0, 1
	GOTO       L_sendData42
	NOP
	GOTO       L_sendData38
L_sendData39:
L_end_sendData:
	RETURN
; end of _sendData

_intToString:

	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_intToString_broj+0, 0
	MOVWF      R0+0
	MOVF       FARG_intToString_broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__intToString92
	MOVLW      0
	XORWF      R0+0, 0
L__intToString92:
	BTFSC      STATUS+0, 2
	GOTO       L_intToString43
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_intToString_broj+0, 0
	MOVWF      R0+0
	MOVF       FARG_intToString_broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FARG_intToString_buffer+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_intToString44
L_intToString43:
	MOVF       FARG_intToString_buffer+0, 0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
L_intToString44:
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_intToString_broj+0, 0
	MOVWF      R0+0
	MOVF       FARG_intToString_broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__intToString93
	MOVLW      0
	XORWF      R0+0, 0
L__intToString93:
	BTFSC      STATUS+0, 2
	GOTO       L_intToString45
	INCF       FARG_intToString_buffer+0, 0
	MOVWF      FLOC__intToString+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_intToString_broj+0, 0
	MOVWF      R0+0
	MOVF       FARG_intToString_broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__intToString+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_intToString46
L_intToString45:
	INCF       FARG_intToString_buffer+0, 0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
L_intToString46:
	MOVLW      2
	ADDWF      FARG_intToString_buffer+0, 0
	MOVWF      FLOC__intToString+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_intToString_broj+0, 0
	MOVWF      R0+0
	MOVF       FARG_intToString_broj+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__intToString+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_end_intToString:
	RETURN
; end of _intToString

_initUSART:

	BSF        TXEN_bit+0, BitPos(TXEN_bit+0)
	BSF        SPEN_bit+0, BitPos(SPEN_bit+0)
	BCF        SYNC_bit+0, BitPos(SYNC_bit+0)
	BCF        BRG16_bit+0, BitPos(BRG16_bit+0)
	BSF        BRGH_bit+0, BitPos(BRGH_bit+0)
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
	BSF        RCIE_bit+0, BitPos(RCIE_bit+0)
L_end_initUSART:
	RETURN
; end of _initUSART

_initLDR:

	CLRF       ADRESH+0
	CLRF       ADRESL+0
	BCF        CHS1_bit+0, BitPos(CHS1_bit+0)
	BSF        CHS0_bit+0, BitPos(CHS0_bit+0)
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_initLDR47:
	DECFSZ     R13+0, 1
	GOTO       L_initLDR47
	DECFSZ     R12+0, 1
	GOTO       L_initLDR47
	DECFSZ     R11+0, 1
	GOTO       L_initLDR47
	NOP
	NOP
L_end_initLDR:
	RETURN
; end of _initLDR

_readDataFromLDR:

	BTFSC      ADCON0+0, 1
	GOTO       L_readDataFromLDR48
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _analogna_velicina+0
	MOVF       R0+1, 0
	MOVWF      _analogna_velicina+1
	MOVF       R0+0, 0
	MOVWF      FARG_intToString_broj+0
	MOVF       R0+1, 0
	MOVWF      FARG_intToString_broj+1
	MOVLW      _buffer_l+0
	MOVWF      FARG_intToString_buffer+0
	CALL       _intToString+0
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_readDataFromLDR49:
	DECFSZ     R13+0, 1
	GOTO       L_readDataFromLDR49
	DECFSZ     R12+0, 1
	GOTO       L_readDataFromLDR49
	NOP
L_readDataFromLDR48:
L_end_readDataFromLDR:
	RETURN
; end of _readDataFromLDR

_initSoilSensor:

	CLRF       ADRESH+0
	CLRF       ADRESL+0
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_initSoilSensor50:
	DECFSZ     R13+0, 1
	GOTO       L_initSoilSensor50
	DECFSZ     R12+0, 1
	GOTO       L_initSoilSensor50
	DECFSZ     R11+0, 1
	GOTO       L_initSoilSensor50
	NOP
	NOP
L_end_initSoilSensor:
	RETURN
; end of _initSoilSensor

_readDataFromSoilSensor:

	BTFSC      ADCON0+0, 1
	GOTO       L_readDataFromSoilSensor51
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      133
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FLOC__readDataFromSoilSensor+0
	MOVF       R0+1, 0
	MOVWF      FLOC__readDataFromSoilSensor+1
	MOVF       FLOC__readDataFromSoilSensor+0, 0
	MOVWF      _analogna_velicina+0
	MOVF       FLOC__readDataFromSoilSensor+1, 0
	MOVWF      _analogna_velicina+1
	MOVF       FLOC__readDataFromSoilSensor+0, 0
	MOVWF      R0+0
	MOVF       FLOC__readDataFromSoilSensor+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _soil_humidity+0
	MOVF       R0+1, 0
	MOVWF      _soil_humidity+1
	MOVF       R0+2, 0
	MOVWF      _soil_humidity+2
	MOVF       R0+3, 0
	MOVWF      _soil_humidity+3
	MOVF       FLOC__readDataFromSoilSensor+0, 0
	MOVWF      FARG_intToString_broj+0
	MOVF       FLOC__readDataFromSoilSensor+1, 0
	MOVWF      FARG_intToString_broj+1
	MOVLW      _buffer_s+0
	MOVWF      FARG_intToString_buffer+0
	CALL       _intToString+0
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_readDataFromSoilSensor52:
	DECFSZ     R13+0, 1
	GOTO       L_readDataFromSoilSensor52
	DECFSZ     R12+0, 1
	GOTO       L_readDataFromSoilSensor52
	NOP
L_readDataFromSoilSensor51:
L_end_readDataFromSoilSensor:
	RETURN
; end of _readDataFromSoilSensor

_initADC:

	BSF        ANSEL+0, 5
	BSF        TRISE+0, 0
	BSF        ANSEL+0, 6
	BSF        TRISE+0, 1
	BSF        ADCON0+0, 7
	BCF        ADCON0+0, 6
	BCF        ADCON0+0, 5
	BSF        ADCON0+0, 4
	BSF        ADCON1+0, 7
	BCF        ADCON1+0, 5
	BCF        ADCON1+0, 4
L_end_initADC:
	RETURN
; end of _initADC

_initTimer0:

	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
	BSF        PS2_bit+0, BitPos(PS2_bit+0)
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
	BSF        PS0_bit+0, BitPos(PS0_bit+0)
	MOVLW      63
	MOVWF      TMR0+0
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
	BSF        T0IE_bit+0, BitPos(T0IE_bit+0)
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
L_end_initTimer0:
	RETURN
; end of _initTimer0

_main:

	CLRF       ANSELH+0
	MOVLW      112
	MOVWF      OSCCON+0
	MOVLW      16
	MOVWF      T1CON+0
	CLRF       TMR1H+0
	CLRF       TMR1L+0
	BCF        TRISD+0, 0
	CLRF       PORTD+0
	CALL       _initADC+0
	CALL       _initUSART+0
	CALL       _initTimer0+0
L_main53:
	CALL       _initLDR+0
	BSF        ADCON0+0, 0
	BSF        ADCON0+0, 1
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main55:
	DECFSZ     R13+0, 1
	GOTO       L_main55
	DECFSZ     R12+0, 1
	GOTO       L_main55
	DECFSZ     R11+0, 1
	GOTO       L_main55
	NOP
	NOP
	CALL       _readDataFromLDR+0
	CALL       _initSoilSensor+0
	BSF        ADCON0+0, 0
	BSF        ADCON0+0, 1
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	DECFSZ     R12+0, 1
	GOTO       L_main56
	DECFSZ     R11+0, 1
	GOTO       L_main56
	NOP
	NOP
	CALL       _readDataFromSoilSensor+0
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	DECFSZ     R11+0, 1
	GOTO       L_main57
	NOP
	NOP
	CALL       _readDataFromDHT22+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _soil_humidity+0, 0
	MOVWF      R0+0
	MOVF       _soil_humidity+1, 0
	MOVWF      R0+1
	MOVF       _soil_humidity+2, 0
	MOVWF      R0+2
	MOVF       _soil_humidity+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main60
	BTFSC      PORTD+0, 0
	GOTO       L_main60
L__main78:
	BSF        PORTD+0, 0
	MOVF       _counter+0, 0
	MOVWF      _i+0
	MOVF       _counter+1, 0
	MOVWF      _i+1
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _dangerMessage+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_dangerMessage+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
L_main61:
	CALL       _initSoilSensor+0
	BSF        ADCON0+0, 0
	BSF        ADCON0+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main64:
	DECFSZ     R13+0, 1
	GOTO       L_main64
	DECFSZ     R12+0, 1
	GOTO       L_main64
	DECFSZ     R11+0, 1
	GOTO       L_main64
	NOP
	CALL       _readDataFromSoilSensor+0
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	DECFSZ     R11+0, 1
	GOTO       L_main65
	NOP
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      112
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _soil_humidity+0, 0
	MOVWF      R0+0
	MOVF       _soil_humidity+1, 0
	MOVWF      R0+1
	MOVF       _soil_humidity+2, 0
	MOVWF      R0+2
	MOVF       _soil_humidity+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main77
	MOVF       _i+0, 0
	SUBWF      _counter+0, 0
	MOVWF      R1+0
	MOVF       _i+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      9
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main102
	MOVLW      96
	SUBWF      R1+0, 0
L__main102:
	BTFSC      STATUS+0, 0
	GOTO       L__main77
	GOTO       L_main61
L__main77:
	BCF        PORTD+0, 0
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _successMessage+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_successMessage+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
L_main60:
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main103
	MOVLW      1
	XORWF      _flag+0, 0
L__main103:
	BTFSS      STATUS+0, 2
	GOTO       L_main68
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _reset+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_reset+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      61
	MOVWF      R11+0
	MOVLW      225
	MOVWF      R12+0
	MOVLW      63
	MOVWF      R13+0
L_main69:
	DECFSZ     R13+0, 1
	GOTO       L_main69
	DECFSZ     R12+0, 1
	GOTO       L_main69
	DECFSZ     R11+0, 1
	GOTO       L_main69
	NOP
	NOP
	MOVLW      61
	MOVWF      R11+0
	MOVLW      225
	MOVWF      R12+0
	MOVLW      63
	MOVWF      R13+0
L_main70:
	DECFSZ     R13+0, 1
	GOTO       L_main70
	DECFSZ     R12+0, 1
	GOTO       L_main70
	DECFSZ     R11+0, 1
	GOTO       L_main70
	NOP
	NOP
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _connect+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_connect+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
	DECFSZ     R11+0, 1
	GOTO       L_main71
	NOP
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _size+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_size+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main72:
	DECFSZ     R13+0, 1
	GOTO       L_main72
	DECFSZ     R12+0, 1
	GOTO       L_main72
	DECFSZ     R11+0, 1
	GOTO       L_main72
	NOP
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _request+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_request+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _request2+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_request2+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _request3+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_request3+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       R0+0, 0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _request4+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_request4+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       _temp+0, 0
	MOVWF      _msg+27
	MOVF       _temp+1, 0
	MOVWF      _msg+28
	MOVF       _temp+3, 0
	MOVWF      _msg+30
	MOVF       _humidity+0, 0
	MOVWF      _msg+41
	MOVF       _humidity+1, 0
	MOVWF      _msg+42
	MOVF       _humidity+3, 0
	MOVWF      _msg+44
	MOVLW      _msg+0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	MOVLW      _msg+0
	MOVWF      FARG_CopyConst2Ram_dest+0
	MOVLW      _request5+0
	MOVWF      FARG_CopyConst2Ram_src+0
	MOVLW      hi_addr(_request5+0)
	MOVWF      FARG_CopyConst2Ram_src+1
	CALL       _CopyConst2Ram+0
	MOVF       _buffer_s+0, 0
	MOVWF      _msg+15
	MOVF       _buffer_s+1, 0
	MOVWF      _msg+16
	MOVF       _buffer_s+2, 0
	MOVWF      _msg+17
	MOVF       _buffer_l+0, 0
	MOVWF      _msg+32
	MOVF       _buffer_l+1, 0
	MOVWF      _msg+33
	MOVF       _buffer_l+2, 0
	MOVWF      _msg+34
	MOVLW      _msg+0
	MOVWF      FARG_sendData_text+0
	CALL       _sendData+0
	CLRF       _flag+0
	CLRF       _flag+1
L_main68:
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main73:
	DECFSZ     R13+0, 1
	GOTO       L_main73
	DECFSZ     R12+0, 1
	GOTO       L_main73
	DECFSZ     R11+0, 1
	GOTO       L_main73
	NOP
	NOP
	GOTO       L_main53
L_end_main:
	GOTO       $+0
; end of _main
