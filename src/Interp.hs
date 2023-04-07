module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

-- Sistema de coordenadas de Gloss: Origen (0.0) = centro de la ventana

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib)
import FloatingPic (FloatingPic, Output, grid)
{- IMPORTACIONES:

    data Picture                -- Constructor de tipo Picture, sus constructores de datos son (crean figuras):
    = Blank                     -- Representa una imagen en blanco, vacía
    | Polygon Path              -- Representa un polígono definido por una lista de puntos en el plano
    | Line Path                 -- Representa una línea definida por una lista de puntos en el plano
    | Circle Float              -- Representa un círculo de radio dado
    | ThickCircle Float Float   -- Representa un círculo de radio y grosor dados
    | Arc Float Float Float     -- Representa un arco de círculo definido por un ángulo inicial, un ángulo final y un radio
    | Text String               -- Representa un texto con la fuente y el tamaño de fuente predeterminados
    | Bitmap Int Int ByteString (Int -> Int -> Word32)  -- Representa una imagen de mapa de bits con su ancho, alto, datos de imagen y función de renderizado
    | Pictures [Picture]       -- Representa una lista de imágenes combinadas

    type Path = [(Float, Float)]

    La función pictures toma una lista de imágenes ([miCirculo, miRectangulo] por ej) y las combina en una sola imagen que se puede utilizar como cualquier otra imagen de tipo Picture en Gloss

    Dibujo (constructores de tipo)
    foldDib

    FloatingPic = Vector -> Vector -> Vector -> Picture
    Output a = a -> FloatingPic
-}


-- Interpretación de un dibujo
-- formulas sacadas del enunciado
interp :: Output a -> Output (Dibujo a)
interp = undefined

------------------------
------------------------- Si tomamos Figura = Picture, entonces se pueden reducir usando el tipo FloatingPic
-- Deberiamos definir el "+" "-" "/" "*" para aplicarlas sobre vectores, no?

rotar_interp :: (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura
rotar_interp (f) (x, w, h) = f (x+w, h, -w)

rot45_interp :: (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura
rot45_interp (f) (x, w, h) = f (x+(w+h)/2, (w+h)/2, (h-w)/2)

espejar_interp :: (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura
espejar_interp (f) (x, w, h) = f (x+w, -w, h)

encimar_interp :: (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura
encimar_interp (f, g) (x, w, h) = figuras [f (x, w, h), g(x, w, h)]

juntar_interp :: Float -> Float -> (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura
    where 
        r' :: 
        r' n m = n/(m+n)
        r  = m/(m+n)
        w' = r*w

apilar_interp :: Float -> Float -> (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector -> Figura) -> (Vector -> Vector -> Vector) -> Figura     
apilar_interp (n, m, f, g) (x, w, h) = figuras [f (x + h', w, r*h), g (x, w, h')]
    where 
        r' = n/(m+n)
        r  = m/(m+n)
        w' = r*w

-------------------------
------------------------

-- Configuración de la interpretación
data Conf = Conf {
        name :: String,
        pic :: FloatingPic
    }

interpConf :: Conf -> Float -> Float -> Picture 
interpConf (Conf _ p) x y = p (0, 0) (x,0) (0,y)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial cfg size = do
    let n = name cfg
        win = InWindow n (ceiling size, ceiling size) (0, 0)
    display win white $ withGrid (interpConf cfg size size) size size
    where withGrid p x y = translate (-size/2) (-size/2) 
        $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
            grey = makeColorI 120 120 120 120