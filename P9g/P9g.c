#define APAGADO 0
#define CALENTANDO 1
#define ENFRIANDO 2

#define VS 0
#define VREF 1

int voltaje_vs;
int voltaje_vref;
int canal = VS;
 int vref;
 int vs;
int estado = APAGADO;
int alfa_adc = 8;
int alfa = 28036;

void cambiar_canal(unsigned char c) {
    ADCON0 = (c << 3) | 0x41;
    canal = c;
}

void interrupt() {
     vs = voltaje_vs*(5/1024);
     vref = voltaje_vref*(5/1024);
     
     if(INTCON.TMR0IF == 1) {
        if (PORTA.B4 == 0) {
        estado = APAGADO;
        PORTA.B2 = 0; // c = 0
    } else {
        // Lógica de control Bang-Bang
        switch(estado) {
            case APAGADO:
                estado = CALENTANDO;
                break;

            case CALENTANDO:
                PORTA.B2 = 1; // Encender resistencia
                if (vs >= (vref + alfa_adc)) {
                    estado = ENFRIANDO;
                }
                break;

            case ENFRIANDO:
                PORTA.B2 = 0; // Apagar resistencia
                if (vs <= (vref - alfa_adc)) {
                    estado = CALENTANDO;
                }
                break;
        }
     }
     ADCON0.B2 = 1;
     INTCON.TMR0IF = 0;
   }
   if(PIR1.ADIF == 1) {
        switch(canal) {
          case VS:
              voltaje_vs = ADRESL + (ADRESH << 8);
              cambiar_canal(VREF);
              break;
          case VREF:
               voltaje_vref = ADRESL + (ADRESH << 8);
               cambiar_canal(VS);
               break;


       }

       PIR1.ADIF = 0;
   }
}


void main() {
    TRISA.B2 = 1;
    TRISA.B0 = 0;
    TRISA.B1 = 0;
    TRISA.B4 = 0;
    ADCON0 = 0x41;
    ADCON1 = 0xC4;
    T0CON = 0x11;
    INTCON.TMR0IF = 0;
    INTCON.TMR0IE = 1;
    PIR1.ADIF = 0;
    PIE1.ADIE = 1;
    INTCON.PEIE = 1;
    INTCON.GIE = 1;
    
    TMR0H = (alfa >> 8);
    TMR0L = alfa;
    
    T0CON.B7 = 1;
    ADCON0.GO = 1;
    
    while(1){

    }
    
    
    
    
}