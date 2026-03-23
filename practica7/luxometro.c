// Luxómetro para PIC18F452 (mikroC style)
// Muestreo: 1 vez por segundo usando Timer0 (16-bit, prescaler 1:128)
// Entrada Vo en RA0/AN0. Divisor: R_fixed (15k) y LDR.
// Calcula Lux usando R = 127410 * Lux^(-0.8582) => Lux = (127410 / R)^(1/0.8582)

long int raw_adc;
unsigned char lcd_buf[16];
volatile bit sample_flag = 0; // indica que hay que tomar muestra

// LCD pin mapping (igual estilo que archivos previos)
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

// Constantes del circuito / LDR
#define VCC 5.0
#define R_FIXED 15000.0  // resistencia fija del divisor (15k)
#define LDR_CONST 127410.0
#define LDR_EXP 0.8582

// Timer0 ISR: genera sample_flag cada 1 segundo
void interrupt() {
  if (INTCON.TMR0IF == 1) {
    // recargar preload 1s (Fosc=8MHz, prescaler 1:128 -> preload = 49911)
    TMR0H = (49911 >> 8);    // cargar byte alto del preload
    TMR0L = 49911;           // cargar byte bajo del preload
    INTCON.TMR0IF = 0;       // limpiar bandera de interrupción
    sample_flag = 1;         // señalizar al main que tome muestra
  }
}

// Calcula resistencia de LDR a partir de Vo medida
float calc_rldr(float vo) {
  // evitar división por cero si vo == VCC
  if (vo >= VCC - 0.001) return 1e9; // resistencia muy baja (saturado)
  return R_FIXED * vo / (VCC - vo);
}

// Calcula lux a partir de resistencia LDR usando la relación empírica
float calc_lux(float rldr) {
  // Lux = (127410 / R)^(1/0.8582)
  if (rldr <= 0) return 0.0;
  return pow( LDR_CONST / rldr, 1.0 / LDR_EXP );
}

void main() {
  float vo, rldr, luxf;
  int lux_int;

  // ADC config: igual que ejemplos previos (AN0 como analógico)
  ADCON0 = 0x59; // configuración de ejemplo (canal, ADON, Fosc/8)
  ADCON1 = 0xC4; // configuración de referencias y justificación según repo

  // Inicializar LCD
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);

  // Inicializar Timer0: 16-bit, prescaler 1:128 (no arrancar aún)
  T0CON = 0x06;                  // TMR0OFF, 16-bit, prescaler 1:128
  TMR0H = (49911 >> 8);          // preload alto para 1 s
  TMR0L = 49911;                 // preload bajo para 1 s
  T0CON.TMR0ON = 1;              // arrancar Timer0

  INTCON.TMR0IF = 0;             // limpiar flag Timer0
  INTCON.TMR0IE = 1;             // habilitar interrupción Timer0
  INTCON.GIE = 1;                // habilitar interrupciones globales

  // Mensaje estático en LCD
  Lcd_Out(1,1,"Lux:");

  while(1) {
    if (sample_flag) {           // si la ISR solicitó una muestra
      sample_flag = 0;          // resetear flag

      // seleccionar canal AN0 (RA0) y lanzar conversión
      ADCON0bits.CHS = 0;      // seleccionar AN0 (sintaxis de ejemplo)
      ADCON0.GO = 1;           // iniciar conversión ADC
      while (ADCON0.GO);       // esperar final de conversión

      // leer resultado ADC de 10 bits
      raw_adc = (ADRESH << 8) + ADRESL;    // composición de bytes

      // convertir a tensión Vo
      vo = (raw_adc * VCC) / 1023.0;       // 10-bit ADC

      // calcular resistencia LDR y lux
      rldr = calc_rldr(vo);
      luxf = calc_lux(rldr);

      // mostrar valor entero de Lux en LCD (sin librería float printf)
      if (luxf < 0) luxf = 0;
      if (luxf > 9999) luxf = 9999; // limitar para display
      lux_int = (int)(luxf + 0.5);
      IntToStr(lux_int, lcd_buf);            // convertir a string
      Lcd_Out(1,6, lcd_buf);                 // mostrar en posición col 6
    }
  }
}
