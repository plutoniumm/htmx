{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application
    ( appMain, makeFoundation, handler)
where

import Foundation
import ClassyPrelude.Yesod   as Import
import Settings              as Import
import Network.Wai.Handler.Warp             (Settings, defaultSettings,
                                             runSettings, setHost,
                                             setOnException, setPort)

mkYesodDispatch "App" resourcesApp

makeFoundation :: IO App
makeFoundation = do
    appStatic <- staticDevel "static"
    return App {..}

warpSettings :: App -> Settings
warpSettings _ = setPort 3000 $ setHost "localhost" $ setOnException (\_req _e -> return ()) defaultSettings

appMain :: IO ()
appMain = do
    foundation <- makeFoundation
    app <- toWaiApp foundation
    runSettings (warpSettings foundation) app

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "HTMX / Hono (same-thing)"
    $(widgetFile "homepage")


techstack :: [(Text, Text, Text)]
techstack =
    [ ("Haskell", "https://www.haskell.org/", "https://upload.wikimedia.org/wikipedia/commons/1/1c/Haskell-Logo.svg")
    , ("HTMX", "https://htmx.org/", "https://htmx.org/img/htmx_logo.2.png")
    , ("Yesod", "https://www.yesodweb.com/", "https://yesodweb.com/static/logo-home2-no-esod.png")
    ]

getDetailsR :: Handler Html
getDetailsR = do
    let techs = techstack::[(Text, Text, Text)]
    defaultLayout $ do
        setTitle "HTMX / Yesod (same-thing)"
        $(widgetFile "details")

handler :: Handler a -> IO a
handler h = do
    foundation <- makeFoundation
    flip unsafeHandler h foundation