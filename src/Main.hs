module Main (main) where

import Data.Maybe (fromMaybe)
import System.Console.GetOpt (ArgDescr(..), ArgOrder(..), OptDescr(..), getOpt)
import System.Environment (getArgs)
import Text.Read (readMaybe)
import Interp (Conf(name), initial)
import Dibujos.Ejemplo (ejemploConf)
import Dibujos.Feo (feoConf)
import Dibujos.GrillaNumerada (grillaConf)
import Dibujos.Escher (escherConf)

-- Lista de configuraciones de los dibujos
configs :: [Conf]
configs = [ejemploConf, feoConf, grillaConf, escherConf]

-- Dibuja el dibujo n
initial' :: [Conf] -> String -> IO ()
initial' [] n = do
    putStrLn $ "No hay un dibujo llamado " ++ n
initial' (c : cs) "--lista" =
    do
    putStrLn "Dibujos disponibles: "
    mapM_ (\c -> putStrLn $ "  " ++ name c) configs
    putStrLn "Seleccione el dibujo a imprimir"
    n <- getLine
    initial' configs n
initial' (c : cs) n = 
    if n == name c then
        initial c 400
    else
        initial' cs n

main :: IO ()
main = do
    args <- getArgs
    initial' configs $ head args