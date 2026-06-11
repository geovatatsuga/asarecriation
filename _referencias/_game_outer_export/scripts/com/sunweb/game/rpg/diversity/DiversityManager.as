package com.sunweb.game.rpg.diversity
{
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import gameFont.FontSettingMC;
   
   public class DiversityManager
   {
      
      private static var diversityStrConfig:Object;
      
      public function DiversityManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         diversityStrConfig = param1;
      }
      
      public static function getRandomName(param1:int) : String
      {
         var _loc2_:Array = getString("CreateRolePage","randomNameSex" + param1 + "_1").split(",");
         var _loc3_:Array = getString("CreateRolePage","randomNameSex" + param1 + "_2").split(",");
         var _loc4_:Array = getString("CreateRolePage","randomNameSex" + param1 + "_3").split(",");
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:String = "";
         if(_loc2_.length > 0)
         {
            _loc5_ = _loc2_[int(Math.random() * _loc2_.length)];
         }
         if(_loc3_.length > 0)
         {
            _loc6_ = _loc3_[int(Math.random() * _loc3_.length)];
         }
         if(_loc4_.length > 0)
         {
            _loc7_ = _loc4_[int(Math.random() * _loc4_.length)];
         }
         return getString("CreateRolePage","randomName",[_loc5_,_loc6_,_loc7_]);
      }
      
      public static function setTextFormat(param1:TextField) : void
      {
         var _loc2_:TextFormat = param1.defaultTextFormat;
         _loc2_.font = getFontStyleName();
         param1.setTextFormat(_loc2_);
      }
      
      public static function getFontStyleName() : String
      {
         return new FontSettingMC().fontStyle.defaultTextFormat.font;
      }
      
      public static function getFontSize() : int
      {
         return JSONUtil.getInt(diversityStrConfig,["FontStyle","fontSize"],12);
      }
      
      public static function addConfig(param1:Object) : void
      {
         var _loc2_:String = null;
         if(!diversityStrConfig || !param1)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            diversityStrConfig[_loc2_] = param1[_loc2_];
         }
      }
      
      public static function getString(param1:String, param2:String, param3:Array = null) : String
      {
         var _loc5_:int = 0;
         if(!diversityStrConfig)
         {
            return "";
         }
         var _loc4_:String = JSONUtil.getStr(diversityStrConfig,[param1,param2]);
         _loc4_ = _loc4_.replace(new RegExp(/\r/g),"");
         _loc4_ = _loc4_.replace(new RegExp(/\t/g),"");
         if(param3)
         {
            _loc5_ = 0;
            while(_loc5_ < param3.length)
            {
               _loc4_ = _loc4_.replace("_%" + _loc5_ + "_",param3[_loc5_]);
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public static function setTextField(param1:TextField, param2:String, param3:String, param4:Array = null, param5:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc6_:String = getString(param2,param3,param4);
         _loc6_ = obf_K_e_3075.getSwitchString(_loc6_);
         param1.htmlText = _loc6_;
         param1.mouseEnabled = param5;
      }
      
      public static function obf_4_9_1545(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc5_:* = undefined;
         var _loc4_:String = getString("RemoteFunction","textCheck");
         if(obf_L_l_4100.isEmpty(_loc4_))
         {
            _loc3_ = false;
         }
         else
         {
            _loc3_ = obf_H_l_800.call(_loc4_,param1);
         }
         if(!param2)
         {
            if(_loc3_ == null || _loc3_ == false)
            {
               return true;
            }
            return false;
         }
         var _loc6_:String = getString("RemoteFunction","textCheck2");
         if(obf_L_l_4100.isEmpty(_loc6_))
         {
            _loc5_ = true;
         }
         else
         {
            _loc5_ = obf_H_l_800.call(_loc6_,param1);
         }
         if(_loc3_ == null && _loc5_ == null)
         {
            return true;
         }
         if(_loc3_ == true || _loc5_ == false)
         {
            return false;
         }
         return true;
      }
   }
}

