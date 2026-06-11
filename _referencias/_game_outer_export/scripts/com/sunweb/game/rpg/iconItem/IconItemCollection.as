package com.sunweb.game.rpg.iconItem
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   
   public class IconItemCollection extends IconItem
   {
      
      public var subType:int;
      
      public function IconItemCollection(param1:DisplayObject, param2:String)
      {
         super(param1);
         itemCode = param2;
         addType(GameItemType.COLLECTION);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : IconItemCollection
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf____4861(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:IconItemCollection = new IconItemCollection(GameItemManager.getItemIcon(param1),param1);
         _loc4_.itemName = _loc3_.name;
         _loc4_.itemId = param2;
         _loc4_.subType = _loc3_.subtype;
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 220;
         var _loc5_:GameTipUI = new GameTipUI("Items");
         GameItemManager.obf_4_G_4299(_loc3_.name,_loc3_.rank,_loc5_,_loc4_);
         GameItemManager.obf_o_l_1634(_loc3_,_loc5_,_loc4_);
         if(_loc3_.subtype == GameItemSubtype.COLLECTION_GEM)
         {
            _loc6_ = GameItemRank.getRankColor(JSONUtil.getInt(_loc3_,["rank"])).toString(16);
            _loc5_.addTipInfo(DiversityManager.getString("ItemTip","gemType"),_loc4_,_loc5_.maxRow + 1);
            _loc5_.addTipInfo("<P align=\'right\'>" + obf_A_V_935.getGemTypeName(JSONUtil.getInt(_loc3_,["properties","gemType"])) + "</P>",_loc4_,_loc5_.maxRow);
            _loc5_.addTipInfo(DiversityManager.getString("ItemTip","gemLevel"),_loc4_,_loc5_.maxRow + 1);
            _loc5_.addTipInfo("<P align=\'right\'>" + DiversityManager.getString("ItemTip","gemLevelValue",[JSONUtil.getInt(_loc3_,["properties","gemLevel"])]) + "</P>",_loc4_,_loc5_.maxRow);
            _loc5_.addTipInfo("<P align=\'center\'><font color=\'#" + _loc6_ + "\'>" + DiversityManager.getString("ItemTip","gemAttr") + "</font></P>",_loc4_,_loc5_.maxRow + 2);
            _loc7_ = JSONUtil.getObject(_loc3_,["properties","gemAttr"]);
            if(_loc7_)
            {
               for(_loc8_ in _loc7_)
               {
                  _loc5_.addTipInfo("<font color=\'#" + _loc6_ + "\'>" + RoleAttributesModifierEnum.getAttributesName(int(_loc8_)) + "</font>",_loc4_,_loc5_.maxRow + 1);
                  _loc5_.addTipInfo("<P align=\'right\'><font color=\'#" + _loc6_ + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(_loc8_),_loc7_[_loc8_]) + "</font></P>",_loc4_,_loc5_.maxRow);
               }
            }
         }
         _loc5_.addTipInfo(_loc3_.remark,_loc4_,_loc5_.maxRow + 2);
         GameItemManager.obf_7_0_2420(_loc3_,_loc5_,_loc4_);
         GameItemManager.obf_J_l_4537(_loc3_,_loc5_,_loc4_);
         GameItemManager.setItemTipValidTime(param1,param2,_loc5_,_loc4_);
         GameTipManager.showTip(_loc5_);
      }
      
      override public function clone() : IconItem
      {
         var _loc1_:IconItemCollection = getNewIconItem(itemCode,itemId);
         _loc1_.itemCount = this.itemCount;
         return _loc1_;
      }
   }
}

