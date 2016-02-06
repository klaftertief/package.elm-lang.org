module Page.Context where

import Http
import Task
import Docs.Package as Docs
import Utils.Path exposing ((</>))


type alias OverviewContext =
  { user : String
  , project : String
  , versions : List String
  }


type alias VersionContext =
    { user : String
    , project : String
    , version : String
    , allVersions : List String
    , moduleName : Maybe String
    }


getReadme : VersionContext -> Task.Task Http.Error String
getReadme context =
  Http.getString (pathTo context "README.md")


getDocs : VersionContext -> Task.Task Http.Error Docs.Package
getDocs context =
  Http.get Docs.decodePackage (pathTo context "documentation.json")


pathTo : VersionContext -> String -> String
pathTo {user,project,version} file =
  "https://crossorigin.me/http://package.elm-lang.org/packages" </> user </> project </> version </> file