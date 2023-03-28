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

-- Construcción de dibujo. Abstraen los constructores.

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


-- Composicion n-veces de una funcion con si misma. Componer 0 veces
-- es la funcion constante, componer 1 vez es aplicar la funcion 1 vez, etc.
-- Componer negativamente es un error!
comp :: (a -> a) -> Int -> a -> a
comp f 1 a = f a
comp f n a = comp f (n-1) (f a)

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 fig = comp (rotar (2 fig))

r270 :: Dibujo a -> Dibujo a
r270 fig = comp rotar 3 fig

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) fig1 fig2 = apilar 100 100 fig1 fig2
-- figura
-- figura

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) fig1 fig2 = juntar 100 100 fig1 fig2
-- figura figura

-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) fig1 fig2 = encimar fig1 fig2
-- ffiigguurraa

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto fig1 fig2 fig3 fig4 = (///) ((.-.) fig1 fig2) ((.-.) fig3 fig4)
-- fig1 fig3
-- fig2 fig4

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 fig = (^^^) ((^^^) (fig) (rotar fig)) ((^^^) (r180 fig) (r270 fig))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar fig = cuarteto (fig) (rotar fig) (r180 fig) (r270 fig)

-- Ver un a como un dibujo (Casteo?)
figura :: a -> Dibujo a
figura fig = figura fig

-- map para nuestro lenguaje
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib func Borrar = Borrar
mapDib func (Figura fig) = Figura (func fig)
mapDib func (Rotar fig) = Rotar (mapDib func fig)
mapDib func (Espejar fig) = Espejar (mapDib func fig)
mapDib func (Rot45 fig) = Rot45 (mapDib func fig)
mapDib func (Apilar num1 num2 fig1 fig2) = Apilar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Juntar num1 num2 fig1 fig2) = Juntar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Encimar fig1 fig2) = Encimar (mapDib func fig1) (mapDib func fig2)
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
