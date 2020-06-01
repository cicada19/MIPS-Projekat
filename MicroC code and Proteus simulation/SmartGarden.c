// DHT11 sensor connection (here data pin is connected to pin RB0)

sbit DHT11_PIN at RB0_bit;
sbit DHT11_PIN_Direction at TRISB0_bit;


// Promjenjive koje se spremaju na RAM memoriji (koja ima svoja ogranicenja)

int i                 = 0;
int counter           = 0;
int flag              = 1;
int analogna_velicina = 0;
float soil_humidity = 0;
char temp[]           = "  . ";
char humidity[]       = "  . ";
char buffer_l[]       = "   ";
char buffer_s[]       = "   ";
char msg[52];
unsigned short T_byte1, T_byte2, RH_byte1, RH_byte2, CheckSum ;

// Konstante koje se spremaju na Flash memoriju

const char reset[]    = "AT+RST\r\n";
const char connect[]  = "AT+CIPSTART=\"TCP\",\"192.168.137.1\",80\r\n";
const char size[]     = "AT+CIPSEND=194\r\n";
const char request[]  = "POST /measurement/insert HTTP/1.1\r\n";
const char request2[] = "Host: 192.168.137.1\r\nContent-Type: ";
const char request3[] = "application/x-www-form-urlencoded\r\nContent";
const char request4[] = "-Length: 65\r\n\r\ntemperature=  . &humidity=  . ";
const char request5[] = "&soil_moisture=   &illumination=   \r\n";
const char dangerMessage[] = "Water pump activated, moisture level is too low !\r\n";
const char successMessage[] = "Water pump deactivated !\r\n";


void interrupt(){
  if(T0IF_bit)                               // Delay od 25ms
  {
      counter++;
      if(counter>=40*60*60)                  // Delay od 25ms*x
      {
      counter = 0;
      flag = 1;
      }
      T0IF_bit = 0;
      TMR0 = 0x3F;;
  }
}

char* CopyConst2Ram(char * dest, const char * src){
  char * d ;
  d = dest;
  for(;*dest++ = *src++;)
    ;
  return d;
}

void Start_Signal(void) {
  DHT11_PIN_Direction = 0;                    // Configure connection pin as output
  DHT11_PIN = 0;                              // Connection pin output low
  delay_ms(25);                               // Wait 25 ms
  DHT11_PIN = 1;                              // Connection pin output high
  delay_us(25);                               // Wait 25 us
  DHT11_PIN_Direction = 1;                    // Configure connection pin as input
}

unsigned short Check_Response() {
  TMR1H = 0;                                  // Reset Timer1
  TMR1L = 0;
  TMR1ON_bit = 1;                             // Enable Timer1 module
  while(!DHT11_PIN && TMR1L < 100);           // Wait until DHT11_PIN becomes high (cheking of 80µs low time response)
  if(TMR1L > 99)                              // If response time > 99µS  ==> Response error
    return 0;                                 // Return 0 (Device has a problem with response)
  else {    TMR1H = 0;                        // Reset Timer1
    TMR1L = 0;
    while(DHT11_PIN && TMR1L < 100);          // Wait until DHT11_PIN becomes low (cheking of 80µs high time response)
    if(TMR1L > 99)                            // If response time > 99µS  ==> Response error
      return 0;                               // Return 0 (Device has a problem with response)
    else
      return 1;                               // Return 1 (response OK)
  }
}

unsigned short Read_Data(unsigned short* dht_data) {
  short i;
  *dht_data = 0;
  for(i = 0; i < 8; i++){
    TMR1H = 0;                                // Reset Timer1
    TMR1L = 0;
    while(!DHT11_PIN)                         // Wait until DHT11_PIN becomes high
      if(TMR1L > 100) {                       // If low time > 100  ==>  Time out error (Normally it takes 50µs)
        return 1;
      }
    TMR1H = 0;                                // Reset Timer1
    TMR1L = 0;
    while(DHT11_PIN)                          // Wait until DHT11_PIN becomes low
      if(TMR1L > 100) {                       // If high time > 100  ==>  Time out error (Normally it takes 26-28µs for 0 and 70µs for 1)
        return 1;                             // Return 1 (timeout error)
      }
     if(TMR1L > 50)                           // If high time > 50  ==>  Sensor sent 1
       *dht_data |= (1 << (7 - i));           // Set bit (7 - i)
  }
  return 0;                                   // Return 0 (data read OK)
}

 void readDataFromDHT22(){
  Start_Signal();                // Send start signal to the sensor

    if(Check_Response()) {         // Check if there is a response from sensor (If OK start reding humidity and temperature data)
    // Read (and save) data from the DHT11 sensor and check time out errors
      if(Read_Data(&RH_byte1) || Read_Data(&RH_byte2) || Read_Data(&T_byte1) || Read_Data(&T_byte2) || Read_Data(&Checksum)) {

        //sendData("Time out!");
      }
      else {                                               // If there is no time out error
        if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF)) {
        // If there is no checksum error
            temp[0]  = T_Byte1/10  + 48;
            temp[1]  = T_Byte1%10  + 48;
            temp[3]  = T_Byte2/10  + 48;
            humidity[0]     = RH_Byte1/10 + 48;
            humidity[1]     = RH_Byte1%10 + 48;
            humidity[3]     = RH_Byte2/10 + 48;
        }
        // If there is a checksum error
        else {
          //sendData("Checksum Error!");
        }
      }
    }
    // If there is a response (from the sensor) problem
    else
    {
      //sendData("No response from the sensor");
    }
    TMR1ON_bit = 0;                        // Disable Timer1 module
    delay_ms(1000);                        // Wait 1 second
}

