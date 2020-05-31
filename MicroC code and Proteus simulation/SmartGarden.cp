#line 1 "C:/Users/ewo/Desktop/New folder/SmartGarden.c"


sbit DHT11_PIN at RB0_bit;
sbit DHT11_PIN_Direction at TRISB0_bit;




int i = 0;
int counter = 0;
int flag = 1;
int analogna_velicina = 0;
float soil_humidity = 0;
char temp[] = "  . ";
char humidity[] = "  . ";
char buffer_l[] = "   ";
char buffer_s[] = "   ";
char msg[52];
unsigned short T_byte1, T_byte2, RH_byte1, RH_byte2, CheckSum ;



const char reset[] = "AT+RST\r\n";
const char connect[] = "AT+CIPSTART=\"TCP\",\"192.168.137.1\",80\r\n";
const char size[] = "AT+CIPSEND=194\r\n";
const char request[] = "POST /measurement/insert HTTP/1.1\r\n";
const char request2[] = "Host: 192.168.137.1\r\nContent-Type: ";
const char request3[] = "application/x-www-form-urlencoded\r\nContent";
const char request4[] = "-Length: 65\r\n\r\ntemperature=  . &humidity=  . ";
const char request5[] = "&soil_moisture=   &illumination=   \r\n";
const char dangerMessage[] = "Water pump activated, moisture level is too low !\r\n";
const char successMessage[] = "Water pump deactivated !\r\n";


void interrupt(){
 if(T0IF_bit)
 {
 counter++;
 if(counter>=40*60*5)
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
 DHT11_PIN_Direction = 0;
 DHT11_PIN = 0;
 delay_ms(25);
 DHT11_PIN = 1;
 delay_us(25);
 DHT11_PIN_Direction = 1;
}

unsigned short Check_Response() {
 TMR1H = 0;
 TMR1L = 0;
 TMR1ON_bit = 1;
 while(!DHT11_PIN && TMR1L < 100);
 if(TMR1L > 99)
 return 0;
 else { TMR1H = 0;
 TMR1L = 0;
 while(DHT11_PIN && TMR1L < 100);
 if(TMR1L > 99)
 return 0;
 else
 return 1;
 }
}

unsigned short Read_Data(unsigned short* dht_data) {
 short i;
 *dht_data = 0;
 for(i = 0; i < 8; i++){
 TMR1H = 0;
 TMR1L = 0;
 while(!DHT11_PIN)
 if(TMR1L > 100) {
 return 1;
 }
 TMR1H = 0;
 TMR1L = 0;
 while(DHT11_PIN)
 if(TMR1L > 100) {
 return 1;
 }
 if(TMR1L > 50)
 *dht_data |= (1 << (7 - i));
 }
 return 0;
}

 void readDataFromDHT22(){
 Start_Signal();

 if(Check_Response()) {

 if(Read_Data(&RH_byte1) || Read_Data(&RH_byte2) || Read_Data(&T_byte1) || Read_Data(&T_byte2) || Read_Data(&Checksum)) {


 }
 else {
 if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF)) {

 temp[0] = T_Byte1/10 + 48;
 temp[1] = T_Byte1%10 + 48;
 temp[3] = T_Byte2/10 + 48;
 humidity[0] = RH_Byte1/10 + 48;
 humidity[1] = RH_Byte1%10 + 48;
 humidity[3] = RH_Byte2/10 + 48;
 }

 else {

 }
 }
 }

 else
 {

 }
 TMR1ON_bit = 0;
 delay_ms(1000);
}

void sendData(char* text){
 for(i=0; text[i]!='\0';)
 {
 if(TRMT_bit)
 {
 TXREG=text[i];
 i++;
 }
 delay_ms(10);
 }
}

void intToString(int broj, char* buffer){
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
 TXEN_bit = 1;
 SPEN_bit = 1;

 SYNC_bit = 0;
 BRG16_bit = 0;
 BRGH_bit = 1;

 SPBRG = 25;



 GIE_bit = 1;
 PEIE_bit = 1;
 RCIE_bit = 1;
}

void initLDR(){


 ADRESH = 0;
 ADRESL = 0;


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


 ADRESH = 0;
 ADRESL = 0;


 CHS1_bit = 1;
 CHS0_bit = 0;

 delay_ms(500);
}

void readDataFromSoilSensor(){
 if(ADCON0.B1==0)
 {
 analogna_velicina = 100 -((ADRESH*256+ADRESL)/1024.0)*100.0;
 soil_humidity = analogna_velicina;
 IntToString(analogna_velicina, buffer_s);
 delay_ms(10);
 }
}

void initADC(){
 ANSEL.B5 = 1;
 TRISE.B0 = 1;
 ANSEL.B6 = 1;
 TRISE.B1 = 1;



 ADCON0.B7 = 1;
 ADCON0.B6 = 0;
 ADCON0.B5 = 0;
 ADCON0.B4 = 1;



 ADCON1.B7 = 1;
 ADCON1.B5 = 0;
 ADCON1.B4 = 0;
}

void initTimer0(){
T0CS_bit = 0;
PSA_bit = 0;

PS2_bit = 1;
PS1_bit = 1;
PS0_bit = 1;

TMR0 = 0x3F;

GIE_bit = 1;
T0IE_bit = 1;
T0IF_bit = 0;
}

void main(){

 ANSELH = 0;
 OSCCON = 0X70;
 T1CON = 0x10;
 TMR1H = 0;
 TMR1L = 0;

 TRISD.B0 = 0;
 PORTD = 0;

 initADC();
 initUSART();
 initTimer0();

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
