package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_t_v_4376
   {
      
      private static var suitList:Array;
      
      private static var obf_f_q_1341:Object;
      
      public function obf_t_v_4376()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         suitList = param1;
         obf_f_q_1341 = new Object();
         for each(_loc2_ in suitList)
         {
            obf_f_q_1341[_loc2_.suitCode] = _loc2_;
         }
      }
      
      public static function getSuitConfig(param1:String) : Object
      {
         return JSONUtil.getObject(obf_f_q_1341,[param1]);
      }
      
      public static function getPlayerEquipSuit() : Object
      {
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         if(!obf_K_e_3075.playerFullInfoUI)
         {
            return null;
         }
         var _loc1_:Array = [EquipmentKind.WEAPON,EquipmentKind.SHIELD,EquipmentKind.CLOTHES,EquipmentKind.HAT,EquipmentKind.WING,EquipmentKind.HAIR,EquipmentKind.FACE,EquipmentKind.SHOES,EquipmentKind.GLOVE,EquipmentKind.RING,EquipmentKind.AMULET,EquipmentKind.ACCESSORY,EquipmentKind.obf_s_Y_1219,EquipmentKind.FASHION_CLOTHES,EquipmentKind.FASHION_HAT];
         var _loc2_:Object = new Object();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(_loc3_);
            if(!(!_loc4_ || !_loc4_.haveIconItem))
            {
               _loc5_ = GameItemManager.getItemConfig(_loc4_.haveIconItem.itemCode);
               _loc6_ = JSONUtil.getStr(_loc5_,["properties","suitCode"]);
               if(!obf_L_l_4100.isEmpty(_loc6_))
               {
                  if(!_loc2_[_loc6_])
                  {
                     _loc2_[_loc6_] = 1;
                  }
                  else
                  {
                     ++_loc2_[_loc6_];
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public static function getSuitEquipCount(param1:String) : int
      {
         var _loc2_:Object = getSuitConfig(param1);
         return JSONUtil.getInt(_loc2_,["suitPartList","length"]);
      }
      
      public static function getSuitName(param1:String) : String
      {
         return JSONUtil.getStr(getSuitConfig(param1),["suitName"]);
      }
      
      public static function getSuitTipUI(param1:String) : GameTipUI
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:IconItem = null;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc2_:Object = getSuitConfig(param1);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:GameTipUI = new GameTipUI("equipSuit");
         var _loc4_:int = 350;
         _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + obf_0_3_0_538.obf_U_4665.toString(16) + "\'>" + JSONUtil.getStr(_loc2_,["suitName"]) + "　" + DiversityManager.getString("EquipmentSuit","suitTitle") + "</font></p>",_loc4_,0);
         var _loc5_:int = 0;
         for each(_loc6_ in _loc2_.suitPartList)
         {
            _loc8_ = GameItemManager.getItemConfig(_loc6_);
            if(_loc8_)
            {
               _loc9_ = JSONUtil.getInt(_loc8_,["properties","kind"]);
               _loc10_ = null;
               if(obf_K_e_3075.playerFullInfoUI)
               {
                  _loc10_ = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(_loc9_).haveIconItem;
               }
               _loc11_ = null;
               if(_loc10_)
               {
                  _loc11_ = GameItemManager.getItemConfig(_loc10_.itemCode);
               }
               if(Boolean(_loc11_) && JSONUtil.getStr(_loc11_,["properties","suitCode"]) == param1)
               {
                  _loc3_.addTipInfo("<font color=\'#00FF00\'>" + _loc11_.name + "</font>",_loc4_,_loc3_.maxRow + 1);
                  _loc5_++;
               }
               else
               {
                  _loc3_.addTipInfo("<font color=\'#BBBBBB\'>" + _loc8_.name + "</font>",_loc4_,_loc3_.maxRow + 1);
               }
            }
         }
         _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + obf_0_3_0_538.obf_U_4665.toString(16) + "\'>" + DiversityManager.getString("EquipmentSuit","suitAttr") + "</font></p>",_loc4_,_loc3_.maxRow + 1);
         for each(_loc7_ in _loc2_.suitResultList)
         {
            if(_loc7_)
            {
               _loc12_ = _loc5_ >= _loc7_.partNum ? obf_0_3_0_538.obf_U_4665.toString(16) : "BBBBBB";
               if(_loc7_.resultAttr)
               {
                  for(_loc13_ in _loc7_.resultAttr)
                  {
                     _loc3_.addTipInfo("<font color=\'#" + _loc12_ + "\'>" + DiversityManager.getString("EquipmentSuit","partNum",[_loc7_.partNum]) + RoleAttributesModifierEnum.getAttributesName(int(_loc13_)) + "</font>",_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'><font color=\'#" + _loc12_ + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(_loc13_),_loc7_.resultAttr[_loc13_]) + "</font></P>",_loc4_,_loc3_.maxRow);
                  }
               }
            }
         }
         _loc3_.addTipInfo(JSONUtil.getStr(_loc2_,["suitDetail"]),_loc4_,_loc3_.maxRow + 2);
         return _loc3_;
      }
   }
}

