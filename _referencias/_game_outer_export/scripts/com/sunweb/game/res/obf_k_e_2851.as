package com.sunweb.game.res
{
   public class obf_k_e_2851
   {
      
      public static const obf_n_u_3241:String = "dir";
      
      public static const obf_j_8_1883:String = "lib";
      
      public static const obf_3_N_2143:String = "img";
      
      public static const obf_3_O_4122:String = "mc";
      
      public static const obf_T_M_4234:String = "txt";
      
      public static const obf_9_j_1941:String = "bin";
      
      public static const obf_q_G_2964:String = "prog";
      
      public static const obf_7_R_4482:String = "snd";
      
      public static const obf_i_0_2353:String = "vdo";
      
      private static const ext2type:Object = {
         "lib":obf_j_8_1883,
         "swf":obf_3_O_4122,
         "jpg":obf_3_N_2143,
         "png":obf_3_N_2143,
         "bmp":obf_3_N_2143,
         "gif":obf_3_N_2143,
         "tif":obf_3_N_2143,
         "txt":obf_T_M_4234,
         "inf":obf_T_M_4234,
         "ini":obf_T_M_4234,
         "bin":obf_9_j_1941,
         "wav":obf_7_R_4482,
         "wma":obf_7_R_4482,
         "mp3":obf_7_R_4482
      };
      
      public function obf_k_e_2851()
      {
         super();
      }
      
      public static function getTypeAuto(param1:String) : String
      {
         if(param1 == null || param1 == "")
         {
            return obf_T_M_4234;
         }
         var _loc2_:int = param1.lastIndexOf(".");
         var _loc3_:String = null;
         if(_loc2_ < 0)
         {
            return obf_T_M_4234;
         }
         _loc3_ = param1.substr(_loc2_ + 1).toLowerCase();
         var _loc4_:String = ext2type[_loc3_];
         return _loc4_ == null ? obf_T_M_4234 : _loc4_;
      }
   }
}

