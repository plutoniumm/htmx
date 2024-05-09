{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE InstanceSigs #-}

module Foundation where

import ClassyPrelude.Yesod   as Import
import Settings              as Import
import Text.Hamlet                 (hamletFile)
import Text.Jasmine                (minifym)
import Yesod.Default.Util          (addStaticContentExternal)
import qualified Yesod.Core.Unsafe as Unsafe

data App = App {
    appStatic      :: Static
}

mkYesodData "App" $(parseRoutesFile "src/routes.yesodroutes")

instance Yesod App where
    makeSessionBackend _ = return Nothing

    defaultLayout :: Widget -> Handler Html
    defaultLayout widget = do
        pc <- widgetToPageContent $ do
            $(widgetFile "default-layout")
        withUrlRenderer $(hamletFile "templates/default-layout-wrapper.hamlet")

    addStaticContent:: Text
        -> Text -- ^ The MIME content type
        -> LByteString -- ^ The contents of the file
        -> Handler (Maybe (Either Text (Route App, [(Text, Text)])))
    addStaticContent ext mime content = do
        addStaticContentExternal
            minifym
            genFileName
            "static"
            (StaticR . flip StaticRoute [])
            ext
            mime
            content
        where genFileName lbs = "autogen-" ++ base64md5 lbs

unsafeHandler :: App -> Handler a -> IO a
unsafeHandler = Unsafe.fakeHandlerGetLogger undefined
