module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

-- Sistema de coordenadas de Gloss: Origen (0.0) = centro de la ventana

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib, mapDib)
import FloatingPic (FloatingPic, Vecs, Output, grid)

-- Interpretación de un dibujo
-- formulas sacadas del enunciado
interp :: Output a -> Output (Dibujo a)
interp = undefined
    where
        rotar_interp :: FloatingPic -> Vecs -> Figura
        rotar_interp (f) (x, w, h) = f(x V.+ w, h, V.negate w)

        rot45_interp :: FloatingPic -> Vecs -> Figura
        rot45_interp (f) (x, w, h) = 
            f(x V.+ (w V.+ h)/2, (w V.+ h)/2, (h V.negate w)/2)

        espejar_interp :: FloatingPic -> Vecs -> Figura
        espejar_interp (f) (x, w, h) = f(x V.+ w, V.negate w, h)

        encimar_interp :: FloatingPic -> FloatingPic -> Vecs -> Figura
        encimar_interp (f, g) (x, w, h) = figuras [f(x, w, h), g(x, w, h)]

        juntar_interp :: 
            Float -> Float -> FloatingPic -> FloatingPic -> Vecs -> Figura
        juntar_interp (n, m, f, g) (x, w, h) = 
            figuras [f(x, r V.* w, h), g(x V.+ r V.* w, n/(m V.+ n) V.* w, h)]

        apilar_interp :: 
            Float -> Float -> FloatingPic -> FloatingPic -> Vecs -> Figura    
        apilar_interp (n, m, f, g) (x, w, h) = 
            figuras [f(x V.+ n/(m V.+ n) V.* h, w, r V.* h), 
                     g(x, w, n/(m V.+ n) V.* h)]

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