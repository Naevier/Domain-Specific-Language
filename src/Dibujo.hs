{-# LANGUAGE LambdaCase #-}
-- Exporta los constructores de datos de Dibujo y las funciones definidas
-- para ser utilizadas en otros modulos

module Dibujo where
{-
Gramática de las figuras:
<Fig> ::= Figura <Bas> | Rotar <Fig> | Espejar <Fig> | Rot45 <Fig>
    | Apilar <Float> <Float> <Fig> <Fig> 
    | Juntar <Float> <Float> <Fig> <Fig> 
    | Encimar <Fig> <Fig>
-}

data Dibujo a =  Borrar
        | Figura a
        | Rotar (Dibujo a) -- Rotar 90
        | Espejar (Dibujo a)
        | Rot45 (Dibujo a)
        | Apilar Float Float (Dibujo a) (Dibujo a)
        | Juntar Float Float (Dibujo a) (Dibujo a)
        | Encimar (Dibujo a) (Dibujo a)
        deriving (Eq, Show)

-- Agreguen los tipos y definan estas funciones
-- Construcción de dibujo. Abstraen los constructores
figura :: (a -> Dibujo a)
figura = Figura 

rotar :: Dibujo a -> Dibujo a
rotar = Rotar

espejar :: Dibujo a -> Dibujo a
espejar = Espejar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45 

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar 

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar  = Juntar 

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar 


-- Composicion n-veces de una funcion con si misma. Componer 0 veces
-- es la funcion constante, componer 1 vez es aplicar la funcion 1 vez, etc.
-- Componer negativamente es un error!
comp :: (a -> a) -> Int -> a -> a
comp f 0 a = a
comp f n a = comp f (n-1) (f a)

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 = comp Rotar 2 

r270 :: Dibujo a -> Dibujo a
r270  = comp Rotar 3

-- Pone una figura sobre la otra, ambas ocupan el mismo espacio.
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = Apilar 1.0 1.0
{-
[f2]
[f1]
-}

-- Pone una figura al lado de la otra, ambas ocupan el mismo espacio.
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///)  = Juntar 1.0 1.0
{-
[f2][f1]
-}
-- Superpone una figura con otra.
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = Encimar

-- Dadas cuatro figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto fig1 fig2 fig3 fig4 = (.-.) ((///) fig1 fig2) ((///) fig3 fig4)

-- Una figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 fig = (^^^) ((^^^) fig (rotar fig)) ((^^^) (r180 fig) (r270 fig))

-- Cuadrado con la misma figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar fig = cuarteto fig (rotar fig) (r180 fig) (r270 fig)

-- map para nuestro lenguaje 
-- (para cada constructor de datos, del constructor de tipos Dibujo)
mapDib :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
mapDib func Borrar = Borrar
mapDib func (Figura fig) =  func fig
mapDib func (Rotar fig) = Rotar (mapDib func fig)
mapDib func (Espejar fig) = Espejar (mapDib func fig)
mapDib func (Rot45 fig) = Rot45 (mapDib func fig)
mapDib func (Apilar num1 num2 fig1 fig2) = 
    Apilar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Juntar num1 num2 fig1 fig2) = 
    Juntar num1 num2 (mapDib func fig1) (mapDib func fig2)
mapDib func (Encimar fig1 fig2) = 
    Encimar (mapDib func fig1) (mapDib func fig2)

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de Intro a la lógica
-- foldDib aplicado a cada constructor de Dibujo deberia devolver el mismo dibujo
foldDib :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
        (Float -> Float -> b -> b -> b) -> 
        (Float -> Float -> b -> b -> b) -> 
        (b -> b -> b) ->
        Dibujo a -> b
foldDib figura rotar espejar rot45 apilar juntar encimar (Figura dibu) = 
    figura dibu 

foldDib figura rotar espejar rot45 apilar juntar encimar (Rotar dibu) = 
    rotar (foldDib figura rotar espejar rot45 apilar juntar encimar dibu)  

foldDib figura rotar espejar rot45 apilar juntar encimar (Espejar dibu) = 
    espejar (foldDib figura rotar espejar rot45 apilar juntar encimar dibu)

foldDib figura rotar espejar rot45 apilar juntar encimar (Rot45 dibu) = 
    rot45 (foldDib figura rotar espejar rot45 apilar juntar encimar dibu)

foldDib figura rotar espejar rot45 apilar juntar encimar (Apilar num1 num2 dib1 dib2) = 
    apilar num1 num2 (foldDib figura rotar espejar rot45 apilar juntar encimar dib1) 
                     (foldDib figura rotar espejar rot45 apilar juntar encimar dib2) 

foldDib figura rotar espejar rot45 apilar juntar encimar (Juntar num1 num2 dib1 dib2) = 
    juntar num1 num2 (foldDib figura rotar espejar rot45 apilar juntar encimar dib1) 
                     (foldDib figura rotar espejar rot45 apilar juntar encimar dib2)

foldDib figura rotar espejar rot45 apilar juntar encimar (Encimar dib1 dib2) = 
    encimar (foldDib figura rotar espejar rot45 apilar juntar encimar dib1) 
            (foldDib figura rotar espejar rot45 apilar juntar encimar dib2)
    


{-
Demostrar que `mapDib figura = id`


Caso base: mapDib figura Borrar
Trivial, por definicion de mapDib Borrar = id Borrar = Borrar
Por lo tanto, la base de la inducción se cumple.

Caso inductivo:
Hipotesis inductiva: mapDib figura fig = id fig

Debemos comprobar que vale para cada figura

-- Caso figura
mapDib figura (Figura fig) 
    = {- caso Figura -}
        Figura (figura fig)
    = {- Definición de mapDib -}
        Figura (id fig)
    = {- Definición de figura -}
        Figura fig

id (Figura fig)
    {- por definición de id -}
    = Figura fig   

-- Caso rotar
mapDib figura (Rotar fig)               
    = {- Definicion de mapDib -}   
        Rotar (mapDib figura fig)
    = {- por hip inductiva -}
        Rotar (id fig)         
    = {- por hipótesis de id-}
        Rotar fig                      

id (Rotar fig)
    = {- por definición de id -}
        = Rotar fig                       

-- Caso espejar
mapDib figura (Espejar fig)
    = {- por definición de mapDib -}
        Espejar (mapDib figura fig)  
    = {- por hipótesis de inducción -}
        Espejar (id fig)     
    = {- por definición de id -}          
        Espejar fig       

id (Espejar fig)
    = {- por def de id-}
    Espejar fig                    

-- Caso apilar
mapDib figura (Apilar v fig1 fig2)
    = {- por definición de mapDib-}
        Apilar v (mapDib figura fig1) (mapDib figura fig2)   
    = {- por hipótesis inductiva -}
        Apilar v (id fig1) (id fig2)                
    = {- por definición de id -}           
        Apilar v fig1 fig2              

id (Apilar v fig1 fig2)
    = {- por definición de id-}
        Apilar v fig1 fig2                                   

-- Caso juntar
mapDib figura (Juntar h fig1 fig2)                              
    = {- por definición de mapDib-}                              
        Juntar h (mapDib figura fig1) (mapDib figura fig2)  
    = {- por hipótesis de inducción-} 
        Juntar h (id fig1) (id fig2)          
    = {- por definición de id-}                
        Juntar h fig1 fig2         

id (Juntar h fig1 fig2)
    = {- por definición de id -}
    Juntar h fig1 fig2                                    

-- Caso encimar
mapDib figura (Encimar fig1 fig2)
    = {- por definición de mapDib-}
        Encimar (mapDib figura fig1) (mapDib figura fig2)   
    = {-   por hipótesis de inducción -}
        Encimar (id fig1) (id fig2)           
    = {-  -- por definición de id-}              
        Encimar fig1 fig2      

id (Encimar fig1 fig2)
    = {- por definición de id -}
        Encimar fig1 fig2                                    
-}

-- Junta todas las figuras básicas de un dibujo.
figuras :: Dibujo a -> [a]
figuras = 
    foldDib casoFigura id id id casoConcat casoConcat casoEncimar
        where
            casoFigura :: a -> [a]
            casoFigura fig = [fig]

            casoConcat :: Float -> Float -> [a] -> [a] -> [a]
            casoConcat _ _ dib1 dib2 = dib1 ++ dib2

            casoEncimar :: [a] -> [a] -> [a]
            casoEncimar dib1 dib2 = dib1 ++ dib2