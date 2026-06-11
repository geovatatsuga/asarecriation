package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.genie.ItemPlayerGenieInfo;
   import com.sunweb.game.rpg.genie.obf_P_e_2948;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_l_3_3784 extends IconItem
   {
      
      public function obf_l_3_3784(param1:String, param2:String)
      {
         super(GameItemManager.getItemIcon(param1));
         itemCode = param1;
         itemId = param2;
         addType(GameItemType.obf_N_v_4048);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : obf_l_3_3784
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf___4866(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:obf_l_3_3784 = new obf_l_3_3784(param1,param2);
         _loc4_.itemName = _loc3_.name;
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         _loc4_.iconMask = GameItemCDManager.getCDBitmap(GameItemManager.getItemCDFlag(param1));
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc8_:Object = null;
         var _loc3_:GameTipUI = new GameTipUI("Items");
         var _loc4_:int = 180;
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:GameItemFullInfo = GameItemInfoManager.getItemInfo(param2);
         var _loc7_:ItemPlayerGenieInfo = JSONUtil.getObject(_loc6_,["genieInfo"]) as ItemPlayerGenieInfo;
         if(_loc6_)
         {
            if(_loc7_)
            {
               _loc8_ = obf_P_e_2948.getGenieFinalApt(_loc7_,_loc6_.itemCode);
               _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + GameItemRank.getRankColor(_loc5_.rank).toString(16) + "\'>" + _loc5_.name + "</p>",_loc4_,0);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_Level"),_loc4_,_loc3_.maxRow + 2);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.level + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_PhysicsAttackApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.physicsAttack + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_MagicAttackApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.magicAttack + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_PhysicsDefApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.physicsDef + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_MagicDefApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.magicDef + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_LifeApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.life + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("GenieBoxUI","item_CureApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc8_.cure + "</p>",_loc4_,_loc3_.maxRow);
            }
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(param2);
         }
         _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["remark"]),_loc4_,_loc3_.maxRow + 1);
         GameTipManager.showTip(_loc3_);
      }
      
      override public function set itemCount(param1:int) : void
      {
         super.itemCount = param1;
         countTextVisible = false;
      }
      
      override public function clone() : IconItem
      {
         return getNewIconItem(this.itemCode,this.itemId);
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         var _loc2_:IconItemBag = obf_K_e_3075.petBoxUI.getPetBagById(itemId);
         if(!_loc2_ || !_loc2_.haveIconItem)
         {
            return false;
         }
         return GameContext.bagItemManager.sendUseItem(itemCode,PlayerBagIndex.PLAYER_PET_BAG,_loc2_.itemIndex);
      }
   }
}

