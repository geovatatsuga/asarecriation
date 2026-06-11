package com.sunweb.game.rpg.playingCard
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class BounRuleKind
   {
      
      public static const TWO_NUM:int = 0;
      
      public static const THREE_NUM:int = 1;
      
      public static const CON_NUM:int = 2;
      
      public static const THREE_SUIT_CON_NUM:int = 3;
      
      public static const THREE_SUIT:int = 4;
      
      public static const THREE_FACE:int = 5;
      
      public function BounRuleKind()
      {
         super();
      }
      
      public static function getCardRewardName(param1:int) : String
      {
         return DiversityManager.getString("PlayCardRewardName",param1 + "");
      }
   }
}

