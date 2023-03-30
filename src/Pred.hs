module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP
) where

type Pred a = a -> Bool

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento
cambiar :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar predicado basica dibujo = mapDib(\hoja -> if predicado dibujo then basica else hoja)  -- VER

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred dibujo = 
    foldDib (pred dibujo) (pred dibujo) (pred dibujo) (pred dibujo) apilar_juntar apilar_juntar caso_encimar
                    where
                          apilar_juntar :: Pred a -> Float -> Float -> Dibujo a -> Dibujo a -> Bool
                          apilar_juntar predicado _ _ dibu dibu = predicado dibu || predicado dibu

                          caso_encimar :: Pred a -> Dibujo a -> Dibujo a -> Bool
                          caso_encimar predicado dibu1 dibu2 = predicado dibu1 || predicado dibu2

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool 
allDib pred dibu = 
    foldDib (pred dibu) (pred dibu) (pred dibu) (pred dibu) casoDoble casoDoble casoEncimar dibu 
        where casoDoble :: Pred a -> b -> b -> Dibujo a -> Dibujo a -> Bool
              casoDoble pred _ _ dibu1 dibu2 = pred dibu1 && pred dibu2

              casoEncimar :: Pred a -> Dibujo a -> Dibujo a -> Bool
              casoEncimar pred dib1 dib2 = pred dibu1 && pred dibu2

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem
