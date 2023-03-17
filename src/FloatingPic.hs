module FloatingPic (
    FloatingPic, Output,
    zero, half,
    hlines, grid,
    vacia
) where
    
import Graphics.Gloss
    (Vector, Picture, blank, line, pictures, rotate, scale, translate)
import Graphics.Gloss.Data.Vector (argV, magV)
import Graphics.Gloss.Geometry.Angle (radToDeg)

import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Definiciones auxiliares para imprimir en pantalla.

type FloatingPic = Vector -> Vector -> Vector -> Picture
type Output a = a -> FloatingPic

-- el vector nulo
zero :: Vector
zero = (0,0)

half :: Vector -> Vector
half = (0.5 V.*)

-- Infinitas lineas paralelas horizontales
-- Desde (x, y) para arriba con un largo de mag
hlines :: Vector -> Float -> Float -> [Picture]
hlines (x, y) mag sep = map hline [0,sep..]
    where hline h = line [(x, y + h), (x + mag, y + h)]

-- Una grilla de n líneas, comenzando en v con una separación de sep y
-- una longitud de l (usamos composición para no aplicar este
-- argumento)
grid :: Int -> Vector -> Float -> Float -> Picture
grid n v sep l = pictures [ls, translate 0 (l*toEnum n) (rotate 90 ls)]
    where ls = pictures $ take (n+1) $ hlines v sep l

vacia :: FloatingPic
vacia _ _ _ = blank
