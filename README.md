# Paradigmas de la Programación - FaMAF

## **Informe - Laboratorio 01**

#### Grupo número 31: "StackOverFlowers" 🌻

#### Integrantes:

- Integrante 1
- Adragna Javier Martin
- Gonzalía Alvaro Tomas

## Laboratorio de programación funcional

En este trabajo se implementa un DSL que combina dibujos y los interpreta utilizando `gloss` para mostrarlos por pantalla, separando la sintaxis de la semántica de gloss, permitiendo así otras posibles interpretaciones para esa combinación de dibujos.

### Cómo compilar y correr

Para poder correr la implementación, se debe instalar [gloss](https://hackage.haskell.org/package/gloss) (puede realizarse desde [cabal](https://www.haskell.org/cabal/) o [stack](https://docs.haskellstack.org/en/stable/)

```bash
cabal update
cabal install gloss
```

Ademas, en caso de querer correr los test debe instalarse [HUnit](https://hackage.haskell.org/package/HUnit)

```bash
cabal install HUnit
```

Luego puede ejecutarse con

```bash
$ ghci Main.hs
ghci> :set args Escher
ghci> main
```

donde `Escher` puede ser reemplazado con el nombre del dibujo que se quiere mostrar por pantalla (la lista completa de los mismos puede ser consultada utilizando el flag `--lista`)

### Preguntas

- ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo
Las funcionalidades del DSL están separadas en los módulos `Dibujo.hs` e `Interp.hs` debido a que la primera se encarga de definir la sintaxis de las operaciones de nuestro lenguaje, la segunda se encarga de definir la semantica de las operaciones, permitiendo poder mostrarlas en pantalla usando Gloss. Esta division a su vez deja abierta la posibilidad de crear interpretaciones alternativas a esa semantica, manteniendo las mismas operaciones.

- ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?
Las figuras básicas no están incluidas en la definición del lenguaje y son tomadas como un parámetro del tipo debido a que se busca una mayor abstraccion en el diseño del lenguaje, separar las tareas y modularizar el codigo. Esto deja abierta la posibilidad de mantener el lenguaje para otro tipo de figuras basicas.

- ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
La ventaja de utilizar una función de tipo fold en vez de realizar pattern matching sobre los constructores de Dibujo es que tenemos mayor eficiencia en el codigo, escribimos menos lineas para realizar un mismo trabajo, se optimiza la tarea. Tambien ayuda a separar el recorrido y procesamiento del tipo Dibujo de la logica que queremos emplear en las funciones que nos piden definir.

### Metodología de trabajo

La realización de todo el laboratorio se dio trabajando en conjunto, siguiendo la técnica de _**pair programming**_. Para ello, se utilizó la extensión de Vscode "_Live Share_" mientras se mantenían reuniones periódicas a través de _Discord_. Adicionalmente, los días viernes se trabajó siguiendo la misma técnica pero de manera presencial. Por tal motivo, la gran mayoría de los commits son de carácter grupal.
Las reuniones fueron casi diarias, exceptuando algunos dias, trabajamos siempre en conjunto para todo el desarrollo del proyecto.

### Utilización de IAs

En diferentes partes del desarrollo del trabajo se han utilizado herramientas de inteligencia artificial como complemento de aprendizaje al momento de intentar comprender el funcionamiento de distintas funciones, ya sea dadas por el kickstart o propias de Gloss o HUnit. Se ha evitado utilizar _**Copilot**_ para generar codigo relacionado al DSL en un intento de poder comprender completamente el codigo que se estaba implementando (aunque se lo haya empleado en funciones puntuales relacionadas a la sintaxis propia de HUnit, o de Haskell al trabajar con monadas). Para ese mismo fin se ha empleado a _**ChatGPT**_. Respecto a eso, si bien las primeras impresiones sobre el mismo fueron maravillosas (permitiéndonos entender muchas cosas), con el uso constante del mismo se han hecho evidentes distintas _**contradicciones**_ del mismo, dando respuestas opuestas a cada integrante o incluso dentro de un mismo chat, lo que ha planteado dudas sobre la veracidad de los mensajes anteriores que en un principio se daban por ciertos sin contrastar demasiado. Esta primera experiencia utilizando IAs como apoyo a la hora de trabajar ha sido útil para comprender el potencial que tienen para ayudar en las tareas más repetitivas, como así también el nivel de _**confiabilidad**_ actual que poseen y la necesidad de verificar esas respuestas.

### Decisiones de implementación

Se ha tratado de generalizar distintas funciones con el fin de hacerlas aplicables a la mayor cantidad de casos posibles. Por ejemplo, se ha creado `auxiliarAnyAll` en el módulo `Pred.hs` que generaliza la función de tipo fold de Dibujo hacia bool, y se ha modificado la función `cambiar` de `Pred.hs` para poder aplicar una función arbitraria (que toma como argumento) al encontrar un Dibujo que cumpla el predicado. También se ha intentado reutilizar la mayor cantidad de veces las distintas funciones ya definidas, a la par de mantener un estilo de código uniforme y adecuado (para el cual se ha decidido utilizar nombres de variables bien descriptivas, a pesar de que ello suponga lineas de código mas largas, para intentar reducir la abstracción conceptual de algunas funciones y, especialmente, algunos manejos de tipos).
....

_algo sobre las ventajas y funcionalidades del paradigma funcional_
Una de las ventajas que mas aprovechamos fueron las funciones de alto orden, que permiten crear mas abstraccion en la funcion que desarrollamos, el uso de la recursion que es inevitable si estamos trabajando con el paradigma. La modularidad, mucha separacion de responsabilidades entre archivos o funciones, nos permitio hacer un codigo mas reutilizable y facil de entender.