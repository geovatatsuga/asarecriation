package com.sunweb.game.net.framework.codec.diy
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   
   public class obf_O_8_1034 extends obf_2_M_853 implements obf_C_m_1350
   {
      
      public static var obf_J_T_4092:int = 0;
      
      private var _code:int;
      
      public function obf_O_8_1034(param1:int)
      {
         super();
         this._code = param1;
      }
      
      public function get code() : int
      {
         return this._code;
      }
      
      public function getCompressThreshold() : int
      {
         return obf_J_T_4092;
      }
      
      public function getDigestKey() : int
      {
         return 0;
      }
   }
}

