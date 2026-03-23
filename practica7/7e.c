// Medidor de presión con MPX4250 para PIC18F452 (mikroC style)
// Muestreo: 0.5 Hz (1 muestra cada 2 s) usando Timer0 (1 s overflow) y contador de desbordes
// Salida en LCD. Cambio de unidad con pulsador en INT1 (RB1).

// Pin mapping LCD (igual estilo que el repo)
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

// Constantes del sensor y conversiones
#define VCC 5.0
#define V_OFFSET 0.369   // tensión de offset aprox (V) según enunciado
#define K_SENS 0.004     // V per kPa (ejemplo) -> P_kPa = (Vout - V_OFFSET)/K_SENS
#define SAMPLE_OVERFLOWS 2 // 2 desbordes de 1s = 2s -> 0.5 Hz

volatile unsigned char overflow_count = 0; // cuenta desbordes Timer0
volatile bit sample_flag = 0;              // indica que hay que muestrear
volatile unsigned char unit_index = 0;     // 0..6 ciclo de unidades

// Nombres de unidades y factores de conversión desde kPa
const char *unit_labels[7] = {"kPa","PSI","Atm","mBar","mmHg","N/m2","kg/cm2"};

// ISR: Timer0 overflow (1s) y INT1 (botón) manejados aquí
void interrupt() {
  // Timer0 overflow
  if (INTCON.TMR0IF == 1) {
    // recargar preload 1s (Fosc=8MHz, prescaler 1:128 -> preload = 49911)
    TMR0H = (49911 >> 8);
    TMR0L = 49911;
    INTCON.TMR0IF = 0;
    overflow_count++;
    if (overflow_count >= SAMPLE_OVERFLOWS) {
      overflow_count = 0;
      sample_flag = 1; // solicitar muestreo cada 2 s
    }
  }

  // Botón (INT1) cambio de unidad (flanco configurado en main)
  if (INTCON3.INT1IF == 1) {
    INTCON3.INT1IF = 0;          // limpiar flag
    unit_index++;
    if (unit_index >= 7) unit_index = 0;
  }
}

// Convierte kPa a la unidad seleccionada
float convert_from_kpa(float p_kpa, unsigned char idx) {
  float out = p_kpa;
  switch(idx) {
    case 0: // kPa
      out = p_kpa; break;
    case 1: // PSI
      out = p_kpa / 6.8927; break;
    case 2: // Atm
      out = p_kpa / 101.325; break;
    case 3: // mBar
      out = p_kpa * 10.0; break; // 1 kPa = 10 mBar
    case 4: // mmHg
      out = p_kpa / 0.13328; break;
    case 5: // N/m2 (Pa)
      out = p_kpa * 1000.0; break;
    case 6: // kg/cm2
      out = p_kpa / 98.1; break;
    default:
      out = p_kpa; break;
  }
  return out;
}

void main() {
  unsigned int raw_adc;
  float vout, p_kpa, p_display;
  char buf[16];

  // ADC config: AN1 para MPX4250 (RA1)
  ADCON1 = 0x0E; // AN0=AN1 analog, resto digitales (ajusta según tu librería)
  ADCON0 = 0x02; // seleccionar AN1 (canal 1) y ADON=1 (ajusta bits según compilador)

  // Inicializar LCD
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1,1,"Presion:");

  // Timer0: 1 s overflow (preload 49911) como en el resto de ejercicios
  T0CON = 0x06;             // 16-bit, prescaler 1:128
  TMR0H = (49911 >> 8);
  TMR0L = 49911;
  T0CON.TMR0ON = 1;

  // Configurar INT1 (boton en RB1) por flanco de subida
  INTCON2.INTEDG1 = 1;
  INTCON3.INT1IF = 0;
  INTCON3.INT1IE = 1;

  // Habilitar interrupciones Timer0
  INTCON.TMR0IF = 0;
  INTCON.TMR0IE = 1;
  INTCON.GIE = 1;

  while(1) {
    if (sample_flag) {
      sample_flag = 0;
      // Leer ADC AN1
      ADCON0bits.CHS = 1;    // seleccionar AN1 (sintaxis de ejemplo)
      ADCON0.GO = 1;         // iniciar conversión
      while (ADCON0.GO);
      raw_adc = (ADRESH << 8) | ADRESL;

      // convertir a tensión
      vout = (raw_adc * VCC) / 1023.0;

      // calcular presión en kPa según modelo: P = (Vout - Voffset) / K_SENS
      p_kpa = (vout - V_OFFSET) / K_SENS;
      if (p_kpa < 0) p_kpa = 0;
      if (p_kpa > 250.0) p_kpa = 250.0; // rango del sensor

      // convertir a unidad seleccionada
      p_display = convert_from_kpa(p_kpa, unit_index);

      // mostrar en LCD (2 decimales)
      FloatToStr(p_display, buf); // convierte float a string
      Lcd_Out(1,9, buf);
      // mostrar unidad
      Lcd_Out(2,1, unit_labels[unit_index]);
    }
  }
}
