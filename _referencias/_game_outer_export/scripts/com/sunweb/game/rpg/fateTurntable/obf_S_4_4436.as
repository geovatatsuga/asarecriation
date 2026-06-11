package com.sunweb.game.rpg.fateTurntable
{
   public class obf_S_4_4436
   {
      
      public static const obf_p_h_4377:int = 90;
      
      public static const obf_1_U_1095:int = 180;
      
      public static const obf_9_q_2688:int = 270;
      
      public static const DEGREE10:int = 0;
      
      public function obf_S_4_4436()
      {
         super();
      }
      
      public static function getDegree(param1:int) : int
      {
         if(param1 == 0)
         {
            return obf_p_h_4377;
         }
         if(param1 == 1)
         {
            return obf_1_U_1095;
         }
         if(param1 == 2)
         {
            return obf_9_q_2688;
         }
         if(param1 == 3)
         {
            return DEGREE10;
         }
         return -1;
      }
   }
}

