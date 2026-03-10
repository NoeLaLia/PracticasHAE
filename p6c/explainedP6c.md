(no content)Te explico el código paso a paso.

## Variables globales

```c
long int tension;          // Valor crudo del ADC (0-1023)
long int temp;             // Temperatura en Celsius (siempre se guarda en ºC)
long int temp_mostrar;     // Temperatura convertida a la unidad actual
unsigned char print[7];    // Buffer de texto para el LCD
unsigned char unidad = 0;  // 0=Celsius, 1=Fahrenheit, 2=Kelvin
```

- `temp` siempre almacena grados Celsius. La conversión a F o K se hace solo al mostrar.
- `unidad` es el índice que cicla entre 0, 1 y 2 cada vez que se pulsa el botón.

## Conexiones LCD

```c
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
// ... etc
```

Es la declaración estándar de MikroC para conectar el LCD LM016L al puerto D (pines RD2-RD7), idéntico a p6a y p6b.

## Función `mostrar_temp()`

```c
void mostrar_temp() {
    switch(unidad) {
        case 0: temp_mostrar = temp;                break;  // ºC directo
        case 1: temp_mostrar = temp * 9 / 5 + 32;  break;  // ºF = 1.8*C + 32
        case 2: temp_mostrar = temp + 273;          break;  // ºK = C + 273
    }
    IntToStr(temp_mostrar, print);   // Convierte entero a string de 6 chars
    Lcd_Out(1, 1, print);           // Escribe el número en fila 1, columna 1
    Lcd_Chr(1, 8, 223);            // Escribe el símbolo º (código ASCII 223)
    switch(unidad) {                // Escribe la letra de la unidad
        case 0: Lcd_Chr(1, 9, 'C'); break;
        case 1: Lcd_Chr(1, 9, 'F'); break;
        case 2: Lcd_Chr(1, 9, 'K'); break;
    }
}
```

Se usa como función auxiliar para no repetir código, ya que la llaman **las dos interrupciones**: la del timer y la del botón.

## La ISR (`void interrupt()`)

Tiene dos bloques, uno por cada fuente de interrupción:

### 1. Timer0 — lectura del sensor

```c
if (INTCON.TMR0IF == 1) {
    TMR0H = (28036 >> 8);    // Recarga del timer
    TMR0L = 28036;
    INTCON.TMR0IF = 0;        // Limpia el flag

    PORTE.B0 = !PORTE.B0;    // Toggle LED (debug visual)
    ADCON0.GO = 1;            // Inicia conversión ADC
    while(ADCON0.GO);         // Espera a que termine

    tension = (ADRESH << 8) + ADRESL;       // Lee resultado 10 bits
    temp = (tension * 500) / 1023 - 50;     // Convierte a ºC

    mostrar_temp();           // Actualiza LCD con la unidad actual
}
```

Cada ~1.2 segundos el Timer0 desborda, entra aquí, lee el LM35 por ADC y actualiza la pantalla.

### 2. INT1 — botón B

```c
if (INTCON3.INT1IF == 1) {
    INTCON3.INT1IF = 0;       // Limpia el flag

    unidad++;                 // Cicla: 0 -> 1 -> 2 -> 0
    if (unidad > 2) unidad = 0;

    mostrar_temp();           // Actualiza LCD AL INSTANTE
}
```

Este es el punto clave del ejercicio: al pulsar el botón, **no se espera al timer**. La interrupción externa INT1 se dispara inmediatamente y llama a `mostrar_temp()`, que recalcula `temp` (que ya está en ºC en memoria) a la nueva unidad y reescribe el LCD.

## El `main()`

```c
ADCON0 = 0x59;    // Selecciona AN3, activa ADC
ADCON1 = 0xC4;    // Justificación derecha, AN3 analógico
```

Configura el ADC para leer el LM35 por el canal AN3 (pin RA3).

```c
TRISE.B0 = 0;     // RE0 como salida (LED toggle)
TRISA.B3 = 1;     // RA3 como entrada (LM35)
TRISB.B1 = 1;     // RB1 como entrada (botón B)
```

Configura la dirección de los pines.

```c
T0CON = 0x06;     // Timer0: 16-bit, prescaler 1:128, apagado
TMR0H = (28036 >> 8);
TMR0L = 28036;
T0CON.TMR0ON = 1; // Enciende Timer0
```

Timer0 configurado para desbordar cada ~1.2 segundos (mismo valor que p6b).

```c
INTCON2.INTEDG1 = 1;    // INT1 por flanco de subida
INTCON3.INT1IF = 0;      // Limpia flag
INTCON3.INT1IE = 1;      // Habilita INT1
```

Configura la interrupción externa INT1 en RB1. Flanco de subida = se dispara cuando el botón pasa de 0 a 1 (al pulsarlo).

```c
INTCON.GIE = 1;   // Habilita interrupciones globales
while(1) { }      // Bucle vacío, todo ocurre por interrupciones
```

El `main` no hace nada más. Todo el trabajo lo hacen las ISR.

## Circuito en Proteus

```
LM35  ---> RA3 (AN3)      // Sensor de temperatura
BUTTON --> RB1 (INT1)      // Botón para cambiar unidades
LCD LM016L --> RD2-RD7     // Display (igual que p6b)
LED    <-- RE0              // Toggle visual cada lectura
```

## Restricciones cumplidas

| Restricción | Cómo se cumple |
|---|---|
| Sin `delay_ms()`/`delay_us()` | La temporización es por Timer0 |
| Sin polling | No hay `if(boton==1)` en el `while(1)`; se usa INT1 |
| Cambio inmediato al pulsar | `mostrar_temp()` se ejecuta dentro de la ISR de INT1 |