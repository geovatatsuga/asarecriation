package com.sunweb.game.rpg.wingSpirit
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.worldZone.command.wingSpirit.CommandCodePlayerWingSpirit;
   import com.sunweb.game.rpg.worldZone.command.wingSpirit.PlayerWingSpiritAnswer;
   import com.sunweb.game.rpg.worldZone.command.wingSpirit.PlayerWingSpiritRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class obf_B_5_1274
   {
      
      public static var wingSpiritConfig:Object;
      
      public function obf_B_5_1274()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         wingSpiritConfig = param1;
         var _loc2_:int = getIntValue();
         var _loc3_:Object = getCostItems();
         var _loc4_:Object = getOpenEnvelopItem(2);
      }
      
      public static function getOpenEnvelopItem(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Object = {};
         for each(_loc3_ in wingSpiritConfig.openConfig)
         {
            if(param1 == _loc3_.type)
            {
               _loc2_ = _loc3_.items;
               break;
            }
         }
         return _loc2_;
      }
      
      public static function getIntValue() : int
      {
         return JSONUtil.getInt(wingSpiritConfig,["initSpirit"]);
      }
      
      public static function getMaxValue() : int
      {
         return JSONUtil.getInt(wingSpiritConfig,["maxSpirit"]);
      }
      
      public static function getAddValue() : int
      {
         return JSONUtil.getInt(wingSpiritConfig,["addSpirit"]);
      }
      
      public static function getCostItems() : Object
      {
         return JSONUtil.getObject(wingSpiritConfig,["costItems"]);
      }
      
      public static function getReSet() : Object
      {
         return JSONUtil.getObject(wingSpiritConfig,["reSet"]);
      }
      
      public static function getWingSpiritTipUI(param1:Array, param2:Object) : GameTipUI
      {
         if(param1.length == 0)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_].spiritType < 10)
            {
               _loc3_.push({
                  "left":param1[_loc5_].spiritType,
                  "value":param1[_loc5_]
               });
            }
            else
            {
               _loc4_.push({
                  "right":param1[_loc5_].spiritType,
                  "value":param1[_loc5_]
               });
            }
            _loc5_++;
         }
         var _loc6_:GameTipUI = new GameTipUI("wingSpirit");
         var _loc7_:int = 220;
         _loc3_.sortOn("left",Array.NUMERIC);
         _loc4_.sortOn("right",Array.NUMERIC);
         _loc6_.addTipInfo("<P align=\'center\'><FONT color=\'#FF00FF\'>" + DiversityManager.getString("EquipmentAttribute","wingLeft") + "</FONT></P>",_loc7_,_loc6_.maxRow);
         var _loc8_:int = 0;
         while(_loc8_ < 4)
         {
            if(!_loc3_[_loc8_])
            {
               _loc6_.addTipInfo("<FONT color=\'#666666\'>" + DiversityManager.getString("WingSpiritUI","notOpen") + "</FONT>",_loc7_ + 20,_loc6_.maxRow + 1);
               break;
            }
            _loc6_.addTipInfo("<P align=\'left\'><FONT color=\'#FF00FF\'>" + DiversityManager.getString("WingSpiritUI","wingSpiritName_" + _loc8_) + RoleAttributesModifierEnum.getAttributesName(_loc3_[_loc8_].value.attrType) + "</FONT></P>",_loc7_,_loc6_.maxRow + 1);
            _loc6_.addTipInfo("<P align=\'right\'><FONT color=\'#FF00FF\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc3_[_loc8_].value.attrType,_loc3_[_loc8_].value.attrValue,true) + "</FONT></P>",_loc7_,_loc6_.maxRow);
            _loc6_.addTipInfo("  ",_loc7_,_loc6_.maxRow);
            _loc8_++;
         }
         _loc6_.addTipInfo("  ",_loc7_,_loc6_.maxRow + 1);
         _loc6_.addTipInfo("<P align=\'center\'><FONT color=\'#FF00FF\'>" + DiversityManager.getString("EquipmentAttribute","wingRight") + "</FONT></P>",_loc7_,_loc6_.maxRow);
         var _loc9_:int = 0;
         while(_loc9_ < 4)
         {
            if(!_loc4_[_loc9_])
            {
               _loc6_.addTipInfo("<FONT color=\'#666666\'>" + DiversityManager.getString("WingSpiritUI","notOpen") + "</FONT>",_loc7_ + 20,_loc6_.maxRow + 1);
               break;
            }
            _loc6_.addTipInfo("<P align=\'left\'><FONT color=\'#FF00FF\'>" + DiversityManager.getString("WingSpiritUI","wingSpiritName_" + _loc9_) + RoleAttributesModifierEnum.getAttributesName(_loc4_[_loc9_].value.attrType) + "</FONT></P>",_loc7_,_loc6_.maxRow + 1);
            _loc6_.addTipInfo("<P align=\'right\'><FONT color=\'#FF00FF\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc4_[_loc9_].value.attrType,_loc4_[_loc9_].value.attrValue,true) + "</FONT></P>",_loc7_,_loc6_.maxRow);
            _loc6_.addTipInfo("  ",_loc7_,_loc6_.maxRow);
            _loc9_++;
         }
         _loc6_.addTipInfo("  ",_loc7_,_loc6_.maxRow + 1);
         _loc6_.addTipInfo("<P align=\'center\'><FONT color=\'#FF00FF\'>" + DiversityManager.getString("EquipmentAttribute","wingSpiritSkill") + "</FONT></P>",_loc7_,_loc6_.maxRow);
         _loc6_.addTipObject(getSkillIconDisplay(param2),_loc6_.maxRow);
         return _loc6_;
      }
      
      public static function getSkillIconDisplay(param1:Object) : DisplayObject
      {
         var _loc7_:IconItemSkill = null;
         var _loc8_:String = null;
         var _loc2_:int = 40;
         var _loc3_:Sprite = new Sprite();
         _loc3_.x = 40;
         var _loc4_:Array = new Array();
         var _loc5_:Array = wingSpiritConfig.skillConfig;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = IconItemSkill.getNewIconItem(_loc5_[_loc6_],1);
            if(!_loc7_)
            {
               return null;
            }
            _loc7_.x = (_loc6_ - 1) * _loc2_;
            _loc7_.filters = [obf_9_V_1635.getGrayFilter()];
            _loc7_.itemCount = 1;
            for(_loc8_ in param1)
            {
               if(_loc8_ == _loc5_[_loc6_])
               {
                  _loc7_.itemCount = param1[_loc8_];
                  _loc7_.level = param1[_loc8_];
                  _loc7_.filters = [obf_9_V_1635.getHighLightFilter()];
                  break;
               }
            }
            _loc3_.addChild(_loc7_);
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function sendDoWingSpirit(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:PlayerWingSpiritRequest = new PlayerWingSpiritRequest();
         _loc4_.equipmentId = param1;
         _loc4_.spiritType = param2;
         _loc4_.doType = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerWingSpirit.PLAYER_WING_SPIRIT_ANSWER)
         {
            obf_m_7_4596(param1 as PlayerWingSpiritAnswer);
         }
      }
      
      private static function obf_m_7_4596(param1:PlayerWingSpiritAnswer) : void
      {
         obf_K_e_3075.wingSpiritUI.wingSpiritInfo(param1.equipmentInfo);
         if(param1.doType == 0)
         {
            if(param1.isSucceed)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","succeedWingSpirit"));
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("WingSpiritUI","failWingSpirit"));
            }
         }
      }
   }
}

