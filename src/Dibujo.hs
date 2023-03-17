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


data Dibujo a = Borrar -- Completar
    deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones

-- Construcción de dibujo. Abstraen los constructores.

figura = undefined

rotar = undefined

espejar = undefined

rot45 = undefined

apilar = undefined

juntar = undefined

encimar = undefined


-- Rotaciones de múltiplos de 90.
r180 = undefined

r270 :: Dibujo a -> Dibujo a
r270 = undefined

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) = undefined

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) = undefined

-- Superpone una figura con otra.
(^^^) = undefined

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto = undefined

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 = undefined

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar = undefined

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Floatro a la lógica
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Float -> Float -> b -> b -> b) -> 
       (Float -> Float -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
foldDib = undefined

-- Demostrar que `mapDib figura = id`
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib = undefined

-- Junta todas las figuras básicas de un dibujo.
figuras = undefined