void sendData(char* text){
 for(i=0; text[i]!='\0';)
  {
      if(TRMT_bit)                  // Provjerava da li se aktivirao bit koji se automatski setuje na 1 kada se isprazni TSR pomjeracki registar koji podatke gura ka TX
      {
      TXREG=text[i];                // Upisujemo u registar za slanje sledeci karakter
      i++;
      }
      delay_ms(10);
  }
}

void  intToString(int broj, char* buffer){
    if(broj/100!=0)
    {
      buffer[0] = broj/100 + '0';
    }
    else
    {
      buffer[0] = ' ';
    }
    if(broj/10!=0)
    {
      buffer[1] = (broj/10)%10 + '0';
    }
    else
    {
      buffer[1] = ' ';
    }
    buffer[2] = broj%10 + '0';
}

void initUSART(){
  TXEN_bit  = 1;           // Omogucavamo slanje podataka podešavanjem navedenog bita TXSTA registra
  SPEN_bit  = 1;           // Omogucen rad serijskog porta. Pinovi RX/DT i TX/CK se automatski konfigurišu kao ulazni i izlazne (RCSTA registar).

  SYNC_bit  = 0;           // Konfigurisemo da modul radi u asinhronom rezimu ( 1- sinhroni)
  BRG16_bit = 0;          // Setovanjem bita BRG16 bita u BAUDCTL registru odreduje se da li ce BRG raditi kao 8-bitni ili 16-bitni tajmer.
  BRGH_bit  = 1;           // 1 – EUSART radi sa velikim brzinama prenosa , 0 - malim

  SPBRG     = 25;           // Postavljamo vrijednost registra SPBRG (iz tabela)koji zavisi od prethodna 3 bita
  // Tj. zavisi od toga da li je sinhroni/asinhroni, 8/16 bitni, i da li modul radi na velikoj/maloj brzini, takodje vrijednosti boudratea
  // 19200 boud rate

  GIE_bit = 1;             // Omogucavamo globalni interrupt
  PEIE_bit = 1;            // -II- periferalni interrupt enable
  RCIE_bit = 1;            // Interrupt nad RX usart komunikacije
}

void initLDR(){
    // Brisemo ADC 16-bitni registar u koji se upisuje rezultat konverzije

    ADRESH = 0;
    ADRESL = 0;

    // Mijenjamo kanal ADC a na AN5/RE0 port
    CHS1_bit = 0;
    CHS0_bit = 1;

    delay_ms(500);
}

void readDataFromLDR(){
   if(ADCON0.B1==0)
   {
     analogna_velicina=((ADRESH*256+ADRESL)/1024.0)*100.0;
     IntToString(analogna_velicina, buffer_l);
     delay_ms(10);
   }
}

void initSoilSensor(){
    // Brisemo ADC 16-bitni registar u koji se upisuje rezultat konverzije

    ADRESH = 0;
    ADRESL = 0;

    // Mijenjamo kanal ADC a na AN6/RE1 port
    CHS1_bit = 1;
    CHS0_bit = 0;

    delay_ms(500);
}

void readDataFromSoilSensor(){
   if(ADCON0.B1==0)
   {
     analogna_velicina  = 100 -((ADRESH*256+ADRESL)/1024.0)*100.0;
     soil_humidity = analogna_velicina;
     IntToString(analogna_velicina, buffer_s);
     delay_ms(10);
   }
}

