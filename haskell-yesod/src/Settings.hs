{-# LANGUAGE CPP               #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}

module Settings where

import ClassyPrelude.Yesod
import Language.Haskell.TH.Syntax  (Exp, Q)
import Yesod.Default.Util          (widgetFileReload)

widgetFile :: String -> Q Exp
widgetFile = widgetFileReload def
