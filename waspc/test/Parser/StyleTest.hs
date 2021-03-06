module Parser.StyleTest where

import           Test.Tasty.Hspec

import           Data.Either      (isLeft)
import qualified Path.Posix       as PPosix

import           Parser.Common    (runWaspParser)
import           Parser.Style     (style)
import qualified StrongPath       as SP
import qualified Wasp.Style


spec_parseStyle :: Spec
spec_parseStyle = do
    it "Parses external code file path correctly" $ do
        runWaspParser style "\"@ext/some/file.css\""
            `shouldBe` Right (Wasp.Style.ExtCodeCssFile (SP.fromPathRelFileP [PPosix.relfile|some/file.css|]))

    it "Parses css closure correctly" $ do
        runWaspParser style "{=css Some css code css=}"
            `shouldBe` Right (Wasp.Style.CssCode "Some css code")

    it "Throws error if path is not external code path." $ do
        isLeft (runWaspParser style "\"some/file.css\"")
            `shouldBe` True
