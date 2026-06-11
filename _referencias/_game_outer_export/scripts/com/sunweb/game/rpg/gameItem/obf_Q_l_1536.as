package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class obf_Q_l_1536
   {
      
      public static const obf_4_f_1867:int = 0;
      
      public static const obf_0_7_5_67:int = 1;
      
      public static const obf_O_H_1894:int = 2;
      
      public static const obf_9_854:int = 3;
      
      public static const obf_6_Q_2294:int = 4;
      
      public static const obf_e_b_2015:int = 5;
      
      private static const _qualityMulList:Array = [1,0.9,0.95,1,1.05,1.1];
      
      public function obf_Q_l_1536()
      {
         super();
      }
      
      public static function getItemQualityName(param1:int) : String
      {
         return DiversityManager.getString("ItemQualityPrompt",param1 + "");
      }
      
      public static function getQualityMul(param1:int) : Number
      {
         return _qualityMulList[param1];
      }
   }
}

