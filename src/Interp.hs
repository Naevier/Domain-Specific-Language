module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

-- Sistema de coordenadas de Gloss: Origen (0.0) = centro de la ventana

import Graphics.Gloss(Picture, Display(InWindow), Vector, makeColorI, color, pictures, translate, white, display)
import Dibujo
import FloatingPic (FloatingPic, Output, half, grid)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

{-
interp :: a -> Vector -> Vector -> Vector -> Picture -> Dibujo a -> Output (Dibujo a) 
interp a v1 v2 v3 pic dib = foldDib id rotinterp espinterp rot45interp apinterp juntinterp encinterp dib
    where 
-}

-- Cambios en import Dibujo (esta bien?)
-- Cambio en export de Dibujo.hs (esta bien?)
-- Funcion interp sin usar foldDib (baja puntos)
-- Ver cambio en consigna de funciones _lado_ y _esquina_ que comentaron en Zulip (corregir del kickstart)

interp :: Output a -> Output (Dibujo a)
interp f (Figura a) = f a
interp f (Rotar a) = rotinterp (interp f a)
interp f (Rot45 a) = rot45interp (interp f a)
interp f (Espejar a) = espinterp (interp f a)
interp f (Apilar x y a b) = apinterp x y (interp f a) (interp f b)
interp f (Juntar x y a b) = juntinterp x y (interp f a) (interp f b)
interp f (Encimar a b) = encinterp (interp f a) (interp f b)

rotinterp :: FloatingPic -> FloatingPic
rotinterp f x w h = f (x V.+ w) h (V.negate w)

espinterp :: FloatingPic -> FloatingPic
espinterp f x w h = f (x V.+ w) (V.negate w) h

rot45interp :: FloatingPic -> FloatingPic
rot45interp f x w h = f (x V.+ half(w V.+ h)) (half (w V.+ h)) (half (h V.- w))

apinterp :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic   
apinterp n m f g x w h = pictures [f (x V.+ h') w (r V.* h), g x w h']
    where 
        r = n/(n+m)
        r' = m/(n+m)
        h' = r' V.* h

juntinterp :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
juntinterp n m f g x w h = pictures [f x w' h, g (x V.+ w') (r' V.* w) h]
    where 
        r' = m/(n+m)
        r = n/(n+m)
        w' = r V.* w

encinterp :: FloatingPic -> FloatingPic -> FloatingPic
encinterp f g x w h = pictures [f x w h, g x w h]

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
    where 
        withGrid p x y = translate (-size/2) (-size/2) $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10] 
        grey = makeColorI 120 120 120 120