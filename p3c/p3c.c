/*
Práctica 3 c): En el circuito indicado más abajo, cada vez que se pulsa el botón U, el
valor mostrado en el doble display debe de incrementarse en 1 unidad. Cada vez que se
pulsa el botón D, el valor mostrado en el doble display debe disminuir en 1 unidad (el
valor mostrado en el doble display nunca puede ser menor que cero). No se puede
utilizar la técnica de polling
*/
//Numero a representar
char numeroActual = 80;
void interrupt(){
     //Boton D
     //Se reconoce porque el flag de esa interrupción RB0 está activo (Cadena de saltos)
     if(INTCON.INT0IF == 1){

     //Reinicianmos la interrupción
           INTCON.INT0IF = 0;
           /*No puede ser menor a 0, por lo que si es cero no hacemos nada*/
           if(numeroActual != 0){
                           numeroActual--;
                           }
     }
     //Boton U
     else if(INTCON3.INT1IF == 1){
     //Reiniciamos la interrupción
          INTCON3.INT1IF = 0;
          /*Evitamos que desborde no haciendo nada en el 99"*/
          if(numeroActual != 99){
                          numeroActual++;

                          }
}
}
void main() {
     char valores[] = {0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};

     //Valor temporal del actua, para no machacarlo
     char temp = 0;
     char decenas = 0;
     char unidades = 0;
     ADCON1 = 0x07;
     TRISD = 0;
     TRISE = 0;
     
     TRISB.B1 = 1; // se configura RB1 como entrada
     INTCON2.INTEDG1 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
     INTCON3.INT1IF = 0; // se pone el flag de la interrupción INT1 a 0
     INTCON3.INT1IE = 1; // se habilita la interrupción INT1
     
     TRISB.B0 = 1; //se configura RB0 como entrada
     INTCON2.INTEDG0 = 1; //la interrupción la provoca un flanco de subida (x=1)/ bajada (x=0)
     INTCON.INT0IF = 0; //se pone el flag de la interrupción INT0 a 0
     INTCON.INT0IE = 1; //se habilita la interrupción INT0
     
     INTCON.GIE = 1; //se habilitan las interrupciones en general


     
     
     while(1){
              temp = numeroActual;
              unidades = temp % 10;
              temp /= 10;
              decenas = temp % 10;
              //Solo activo el display de las unidades (2) al tener  un 0 en su patilla
              PORTE = 0b101;
              PORTD = valores[unidades];
              //Seguimos teniendo que esperar porque si no se simula mal
              delay_ms(5);
              //Solo activo el display de las decenas (1)  al tener  un 0 en su patilla
              PORTE = 0b110;
              PORTD = valores[decenas];
              delay_ms(5);
  }
}