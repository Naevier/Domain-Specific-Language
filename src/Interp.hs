module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

import Graphics.Gloss
import Dibujo
import FloatingPic (FloatingPic, Output, half, grid)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

{- -- Version pattern-matching sin usar foldDib
interp :: Output a -> Output (Dibujo a)
interp f (Figura a) = f a
interp f (Rotar a) = rotarInterp (interp f a)
interp f (Rot45 a) = rotar45interp (interp f a)
interp f (Espejar a) = espejarInterp (interp f a)
interp f (Apilar x y a b) = apilarInterp x y (interp f a) (interp f b)
interp f (Juntar x y a b) = juntarInterp x y (interp f a) (interp f b)
interp f (Encimar a b) = encimarInterp (interp f a) (interp f b)
-}

interp :: Output a -> Output (Dibujo a) 
interp output = foldDib output rotarInterp espejarInterp rotar45interp apilarInterp juntarInterp encimarInterp

rotarInterp :: FloatingPic -> FloatingPic
rotarInterp f x w h = f (x V.+ w) h (V.negate w)

rotar45interp :: FloatingPic -> FloatingPic
rotar45interp f x w h = 
    f (x V.+ half(w V.+ h)) (half (w V.+ h)) (half (h V.- w))

espejarInterp :: FloatingPic -> FloatingPic
espejarInterp f x w = f (x V.+ w) (V.negate w)

apilarInterp :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
apilarInterp n m f g x w h = pictures [f (x V.+ h') w (r V.* h), g x w h']
    where 
        r' = n/(m+n)
        r = m/(m+n)
        h' = r' V.* h

juntarInterp :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
juntarInterp n m f g x w h = pictures [f x w' h, g (x V.+ w') (r' V.* w) h]
    where 
        r' = n/(m+n)
        r = m/(m+n)
        w' = r V.* w

encimarInterp :: FloatingPic -> FloatingPic -> FloatingPic
encimarInterp f g x w h = pictures [f x w h, g x w h]

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