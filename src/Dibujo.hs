{-# LANGUAGE LambdaCase #-}
-- Exporta los constructores de datos de Dibujo y las funciones definidas
-- para ser utilizadas en otros modulos

module Dibujo ( 
    Dibujo,
    figura, rotar, espejar, rot45, apilar, juntar, encimar,
    r180, r270,
    (.-.), (///), (^^^),
    cuarteto, encimar4, ciclar,
    foldDib, mapDib,
    figuras
) where

{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig> 
    | Juntar <Float> <Float> <Fig> <Fig> 
    | Encimar <Fig> <Fig>
-}

data Dibujo a =  Borrar
		| Figura (a)
		| Rotar (Dibujo a) -- Rotar 90
		| Espejar (Dibujo a)
		| Rot45 (Dibujo a)
		| Apilar (Float) (Float) (Dibujo a) (Dibujo a)
		| Juntar (Float) (Float) (Dibujo a) (Dibujo a)
		| Encimar (Dibujo a) (Dibujo a)
		deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones
-- Construcción de dibujo. Abstraen los constructores
borrar :: (Dibujo a) -> (Dibujo a)
borrar fig = Borrar

figura :: (a -> Dibujo a)
figura fig = Figura fig

rotar :: (Dibujo a) -> (Dibujo a)
rotar dib = Rotar dib

espejar :: (Dibujo a) -> (Dibujo a)
espejar dib = Espejar dib

rot45 :: (Dibujo a) -> (Dibujo a)
rot45 dib = Rot45 dib

apilar :: (Float) -> (Float) -> (Dibujo a) -> (Dibujo a) -> (Dibujo a)
apilar num1 num2 dib1 dib2 = Apilar num1 num2 dib1 dib2

juntar :: (Float) -> (Float) -> (Dibujo a) -> (Dibujo a) -> (Dibujo a)
juntar num1 num2 dib1 dib2 = Juntar num1 num2 dib1 dib2

encimar :: (Dibujo a) -> (Dibujo a) -> (Dibujo a)
encimar dib1 dib2 = Encimar dib1 dib2


-- Composicion n-veces de una funcion con si misma. Componer 0 veces
-- es la funcion constante, componer 1 vez es aplicar la funcion 1 vez, etc.
-- Componer negativamente es un error!
comp :: (a -> a) -> Int -> a -> a
comp f 1 a = f a
comp f n a = comp f (n-1) (f a)

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 fig = comp Rotar 2 fig

r270 :: Dibujo a -> Dibujo a
r270 fig = comp Rotar 3 fig

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) fig1 fig2 = Apilar 100 100 fig1 fig2

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) fig1 fig2 = Juntar 100 100 fig1 fig2

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) fig1 fig2 = Encimar fig1 fig2

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto fig1 fig2 fig3 fig4 = (///) ((.-.) fig1 fig2) ((.-.) fig3 fig4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 fig = (^^^) ((^^^) (fig) (rotar fig)) ((^^^) (r180 fig) (r270 fig))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar fig = cuarteto (fig) (rotar fig) (r180 fig) (r270 fig)

-- Ver un a como un dibujo (Casteo?)
figura :: a -> Dibujo a
figura fig = Figura fig

-- map para nuestro lenguaje 
-- (para cada constructor de datos, del constructor de tipos Dibujo)
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib func Borrar = Borrar
mapDib func (Figura fig) = Figura (func fig)
mapDib func (Rotar fig) = Rotar (mapDib func fig)
mapDib func (Espejar fig) = Espejar (mapDib func fig)
mapDib func (Rot45 fig) = Rot45 (mapDib func fig)
mapDib func (Apilar num1 num2 fig1 fig2) = 
    Apilar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Juntar num1 num2 fig1 fig2) = 
    Juntar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Encimar fig1 fig2) = 
    Encimar (mapDib func fig1) (mapDib func fig2)

-- Verificar que satisfaga la siguiente igualdad:
-- mapDib figura = id (id es la funcion identidad)

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Intro a la lógica
-- foldDib aplicado a cada constructor de Dibujo deberia devolver el mismo dibujo
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib figura rotar espejar rotar45 apilar juntar encimar (Figura dibu) = 
    figura dibu 
foldDib figura rotar espejar rotar45 apilar juntar encimar (Rotar dibu) = 
    rotar (foldDib figura rotar espejar rotar45 apilar juntar encimar dibu)  
foldDib figura rotar espejar rotar45 apilar juntar encimar (Espejar dibu) = 
    espejar (foldDib figura rotar espejar rotar45 apilar juntar encimar dibu)
foldDib figura rotar espejar rotar45 apilar juntar encimar (Rot45 dibu) = 
    rot45 (foldDib figura rotar espejar rotar45 apilar juntar encimar dibu)
foldDib figura rotar espejar rotar45 apilar juntar encimar (Apilar num1 num2 dib1 dib2) = 
    apilar num1 num2 (foldDib figura rotar espejar rotar45 apilar juntar encimar dib1) 
                     (foldDib figura rotar espejar rotar45 apilar juntar encimar dib2)
foldDib figura rotar espejar rotar45 apilar juntar encimar (Juntar num1 num2 dib1 dib2) = 
    juntar num1 num2 (foldDib figura rotar espejar rotar45 apilar juntar encimar dib1) 
                     (foldDib figura rotar espejar rotar45 apilar juntar encimar dib2)
foldDib figura rotar espejar rotar45 apilar juntar encimar (Encimar dib1 dib2) = 
    encimar (foldDib figura rotar espejar rotar45 apilar juntar encimar dib1) 
            (foldDib figura rotar espejar rotar45 apilar juntar encimar dib2)
    

-- Demostrar que `mapDib figura = id`
-- mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
{-
Sea mapDib figura = id entonces

Como figura :: a -> Dibujo a
Al aplicarle la funcion "figura" a todos los elementos de un dibujo, no se realiza
ninguna modificacion en el mismo, pues como "a" es del tipo Dibujo sus "hojas" 
son Figuras, por tanto "figura" devuelve el mismo dibujo que toma como argumento.
-}

-- Junta todas las figuras básicas de un dibujo.

{-
figuras :: Dibujo a -> [a]
figuras Borrar = []
figuras fig = foldDib [fig]
-}

figuras :: Dibujo a -> [a]
figuras dibu = foldDib casoFigura id id id casoConcat casoConcat casoEncimar dibu
               where
                    casoFigura :: a -> [a]
                    casoFigura fig = [fig]

                    casoConcat :: Float -> Float -> [a] -> [a] -> [a]
                    casoConcat _ _ dib1 dib2 = dib1 ++ dib2

                    casoEncimar :: [a] -> [a] -> [a]
                    casoEncimar dib1 dib2 = dib1 ++ dib2