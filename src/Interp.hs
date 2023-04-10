module Interp (
    interp,
    Conf(..),
    interpConf,
    initial
) where

-- Sistema de coordenadas de Gloss: Origen (0.0) = centro de la ventana

import Graphics.Gloss(Picture, Display(InWindow), makeColorI, color, pictures, translate, white, display)
import Dibujo (Dibujo, foldDib, mapDib)
import FloatingPic (FloatingPic, Output, grid)

-- Interpretación de un dibujo
-- formulas sacadas del enunciado

{- 
    type FloatingPic = Vector -> Vector -> Vector -> Picture
    type Output a = a -> FloatingPic
    
    Picture -> Tipo figura pero de Gloss
    Vector -> R^2

    Los tres vectores, indican en que espacio se dibuja
        x + h ------------ x + w + h
        |                 |
        |                 |
        |                 |
        |                 |
        x --------------- x + w
    (0,0)


    Se debe entender a func(f)(x,w,h) como el efecto de interpretar la funcion matematica func (que se corresponde a uno de nuestros CONSTRUCTORES) sobre la figura
    f, en los vectores x,w,h

    Apilar 1.0 1.0 (Figura Triangulo) (Figura Rectangulo)
    

    func = Apilar
    f = Figura ...
    f PRODUCE figuras


    Ejemplo de llamadas

    Operacion                   Semantica
    rotar(f)(x, w, h)           f(x+w, h, -w)
-}

interp :: a -> Vector -> Vector -> Vector -> Picture -> Output (Dibujo a) -- Este lio en vez de poner Output es para poder usar el Picture (dibu) del primero
-- Implementar debajo
interp a x w h dibu = foldDib figura_interp rotar_interp espejar_interp rot45_interp apilar_interp juntar_interp encimar_interp (Picture dibu) 
    where                                                                                                              
        figura_interp :: -- Caso base? Y el caso vacio? O como representamos al vacio?                                 
            a -> FloatingPic
        figura_interp (f) (x, w, h) = f(x, w, h)
        
        rotar_interp :: FloatingPic -> FloatingPic
        rotar_interp (f) (x, w, h) = f(x V.+ w, h, V.negate w) -- cual vendria a ser la f de la funcion interp? 

        espejar_interp :: FloatingPic -> FloatingPic
        espejar_interp (f) (x, w, h) = f(x V.+ w, V.negate w, h)

        rot45_interp :: FloatingPic -> FloatingPic
        rot45_interp (f) (x, w, h) = 
            f(x V.+ half(w V.+ h), half(w V.+ h), half(h V.negate w))

        apilar_interp :: 
            Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic   
        apilar_interp (n, m, f, g) (x, w, h) = 
            figuras [f(x V.+ n/(m V.+ n) V.* h, w, r V.* h), 
                     g(x, w, n/(m V.+ n) V.* h)]

        juntar_interp :: 
            Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
        juntar_interp (n, m, f, g) (x, w, h) = 
            figuras [f(x, r V.* w, h), g(x V.+ r V.* w, n/(m V.+ n) V.* w, h)]

        encimar_interp :: FloatingPic -> FloatingPic -> FloatingPic
        encimar_interp (f, g) (x, w, h) = figuras [f(x, w, h), g(x, w, h)]

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