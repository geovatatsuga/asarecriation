package com.sunweb.game.utils
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class obf_l_y_733
   {
      
      public static const obf_y_d_1649:int = 1000;
      
      public static const obf_0___a_609:int = obf_y_d_1649 * 60;
      
      public static const MS_PER_HOUR:int = obf_0___a_609 * 60;
      
      public static const obf_1_g_848:int = MS_PER_HOUR * 24;
      
      public function obf_l_y_733()
      {
         super();
      }
      
      public static function getTimeStringSec(param1:Number) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = param1 / obf_1_g_848;
         if(_loc3_ > 0)
         {
            _loc2_ = DiversityManager.getString("TimePrompt","D",[_loc3_]);
            param1 -= _loc3_ * obf_1_g_848;
         }
         var _loc4_:int = param1 / MS_PER_HOUR;
         if(_loc4_ > 0 || _loc2_ != "")
         {
            _loc2_ += DiversityManager.getString("TimePrompt","H",[_loc4_]);
            param1 -= _loc4_ * MS_PER_HOUR;
         }
         var _loc5_:int = param1 / obf_0___a_609;
         if(_loc5_ > 0 || _loc2_ != "")
         {
            _loc2_ += DiversityManager.getString("TimePrompt","M",[_loc5_]);
            param1 -= _loc5_ * obf_0___a_609;
         }
         var _loc6_:Number = param1 / obf_y_d_1649;
         if(_loc6_ > int(_loc6_))
         {
            _loc2_ += DiversityManager.getString("TimePrompt","S",[_loc6_.toFixed(1)]);
         }
         else
         {
            _loc2_ += DiversityManager.getString("TimePrompt","S",[int(_loc6_)]);
         }
         return _loc2_;
      }
      
      public static function getTimeStringMin(param1:Number) : String
      {
         if(param1 < 0)
         {
            return DiversityManager.getString("TimePrompt","M",[0]);
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / obf_1_g_848;
         if(_loc3_ > 0)
         {
            _loc2_ = DiversityManager.getString("TimePrompt","D",[_loc3_]);
            param1 -= _loc3_ * obf_1_g_848;
         }
         var _loc4_:int = param1 / MS_PER_HOUR;
         if(_loc4_ > 0 || _loc2_ != "")
         {
            _loc2_ += DiversityManager.getString("TimePrompt","H",[_loc4_]);
            param1 -= _loc4_ * MS_PER_HOUR;
         }
         var _loc5_:Number = param1 / obf_0___a_609;
         if(_loc5_ >= 1 || _loc2_ != "")
         {
            _loc2_ += DiversityManager.getString("TimePrompt","M",[Math.round(_loc5_)]);
         }
         else
         {
            _loc2_ = DiversityManager.getString("TimePrompt","inadequateOneS");
         }
         return _loc2_;
      }
      
      public static function getTimeStringHour(param1:Number) : String
      {
         if(param1 <= 0)
         {
            return DiversityManager.getString("TimePrompt","H",[0]);
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / obf_1_g_848;
         if(_loc3_ > 0)
         {
            _loc2_ = DiversityManager.getString("TimePrompt","D",[_loc3_]);
            param1 -= _loc3_ * obf_1_g_848;
         }
         var _loc4_:Number = param1 / MS_PER_HOUR;
         if(_loc4_ < 1)
         {
            _loc4_ = 1;
         }
         return _loc2_ + DiversityManager.getString("TimePrompt","H",[Math.round(_loc4_)]);
      }
      
      public static function getTimeStringDay(param1:Number) : String
      {
         if(param1 < 0)
         {
            return DiversityManager.getString("TimePrompt","D",[0]);
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / obf_1_g_848;
         if(_loc3_ > 0)
         {
            _loc2_ = DiversityManager.getString("TimePrompt","D",[_loc3_]);
         }
         else
         {
            _loc2_ = DiversityManager.getString("TimePrompt","inadequateOneD");
         }
         return _loc2_;
      }
      
      public static function getTimeStringHHMMSS(param1:Number) : String
      {
         if(param1 < 1000)
         {
            return "00:00:00";
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / MS_PER_HOUR;
         _loc2_ += obf_L_l_4100.obf_1_m_1767(_loc3_ + "",2,"0") + ":";
         param1 -= _loc3_ * MS_PER_HOUR;
         var _loc4_:int = param1 / obf_0___a_609;
         _loc2_ += obf_L_l_4100.obf_1_m_1767(_loc4_ + "",2,"0") + ":";
         param1 -= _loc4_ * obf_0___a_609;
         return _loc2_ + obf_L_l_4100.obf_1_m_1767(int(param1 / obf_y_d_1649) + "",2,"0");
      }
      
      public static function getTimeStringMM(param1:Number) : int
      {
         return int(param1 / obf_0___a_609);
      }
   }
}

