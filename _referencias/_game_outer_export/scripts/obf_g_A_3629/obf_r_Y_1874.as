package obf_g_A_3629
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   
   public class obf_r_Y_1874
   {
      
      private static var obf_Q_p_2862:Array;
      
      private static var obf_8_I_1389:Array = new Array();
      
      private static var obf_l_X_2826:Object = new Object();
      
      private static var specialExp:RegExp = /[@^!$%&*+\=?|\/`.。、（）—…￥·！《》〈〉 ]/g;
      
      public function obf_r_Y_1874()
      {
         super();
      }
      
      public static function isUnlawful(param1:String, param2:Boolean = false) : Boolean
      {
         if(!DiversityManager.obf_4_9_1545(param1,param2))
         {
            return true;
         }
         return param1 != replaceText(param1);
      }
      
      public static function isReplaceText(param1:String) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         var _loc4_:int = 0;
         if(obf_L_l_4100.isEmpty(param1))
         {
            return false;
         }
         for each(_loc2_ in obf_Q_p_2862)
         {
            if(!obf_L_l_4100.isEmpty(_loc2_))
            {
               _loc3_ = new RegExp(_loc2_,"i");
               _loc4_ = 0;
               while(_loc4_ > -1)
               {
                  _loc4_ = param1.search(_loc3_);
                  if(_loc4_ > -1)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function replaceText(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         var _loc4_:int = 0;
         if(obf_L_l_4100.isEmpty(param1))
         {
            return param1;
         }
         for each(_loc2_ in obf_Q_p_2862)
         {
            if(!obf_L_l_4100.isEmpty(_loc2_))
            {
               _loc3_ = new RegExp(_loc2_,"i");
               _loc4_ = 0;
               while(_loc4_ > -1)
               {
                  _loc4_ = param1.search(_loc3_);
                  if(_loc4_ > -1)
                  {
                     param1 = param1.replace(_loc3_,obf_L_l_4100.repeat("*",_loc2_.length));
                  }
               }
            }
         }
         return param1;
      }
      
      public static function obf_y_Q_3915(param1:String) : String
      {
         var _loc5_:String = null;
         var _loc2_:String = param1;
         param1 = ">" + param1 + "<";
         var _loc3_:RegExp = />(.*?)</ig;
         var _loc4_:Object = _loc3_.exec(param1);
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_[1];
            _loc2_ = _loc2_.replace(_loc5_,replaceText(_loc5_));
            _loc4_ = _loc3_.exec(param1);
         }
         return _loc2_;
      }
      
      public static function init(param1:Array) : void
      {
         obf_Q_p_2862 = param1;
      }
      
      public static function obf_l_O_3830(param1:Array) : void
      {
         obf_Q_p_2862 = obf_Q_p_2862.concat(param1);
      }
      
      private static function loopFirstWord(param1:String, param2:Boolean) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:RegExp = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param2 == false)
         {
            _loc6_ = 0;
            while(_loc6_ < obf_8_I_1389.length)
            {
               _loc3_ = obf_8_I_1389[_loc6_];
               _loc4_ = param1.search(new RegExp(_loc3_,"i"));
               if(_loc4_ != -1)
               {
                  for(_loc7_ in obf_l_X_2826[_loc3_])
                  {
                     _loc4_ = param1.search(new RegExp(_loc3_,"i"));
                     if(obf_l_X_2826[_loc3_][_loc7_] == param1.slice(_loc4_,_loc4_ + obf_l_X_2826[_loc3_][_loc7_].length))
                     {
                        _loc5_ = new RegExp(obf_l_X_2826[_loc3_][_loc7_],"ig");
                        param1 = param1.replace(_loc5_,getStar);
                     }
                  }
               }
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < obf_8_I_1389.length)
            {
               _loc3_ = obf_8_I_1389[_loc6_];
               _loc4_ = param1.search(new RegExp(_loc3_,"i"));
               if(_loc4_ != -1)
               {
                  for(_loc7_ in obf_l_X_2826[_loc3_])
                  {
                     _loc4_ = param1.search(new RegExp(_loc3_,"i"));
                     _loc8_ = param1.substring(0,_loc4_);
                     _loc9_ = param1.substring(_loc4_);
                     _loc9_ = _loc9_.replace(specialExp,"");
                     if(obf_l_X_2826[_loc3_][_loc7_] == _loc9_.slice(0,obf_l_X_2826[_loc3_][_loc7_].length))
                     {
                        _loc5_ = new RegExp(obf_l_X_2826[_loc3_][_loc7_],"ig");
                        param1 = _loc8_ + _loc9_.replace(_loc5_,getStar);
                     }
                  }
               }
               _loc6_++;
            }
         }
         return param1;
      }
      
      private static function getStar() : String
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         _loc2_ = arguments[0].length;
         _loc3_ = "";
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += "*";
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function loopString(param1:String, param2:Boolean) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:RegExp = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param2 == false)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc3_ = param1.charAt(_loc6_);
               if(obf_l_X_2826[_loc3_] != undefined)
               {
                  for(_loc7_ in obf_l_X_2826[_loc3_])
                  {
                     _loc4_ = param1.search(new RegExp(_loc3_,"i"));
                     if(obf_l_X_2826[_loc3_][_loc7_] == param1.slice(_loc4_,_loc4_ + obf_l_X_2826[_loc3_][_loc7_].length))
                     {
                        _loc5_ = new RegExp(obf_l_X_2826[_loc3_][_loc7_],"ig");
                        param1 = param1.replace(_loc5_,getStar);
                     }
                  }
               }
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc3_ = param1.charAt(_loc6_);
               if(obf_l_X_2826[_loc3_] != undefined)
               {
                  for(_loc7_ in obf_l_X_2826[_loc3_])
                  {
                     _loc4_ = param1.search(new RegExp(_loc3_,"i"));
                     _loc8_ = param1.substring(0,_loc4_);
                     _loc9_ = param1.substring(_loc4_);
                     _loc9_ = _loc9_.replace(specialExp,"");
                     if(obf_l_X_2826[_loc3_][_loc7_] == _loc9_.slice(0,obf_l_X_2826[_loc3_][_loc7_].length))
                     {
                        _loc5_ = new RegExp(obf_l_X_2826[_loc3_][_loc7_],"ig");
                        param1 = _loc8_ + _loc9_.replace(_loc5_,getStar);
                     }
                  }
               }
               _loc6_++;
            }
         }
         return param1;
      }
   }
}

