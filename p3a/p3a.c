/*
Práctica 3 a): El diodo emisor de luz (led) conectado a la patilla RB3 debe cambiar de estado
(encendido/apagado) cada vez que se presiona el pulsador SW conectado al terminal RB2.
Hay que resolver este apartado haciendo que el microcontrolador observe periódicamente
(cada 100mseg.) si el pulsador está presionado o no (técnica de polling)
Componentes ISIS: PIC18F452, RES, LED-BLUE y BUTTON
Preguntas: ¿Cuántas veces por segundo crees que el µC
debe observar el valor de RB2 para que sepa todas las
veces que se pulsa el botón?... ¿seguro?
¿Cuál es el tiempo mínimo que puedes mantener pulsado
un botón?... ¿de verdad?... ¿seguro?
*/

void main() {
            char botonPulsado = 0;
            TRISB.B2 = 1;
            TRISB.B3 = 0;
            while(1){
                     if(PORTB.B2 == 1 && botonPulsado == 0){
                        botonPulsado = 1;
                        PORTB.B3 += 1;

                                 }
                     if(PORTB.B2 == 0 && botonPulsado == 1){
                                 botonPulsado = 0;
                        }
                        delay_ms(25);

  }
}