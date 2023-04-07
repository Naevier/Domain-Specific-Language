module Pred (
    Pred,
    cambiar, anyDib, allDib, orP, andP, foldGen
) where

type Pred a = a -> Bool


{-
En programación funcional estas dos cosas son lo mismo:

f x = algo
y

f = \x -> algo

-}

-- Generalizacion de un fold bool para dibujos
foldGen :: Pred a -> (a -> Bool) -> Dibujo a -> Bool
foldGen pred func dibujo = foldGen (pred dibujo) (pred dibujo) 
            (pred dibujo) (pred dibujo) apilar_juntar apilar_juntar caso_encimar
        where
            apilarJuntar :: (a -> Bool) -> Pred a -> Float -> Float -> Dibujo a -> Dibujo a -> Bool
            apilarJuntar func predicado _ _ dibu1 dibu2 = (func) (predicado dibu1) (predicado dibu2)

            casoEncimar :: (a -> Bool) -> Pred a ->  Dibujo a -> Dibujo a -> Bool
            casoEncimar func predicado dibu1 dibu2 = (func) (predicado dibu1) (predicado dibu2) 

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento
cambiar :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar predicado basica dibujo = if foldGen(esBasica (&&) dibujo) && predicado dibujo then basica else cambiar predicado basica dibujo

esBasica :: Dibujo a -> Bool
esBasica dibu = dibu == Figura 

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred dibujo = foldGen pred (||)

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool 
allDib pred dibu = foldGen pred (&&)  

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem
