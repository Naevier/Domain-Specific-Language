{-# LANGUAGE TupleSections #-}

module Dibujos.GrillaNumerada (
    grillaConf
) where

import Grilla
import Dibujo
import Graphics.Gloss
import Interp (Conf(..), interp)
import FloatingPic (Output, half, zero, grid)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

type Basica = (Int, Int) -- Coordenadas (x,y)

-- Construimos una grilla de tamanio arbitrario
dibujoGrilla :: Int -> [[Dibujo Basica]]
dibujoGrilla x = map makeRow [0,1..n]
    where
    makeRow :: Int -> [Dibujo Basica]
    makeRow y = map (figura . (y,)) [0,1..n]

-- Imprime el dibujo ya construido
grillanum :: Dibujo Basica
grillanum = grilla (dibujoGrilla 7)

interpBas :: Output Basica
interpBas tupla (x, y) _ _ =  translate (x+5) (y+15) $ scale 0.15 0.15 $ text $ show tupla

grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla",
    pic = interp interpBas grillanum
}