void initADC(){
  ANSEL.B5 = 1;                    // Postavljamo pin RE0 / AN5 da bude analogni.
  TRISE.B0 = 1;                    // pin RE0 / AN5 postavljen da bude ulaz (input).
  ANSEL.B6 = 1;                    // Postavljamo pin RE1 / AN6 da bude analogni.
  TRISE.B1 = 1;                    // pin RE1 / AN6 postavljen da bude ulaz (input).

  // Prva dva bita 10 odgovaraju Fosc/32 i pri 8Mhz delay je 8/20MHy=0.4us 01

  ADCON0.B7 = 1;
  ADCON0.B6 = 0;
  ADCON0.B5 = 0;                                 // Kanal AN4 i vise
  ADCON0.B4 = 1;

  // B7 - Desno poravnanje i zadnja dva B5,B4 - VDD i VSS referentni naponi

  ADCON1.B7 = 1;
  ADCON1.B5 = 0;
  ADCON1.B4 = 0;
}

void initTimer0(){
T0CS_bit = 0;                    // Postavljamo T0CS na 0 i time aktiviramo timer mod TIMERA 0
PSA_bit = 0;                     // Bit moda rada prescalera PSA(0-timer/brojac, 1-WDT(Watch dog timer))

PS2_bit = 1;                    //
PS1_bit = 1;                    // Prescaler po proracunu (PS2=PS1=PS0=1 --> 256)
PS0_bit = 1;                    //

TMR0 = 0x3F;                    // Postavljamo proracunatu vrijednost timera da bi dobili delay od 25ms

GIE_bit = 1;                          // Globalni interapt enable bit (1- omogucava interapte, 0- onemogucava int.)
T0IE_bit = 1;                         // Omogucava interapt od strane Timera 0 pri njegovom prekoracenju (1), onemogucava (0)
T0IF_bit = 0;                         // Oznacava da jos nije doslo do prekoracenja timera 0 (0), (1) --> prekoracenje
}

void main(){

  ANSELH   = 0;
  OSCCON =  0X70;                  // Set internal oscillator to 8 MHz
  T1CON  =  0x10;                  // Set Timer1 clock source to internal with 1:2 prescaler (Timer1 clock = 1 MHz)
  TMR1H  =  0;                     // Reset Timer 1
  TMR1L  =  0;

  TRISD.B0 = 0;                    // PORTD je output i pocetna vrijednost je LOW
  PORTD    = 0;

  initADC();                       // Inicijalizujemo ADC konvertora
  initUSART();                     // Inicijalizujemo UART komunikaciju
  initTimer0();                    // Inicijalizujemo Timer 0 u timer rezimu rada

  while(1)
  {

      initLDR();
      ADCON0.B0 = 1;
      ADCON0.B1 = 1;
      delay_ms(500);
      readDataFromLDR();

      initSoilSensor();
      ADCON0.B0 = 1;
      ADCON0.B1 = 1;
      delay_ms(500);
      readDataFromSoilSensor();
      delay_ms(500);

      readDataFromDHT22();

      if(soil_humidity < 10 && PORTD.B0 == 0){
         PORTD.B0 = 1;
         i = counter;
         sendData(CopyConst2Ram(msg,dangerMessage));
         do{
           initSoilSensor();
            ADCON0.B0 = 1;
            ADCON0.B1 = 1;
            delay_ms(100);
            readDataFromSoilSensor();
            delay_ms(100);
         }while(soil_humidity<30 && (counter - i) < 2400);
         PORTD.B0 = 0;
         sendData(CopyConst2Ram(msg,successMessage));
      }

      if(flag==1)
      {
      sendData(CopyConst2Ram(msg,reset));
      delay_ms(6000);
      delay_ms(6000);
      sendData(CopyConst2Ram(msg,connect));
      delay_ms(2000);
      sendData(CopyConst2Ram(msg,size));
      delay_ms(2000);
      sendData(CopyConst2Ram(msg,request));
      sendData(CopyConst2Ram(msg,request2));
      sendData(CopyConst2Ram(msg,request3));
      CopyConst2Ram(msg,request4);

      msg[27] = temp[0];
      msg[28] = temp[1];
      msg[30] = temp[3];
      msg[41] = humidity[0];
      msg[42] = humidity[1];
      msg[44] = humidity[3];
      sendData(msg);
      CopyConst2Ram(msg,request5);
      msg[15] = buffer_s[0];
      msg[16] = buffer_s[1];
      msg[17] = buffer_s[2];
      msg[32] = buffer_l[0];
      msg[33] = buffer_l[1];
      msg[34] = buffer_l[2];
      sendData(msg);
      flag = 0;
      }

      delay_ms(5000);
  }
}
