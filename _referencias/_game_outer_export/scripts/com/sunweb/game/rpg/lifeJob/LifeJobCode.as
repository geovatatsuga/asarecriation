package com.sunweb.game.rpg.lifeJob
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class LifeJobCode
   {
      
      public static const obf_Q_6_3805:int = 1;
      
      public static const obf_0_6_3_148:int = 2;
      
      public static const obf_R_1_2301:int = 3;
      
      public static const obf_C_B_3415:int = 4;
      
      public static const obf_n_4_4571:int = 5;
      
      public function LifeJobCode()
      {
         super();
      }
      
      public static function getLifeJobName(param1:int) : String
      {
         var _loc2_:Object = {
            "0":DiversityManager.getString("LifeJob","none"),
            (obf_Q_6_3805 + ""):DiversityManager.getString("LifeJob","smith"),
            (obf_0_6_3_148 + ""):DiversityManager.getString("LifeJob","tailor"),
            (obf_R_1_2301 + ""):DiversityManager.getString("LifeJob","explorer"),
            (obf_C_B_3415 + ""):DiversityManager.getString("LifeJob","cook"),
            (obf_n_4_4571 + ""):DiversityManager.getString("LifeJob","artificer")
         };
         return _loc2_[param1];
      }
      
      public static function getLifeJobRankName(param1:int) : String
      {
         var _loc2_:Array = [DiversityManager.getString("LifeJob","level_0"),DiversityManager.getString("LifeJob","level_1"),DiversityManager.getString("LifeJob","level_2"),DiversityManager.getString("LifeJob","level_3"),DiversityManager.getString("LifeJob","level_4"),DiversityManager.getString("LifeJob","level_5")];
         if(param1 >= _loc2_.length)
         {
            param1 = 0;
         }
         return _loc2_[param1];
      }
   }
}

