module Bench.Extension where

import Protolude

import Control.Monad.Random
import Criterion.Main
import Data.Field.Galois.Extension

import Bench.Galois
import Bench.Prime

data Pu
instance IrreducibleMonic Fq Pu where
  split _ = X2 + 1
type Fq2 = Extension Fq Pu

data Pv
instance IrreducibleMonic Fq2 Pv where
  split _ = X3 - 9 - Y X
type Fq6 = Extension Fq2 Pv

data Pw
instance IrreducibleMonic Fq6 Pw where
  split _ = X2 - Y X
type Fq12 = Extension Fq6 Pw

fq12 :: Fq12
fq12 = evalRand getRandom $ mkStdGen 0

fq12' :: Fq12
fq12' = evalRand getRandom $ mkStdGen 1

benchmarkExtension :: Benchmark
benchmarkExtension = benchmark "Extension" fq12 fq12'
