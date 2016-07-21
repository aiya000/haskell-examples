import Lib
import Test.Hspec

main :: IO ()
main = do
  hspec testShowCardSmartly
  hspec testShowCardSuitsSmartly

testShowCardNumbersSmartly :: Spec
testShowCardNumbersSmartly = do
  describe "Show Card number" $ do
    it "14" $
      show (Card 14 Hearts) `shouldBe` "HA_"
    it "13" $
      show (Card 13 Hearts) `shouldBe` "HK_"
    it "12" $
      show (Card 12 Hearts) `shouldBe` "HQ_"
    it "11" $
      show (Card 11 Hearts) `shouldBe` "HJ_"
    it "10" $
      show (Card 10 Hearts) `shouldBe` "H10"
    it "9 is simply" $
      show (Card 9  Hearts) `shouldBe` "H9_"
