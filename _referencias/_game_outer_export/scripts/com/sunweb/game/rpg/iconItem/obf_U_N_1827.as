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
   import com.sunweb.game.rpg.pet.ItemPlayerPetInfo;
   import com.sunweb.game.rpg.pet.PetKind;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.MonsterSpecies;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_U_N_1827 extends IconItem
   {
      
      public function obf_U_N_1827(param1:String, param2:String)
      {
         super(GameItemManager.getItemIcon(param1));
         itemCode = param1;
         itemId = param2;
         addType(GameItemType.PET);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : obf_U_N_1827
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf___4866(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:obf_U_N_1827 = new obf_U_N_1827(param1,param2);
         _loc4_.itemName = _loc3_.name;
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         _loc4_.iconMask = GameItemCDManager.getCDBitmap(GameItemManager.getItemCDFlag(param1));
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc8_:String = null;
         var _loc3_:GameTipUI = new GameTipUI("Items");
         var _loc4_:int = 180;
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:GameItemFullInfo = GameItemInfoManager.getItemInfo(param2);
         var _loc7_:ItemPlayerPetInfo = JSONUtil.getObject(_loc6_,["petInfo"]) as ItemPlayerPetInfo;
         if(_loc6_)
         {
            if(_loc7_)
            {
               _loc8_ = "";
               if(_loc7_.enhanceLevel > 0)
               {
                  _loc8_ = "+" + _loc7_.enhanceLevel;
               }
               _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + GameItemRank.getRankColor(_loc5_.rank).toString(16) + "\'>" + _loc7_.name + " " + _loc8_ + "</p>",_loc4_,0);
               _loc3_.addTipInfo("<p align=\'center\'>" + MonsterSpecies.getSpeciesName(JSONUtil.getInt(_loc5_,["properties","species"],-1)) + "</p>",_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtLevel"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.level + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtType"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + PetKind.getKindName(JSONUtil.getInt(_loc5_,["properties","petKind"])) + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtLife"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.life + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtGrowthRate"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + Number(_loc7_.attributes.growthRate * _loc7_.attributes.levelUpAttrPt * 0.01).toFixed(1) + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtSex"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + DiversityManager.getString("PetUI",_loc7_.sex == 1 ? "petSex1" : "petSex0") + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtGeneration"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.generation + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo("  ",_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtStrength"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.strength + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtAgility"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.agility + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtWisdom"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.wisdom + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtVitality"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.vitality + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtStrengthApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.strengthApt + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtAgilityApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.agilityApt + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtWisdomApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.wisdomApt + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtVitalityApt"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.attributes.vitalityApt + "</p>",_loc4_,_loc3_.maxRow);
            }
            else
            {
               _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + GameItemRank.getRankColor(_loc5_.rank).toString(16) + "\'>" + _loc5_.name + "</p>",_loc4_,0);
               _loc3_.addTipInfo("<p align=\'center\'>" + MonsterSpecies.getSpeciesName(JSONUtil.getInt(_loc5_,["properties","species"],-1)) + "</p>",_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtType"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + PetKind.getKindName(JSONUtil.getInt(_loc5_,["properties","petKind"])) + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["remark"]),_loc4_,_loc3_.maxRow + 1);
            }
         }
         else
         {
            _loc3_.addTipInfo("<p align=\'center\'><font color=\'#" + GameItemRank.getRankColor(_loc5_.rank).toString(16) + "\'>" + _loc5_.name + "</p>",_loc4_,0);
            _loc3_.addTipInfo("<p align=\'center\'>" + MonsterSpecies.getSpeciesName(JSONUtil.getInt(_loc5_,["properties","species"],-1)) + "</p>",_loc4_,_loc3_.maxRow + 1);
            _loc3_.addTipInfo(DiversityManager.getString("PetUI","txtType"),_loc4_,_loc3_.maxRow + 1);
            _loc3_.addTipInfo("<p align=\'right\'>" + PetKind.getKindName(JSONUtil.getInt(_loc5_,["properties","petKind"])) + "</p>",_loc4_,_loc3_.maxRow);
            _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["remark"]),_loc4_,_loc3_.maxRow + 1);
            GameContext.bagItemManager.sendViewItem(param2);
         }
         _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["remark"]),_loc4_,_loc3_.maxRow + 1);
         GameItemManager.setItemTipValidTime(param1,param2,_loc3_,_loc4_);
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

