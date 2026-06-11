package com.sunweb.game.rpg.fateTurntable
{
   public class obf_y_I_905
   {
      
      public static const DEGREE11:int = 240;
      
      public static const obf_n_P_1713:int = 120;
      
      public static const obf_2_C_1844:int = 0;
      
      public function obf_y_I_905()
      {
         super();
      }
      
      public static function getDegree(param1:int) : int
      {
         if(param1 == 0)
         {
            return DEGREE11;
         }
         if(param1 == 1)
         {
            return obf_n_P_1713;
         }
         if(param1 == 2)
         {
            return obf_2_C_1844;
         }
         return -1;
      }
   }
}

