package com.sunweb.game.rpg.stirp
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.stirp.CommandCodeStirp;
   import com.sunweb.game.rpg.worldZone.command.stirp.StirpLvUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.stirp.StirpLvUpRequest;
   import com.sunweb.game.rpg.worldZone.command.stirp.StirpPotentialRequest;
   import com.sunweb.game.rpg.worldZone.command.stirp.StirpPotentialValueNotify;
   import com.sunweb.game.utils.JSONUtil;
   import flash.utils.ByteArray;
   
   public class obf_x_B_2963
   {
      
      private static var stirpConfig:Object;
      
      public static var buleAttrArr:Array = new Array();
      
      public static var redAttrArr:Array = new Array();
      
      public function obf_x_B_2963()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         stirpConfig = param1;
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(stirpConfig,rest);
      }
      
      public static function getStirpLvUpConfig() : Object
      {
         return getConfigValue("stirpLevels");
      }
      
      private static function getOpenCondition() : Object
      {
         return getConfigValue("openStirpCondition");
      }
      
      public static function getStirpBlueStar() : int
      {
         return 9;
      }
      
      public static function getStirpObject(param1:int) : Object
      {
         var _loc2_:Array = getStirpLvUpConfig() as Array;
         if(!_loc2_)
         {
            return null;
         }
         if(param1 < 1)
         {
            return null;
         }
         if(param1 > _loc2_.length)
         {
            return null;
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getRoleAttributesInfo() : void
      {
         var _loc6_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:Object = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc1_:int = GameContext.localPlayer.fullInfo.stirpLevel;
         var _loc2_:int = GameContext.localPlayer.fullInfo.potentialLevel;
         if(_loc1_ <= 0)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_ - 1)
         {
            _loc6_ = JSONUtil.getObject(getStirpObject(_loc3_ + 1),["stirpPotential"]) as Array;
            _loc7_ = JSONUtil.getNumber(getStirpObject(_loc3_ + 2),["stirpExalt"]);
            if(!_loc6_)
            {
               break;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               _loc9_ = JSONUtil.getObject(_loc6_[_loc8_],["addAttr"]) as Array;
               for each(_loc10_ in _loc9_)
               {
                  obf_e_F_3512(JSONUtil.getInt(_loc10_,["attr"]),JSONUtil.getNumber(_loc10_,["value"]) * (1 + _loc7_));
               }
               _loc8_++;
            }
            _loc3_++;
         }
         var _loc4_:Array = JSONUtil.getObject(getStirpObject(_loc1_),["stirpPotential"]) as Array;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc11_ = JSONUtil.getObject(_loc4_[_loc5_],["addAttr"]) as Array;
            for each(_loc12_ in _loc11_)
            {
               obf_5_q_2930(JSONUtil.getInt(_loc12_,["attr"]),JSONUtil.getNumber(_loc12_,["value"]));
            }
            _loc5_++;
         }
      }
      
      public static function obf_P_i_4116(param1:int) : void
      {
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc2_:Array = JSONUtil.getObject(getStirpObject(param1 - 1),["stirpPotential"]) as Array;
         var _loc3_:Number = JSONUtil.getNumber(getStirpObject(param1),["stirpExalt"]);
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = JSONUtil.getObject(_loc2_[_loc4_],["addAttr"]) as Array;
            for each(_loc6_ in _loc5_)
            {
               obf_e_F_3512(JSONUtil.getInt(_loc6_,["attr"]),JSONUtil.getNumber(_loc6_,["value"]) * (1 + _loc3_));
            }
            _loc4_++;
         }
      }
      
      public static function obf_x_6_4254(param1:int, param2:int) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Array = JSONUtil.getObject(getStirpObject(param1),["stirpPotential"]) as Array;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Array = JSONUtil.getObject(_loc3_[param2 - 1],["addAttr"]) as Array;
         for each(_loc5_ in _loc4_)
         {
            obf_5_q_2930(JSONUtil.getInt(_loc5_,["attr"]),JSONUtil.getNumber(_loc5_,["value"]));
         }
      }
      
      public static function get allRoleAttrArr() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = new Array();
         _loc1_ = clone(buleAttrArr) as Array;
         for each(_loc2_ in redAttrArr)
         {
            _loc3_ = false;
            _loc4_ = new Object();
            for each(_loc5_ in _loc1_)
            {
               if(_loc5_.attr == _loc2_.attr)
               {
                  _loc5_.value += _loc2_.value;
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               _loc4_["attr"] = _loc2_.attr;
               _loc4_["value"] = _loc2_.value;
               _loc1_.push(_loc4_);
            }
         }
         return _loc1_;
      }
      
      private static function clone(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function obf_e_F_3512(param1:int, param2:Number) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = new Object();
         for each(_loc5_ in buleAttrArr)
         {
            if(_loc5_.attr == param1)
            {
               _loc5_.value += param2;
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            _loc4_["attr"] = param1;
            _loc4_["value"] = param2;
            buleAttrArr.push(_loc4_);
         }
      }
      
      public static function obf_5_q_2930(param1:int, param2:Number) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = new Object();
         for each(_loc5_ in redAttrArr)
         {
            if(_loc5_.attr == param1)
            {
               _loc5_.value += param2;
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            _loc4_["attr"] = param1;
            _loc4_["value"] = param2;
            redAttrArr.push(_loc4_);
         }
      }
      
      public static function getRedAttributesInfo(param1:int) : Array
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = GameContext.localPlayer.fullInfo.stirpLevel;
         var _loc4_:Array = JSONUtil.getObject(getStirpObject(_loc3_),["stirpPotential"]) as Array;
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:Array = JSONUtil.getObject(_loc4_[param1],["addAttr"]) as Array;
         for each(_loc6_ in _loc5_)
         {
            _loc7_ = new Object();
            _loc7_["attr"] = JSONUtil.getInt(_loc6_,["attr"]);
            _loc7_["value"] = JSONUtil.getNumber(_loc6_,["value"]);
            _loc2_.push(_loc7_);
         }
         return _loc2_;
      }
      
      public static function getBuleAttributesInfo(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = GameContext.localPlayer.fullInfo.stirpLevel;
         if(_loc3_ < getStirpBlueStar() + 2)
         {
            _loc4_ = 0;
         }
         else if(_loc3_ % (getStirpBlueStar() + 1) > 0)
         {
            _loc4_ = _loc3_ / (getStirpBlueStar() + 1);
         }
         else
         {
            _loc4_ = _loc3_ / (getStirpBlueStar() + 1) - 1;
         }
         var _loc5_:int = _loc4_ * (getStirpBlueStar() + 1);
         var _loc6_:Array = JSONUtil.getObject(getStirpObject(param1 + 1 + _loc5_),["stirpPotential"]) as Array;
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_:Number = JSONUtil.getNumber(getStirpObject(param1 + 2 + _loc5_),["stirpExalt"]);
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc9_ = JSONUtil.getObject(_loc6_[_loc8_],["addAttr"]) as Array;
            for each(_loc10_ in _loc9_)
            {
               _loc11_ = new Object();
               _loc11_["attr"] = JSONUtil.getInt(_loc10_,["attr"]);
               _loc11_["value"] = JSONUtil.getNumber(_loc10_,["value"]) * (1 + _loc7_);
               _loc2_.push(_loc11_);
            }
            _loc8_++;
         }
         return _loc2_;
      }
      
      public static function sendStirpLvs(param1:Boolean) : void
      {
         var _loc2_:StirpLvUpRequest = new StirpLvUpRequest();
         _loc2_.isStirpLvUp = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function checkOpenStirp() : Boolean
      {
         var _loc1_:Object = getConfigValue("openStirpCondition");
         if(!ConditionScript.checkCondition(_loc1_,null,true))
         {
            return false;
         }
         if(GameContext.localPlayer.fullInfo.stirpLevel <= 0)
         {
            sendStirpPotential(false,0);
         }
         return true;
      }
      
      public static function sendStirpPotential(param1:Boolean, param2:int) : void
      {
         var _loc3_:StirpPotentialRequest = new StirpPotentialRequest();
         _loc3_.isStirpLvUp = param1;
         _loc3_.stirpLevel = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         var _loc2_:StirpLvUpAnswer = null;
         var _loc3_:StirpPotentialValueNotify = null;
         if(param1.code == CommandCodeStirp.PLAYER_STIRP_LVUP_ANSWER)
         {
            _loc2_ = param1 as StirpLvUpAnswer;
            GameContext.localPlayer.fullInfo.stirpLevel = _loc2_.stirpLevel;
            GameContext.localPlayer.fullInfo.potentialLevel = _loc2_.potentialLevel;
            GameContext.localPlayer.fullInfo.potentialValue = _loc2_.potentialValue;
            obf_K_e_3075.stirpBoxUI.refurbishStirp(_loc2_.isStirpLvUp,_loc2_.isBuleLvUp,true);
         }
         else if(param1.code == CommandCodeStirp.PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY)
         {
            _loc3_ = param1 as StirpPotentialValueNotify;
            GameContext.localPlayer.fullInfo.potentialValue = _loc3_.potentialValue;
            obf_K_e_3075.stirpBoxUI.setPotentialNum(_loc3_.potentialValue);
         }
      }
   }
}

