long int tension;
long int temp;         // Temperatura en Celsius
long int temp_mostrar; // Temperatura en la unidad actual
unsigned char print[7];
unsigned char unidad = 0; // 0=Celsius, 1=Fahrenheit, 2=Kelvin

// LCD module connections
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections

void mostrar_temp() {
    switch(unidad) {
        case 0: // Celsius
            temp_mostrar = temp;
            break;
        case 1: // Fahrenheit: F = 1.8*C + 32
            temp_mostrar = temp * 9 / 5 + 32;
            break;
        case 2: // Kelvin: K = C + 273
            temp_mostrar = temp + 273;
            break;
    }

    IntToStr(temp_mostrar, print);
    Lcd_Out(1, 1, print);
    Lcd_Chr(1, 8, 223); // simbolo grado

    switch(unidad) {
        case 0: Lcd_Chr(1, 9, 'C'); break;
        case 1: Lcd_Chr(1, 9, 'F'); break;
        case 2: Lcd_Chr(1, 9, 'K'); break;
    }
}

void interrupt() {
    // Interrupcion Timer0 - lectura de temperatura cada 1.2s
    if (INTCON.TMR0IF == 1) {
        TMR0H = (28036 >> 8);
        TMR0L = 28036;
        INTCON.TMR0IF = 0;

        PORTE.B0 = !PORTE.B0;
        ADCON0.GO = 1;
        while(ADCON0.GO);

        tension = (ADRESH << 8) + ADRESL;
        temp = (tension * 500) / 1023 - 50;

        mostrar_temp();
    }

    // Interrupcion INT1 - boton B cambia unidades
    if (INTCON3.INT1IF == 1) {
        INTCON3.INT1IF = 0;

        unidad++;
        if (unidad > 2) unidad = 0;

        mostrar_temp(); // actualiza LCD inmediatamente
    }
}

void main() {
    ADCON0 = 0x59; // AN3, Fosc/8, ADON
    ADCON1 = 0xC4; // Right justified, AN3 analogico

    TRISE.B0 = 0;   // RE0 salida (LED toggle)
    TRISA.B3 = 1;   // AN3 entrada (LM35)
    TRISB.B1 = 1;   // RB1 entrada (boton B - INT1)

    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);

    // Config Timer0: 16-bit, prescaler 1:128
    T0CON = 0x06;
    TMR0H = (28036 >> 8);
    TMR0L = 28036;
    T0CON.TMR0ON = 1;

    // Habilitar interrupcion Timer0
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;

    // Config INT1 (boton B en RB1) - flanco de subida
    INTCON2.INTEDG1 = 1;
    INTCON3.INT1IF = 0;
    INTCON3.INT1IE = 1;

    // Habilitar interrupciones globales
    INTCON.GIE = 1;

    while(1) {
    }
}
