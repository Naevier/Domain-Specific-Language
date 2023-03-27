{-# LANGUAGE LambdaCase #-}
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

data Dibujo a =   Borrar
		| Figura (a)
		| Rotar (Dibujo a)
		| Espejar (Dibujo a)
		| Rot45 (Dibujo a)
		| Apilar (Float) (Float) (Dibujo a) (Dibujo a)
		| Juntar (Float) (Float) (Dibujo a) (Dibujo a)  
		| Encimar (Dibujo a) (Dibujo a)
		deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Construcción de dibujo. Abstraen los constructores.

--------------------------------------------- No iria, la implementacion seria con gloss en el archivo... interp.hs?
--figura :: (a -> Dibujo a) -- (???)
--figura =

--rotar :: (Dibujo a) -> (Dibujo a)
--rotar = 

--espejar :: (Dibujo a) -> (Dibujo a)
--espejar =

--rot45 :: (Dibujo a) -> (Dibujo a)
--rot45 =

--apilar :: (Float) -> (Float) -> (Dibujo a) -> (Dibujo a) -> (Dibujo a)
--apilar =

--juntar :: (Float) -> (Float) -> (Dibujo a) -> (Dibujo a) -> (Dibujo a)
--juntar =

--encimar :: (Dibujo a) -> (Dibujo a) -> (Dibujo a)
--encimar =
---------------------------------------------

-- Composicion n-veces de una funcion con si misma. Componer 0 veces
-- es la funcion constante, componer 1 vez es aplicar la funcion 1 vez, etc.
-- Componer negativamente es un error!
comp :: (a -> a) -> Int -> a -> a
comp f 1 a = f a
comp f n a = comp f (n-1) (f a)

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 = comp rotar90 2 a

r270 :: Dibujo a -> Dibujo a
r270 a = comp rotar90 3 a

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = Apilar 100 100 a b

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = 

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) =

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto =

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 =

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar =

-- Ver un a como un dibujo
figura :: a -> Dibujo a
figura =

-- map para nuestro lenguaje
mapDib :: (a -> Dibujo b)-> Dibujo a -> Dibujo b
mapDib f ? =
mapDib f a =

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
foldDib =

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b

-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras =
