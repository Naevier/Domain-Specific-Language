module Pred (
    Pred,
    cambiar, anyDib, allDib, orP, andP, foldGen
) where

-- import Dibujo (Dibujo, mapDib)

type Pred a = a -> Bool

-- Generalizacion de un fold a bool para dibujos
auxiliarAnyAll :: Pred a -> (a -> Bool) -> Dibujo a -> Bool
auxiliarAnyAll pred func dibujo = foldGen (pred dibujo) (pred dibujo) 
            (pred dibujo) (pred dibujo) apilar_juntar apilar_juntar caso_encimar
        where
            apilarJuntar :: (a -> Bool) -> Pred a -> Float -> Float -> Dibujo a -> Dibujo a -> Bool
            apilarJuntar func predicado _ _ dibu1 dibu2 = func (predicado dibu1) (predicado dibu2)

            casoEncimar :: (a -> Bool) -> Pred a ->  Dibujo a -> Dibujo a -> Bool
            casoEncimar func predicado dibu1 dibu2 = func (predicado dibu1) (predicado dibu2) 

-- Cambio de figura básica por otra figura basica
cambioBasica :: Dibujo a -> a -> Dibujo a
cambioBasica (Figura a) basica = Figura basica

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento
-- Generalizada para aplicar cualquier funcion al 
-- encontrar una basica que cumpla el predicado
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar predicado cambioBasica dibujo = mapDib(if predicado dibujo then cambioBasica dibujo else dibujo) dibujo

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred dibujo = auxiliarAnyAll pred (||)
-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool 
allDib pred dibu = auxiliarAnyAll pred (&&)  

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem

