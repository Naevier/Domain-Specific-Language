To Do:
> 1.b) Interpretacion geometrica en Pred.hs (coordenadas)
> 2.b) Graficar grilla en Grilla.hs
> 2.c) Nuestro dibujo en Escher.hs (rompe abstracciones -> cuadrado/triangulo)
> 2.d) En Main.hs extender la funcionalidad para listar los dibujos y preguntar cual mostrar
> 3) Tests (recomendacion hunit (o Copilot), "de caja negra, usando sólo las funciones constructoras y no los constructores", 
>          si quieren testear las figuras constructoras, pueden hacer algo como assertEqual "figura" (show $ figura Circulo) "Figura Circulo")
> 4) Responder preguntas e informe en README.md


> Revision general (lineas menos de 80 caracteres, rehuso de funciones, comentarios solo sobre codigo, limpiar repo de archivos como este, etc)
> Repaso conceptual y sobre el codigo 
> Otra figura? (punto estrella)


---- Preguntas

> Establecer la relacion entre Picture (de Gloss) y nuestro Figura? -> Nos permitiria usar el tipo FloatingPic
> Establecer la relacion entre figuras (de Gloss) y nuestro foldDib?
> Generalizacion en "filter" de foldDib
> Funcion cambiar en Pred
-- Parametro "func" de la funcion "foldGen"



---- Ya respondidas

// Union en la semantica de las funciones de interpretacion grafica -> figuras
funcion "figuras" de Gloss (imprime ambas cosas en el mismo "cuadrado")

/// > En los constructores Apilar y Juntar, hay dos campos de tipo Float ¿Cuál es la funcion de estos dos Float?
proporciones de tamaño, por ej si Juntar 1.0 2.0, la segunda columna ocupa el doble de tamaño que la primera

/// > Estamos entendiendo bien mapDib y foldDib?
si pero es mejor si podemos generalizar mas al usarla como filter

/// > Cuantos caracteres max por linea para mantener un buen estilo?
80 max

/// > Hay drama en usar funciones lambda?
no, al contrario

/// > (anyDib) Cual seria la diferencia entre usar Pred para un tipo Figura y un tipo Dibujo?

/// > id devuelve el mismo elemento?
si

/// > Estamos aplicando bien foldDib en "figuras"? (despues usamos el mismo formato para Pred)
-> Generalizar las funciones para hacer un filter mas general (menos argumentos a la funcion, mismo caso para todas pero con diferente significado)

/// > La demostracion está bien planteada?
-> "Por ahora dejenla asi, mas adelante planteenla mas formalmente" (mas adelante en este lab, o en otros labs?)

/// > Alternativa a gloss presentada el año pasado (diagrams)
solo si tenemos problemas con gloss

/// > Cuando suben Feo.hs
"en algun momento de la semana que viene"

> Implementacion de la Union de la semantica de operaciones para Gloss

> (allDib) En los caso base (figura) se devuelve True o False. Como se unen esos Bool al resto de Bools en las otras hojas? (con que operador?)

----
Interp.hs = coordenadas
Nuestro_Dibujo.hs = rompe abstracciones -> Cuadrado/triangulo
----
