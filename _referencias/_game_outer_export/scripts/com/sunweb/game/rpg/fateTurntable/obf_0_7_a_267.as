package com.sunweb.game.rpg.fateTurntable
{
   public class obf_0_7_a_267
   {
      
      public static const obf_0_1_x_502:int = 60;
      
      public static const obf_a_9_2976:int = 120;
      
      public static const obf_R_d_2809:int = 180;
      
      public static const obf_g_H_1437:int = 240;
      
      public static const obf_Z_J_4024:int = 300;
      
      public static const obf_k_7_3654:int = 0;
      
      public function obf_0_7_a_267()
      {
         super();
      }
      
      public static function getDegree(param1:int) : int
      {
         if(param1 == 0)
         {
            return obf_0_1_x_502;
         }
         if(param1 == 1)
         {
            return obf_a_9_2976;
         }
         if(param1 == 2)
         {
            return obf_R_d_2809;
         }
         if(param1 == 3)
         {
            return obf_g_H_1437;
         }
         if(param1 == 4)
         {
            return obf_Z_J_4024;
         }
         if(param1 == 5)
         {
            return obf_k_7_3654;
         }
         return -1;
      }
   }
}

