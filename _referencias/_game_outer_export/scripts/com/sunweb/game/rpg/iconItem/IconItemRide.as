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
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   
   public class IconItemRide extends IconItem
   {
      
      public var rideModelCode:String;
      
      public var rideCapacity:int;
      
      public function IconItemRide(param1:DisplayObject, param2:String, param3:String)
      {
         super(param1);
         itemCode = param2;
         itemId = param3;
         addType(GameItemType.RIDE);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : IconItemRide
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf___4922(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:IconItemRide = new IconItemRide(GameItemManager.getItemIcon(param1),param1,param2);
         _loc4_.itemName = _loc3_.name;
         _loc4_.rideModelCode = JSONUtil.getStr(_loc3_,["properties","modelCode"]);
         _loc4_.rideCapacity = JSONUtil.getInt(_loc3_,["properties","capacity"],1);
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         _loc4_.iconMask = GameItemCDManager.getCDBitmap(GameItemManager.getItemCDFlag(param1));
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc6_:Array = null;
         var _loc7_:GameItemFullInfo = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         var _loc17_:Object = null;
         var _loc3_:GameTipUI = new GameTipUI("Items");
         var _loc4_:int = 220;
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(_loc5_)
         {
            GameItemManager.obf_4_G_4299(_loc5_.name,_loc5_.rank,_loc3_,_loc4_);
            GameItemManager.obf_o_l_1634(_loc5_,_loc3_,_loc4_);
            if(param2 != "")
            {
               _loc7_ = GameItemInfoManager.getItemInfo(param2);
               if(_loc7_)
               {
                  if(!_loc7_.isEmpty)
                  {
                     _loc3_.addTipInfo(DiversityManager.getString("RoleUI","txtLevel"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>" + _loc7_.rideInfo.level + "</P>",_loc4_,_loc3_.maxRow);
                     _loc8_ = obf_0___z_209.getAptValueAtLevel(param1,_loc7_.rideInfo.level,obf_0___z_209.obf_C_W_1491,_loc7_.rideInfo.lifeAptAdded) / 10;
                     _loc3_.addTipInfo(DiversityManager.getString("RidePrompt","rideItemLifeApt"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>+" + _loc8_.toFixed(1) + "%</P>",_loc4_,_loc3_.maxRow);
                     _loc9_ = obf_0___z_209.getAptValueAtLevel(param1,_loc7_.rideInfo.level,obf_0___z_209.ATTACK_APT,_loc7_.rideInfo.attackAptAdded) / 10;
                     _loc3_.addTipInfo(DiversityManager.getString("RidePrompt","rideItemAttackApt"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>+" + _loc9_.toFixed(1) + "%</P>",_loc4_,_loc3_.maxRow);
                     _loc10_ = obf_0___z_209.getAptValueAtLevel(param1,_loc7_.rideInfo.level,obf_0___z_209.obf_A_C_2113,_loc7_.rideInfo.defenseAptAdded) / 10;
                     _loc3_.addTipInfo(DiversityManager.getString("RidePrompt","rideItemDefenseApt"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>+" + _loc10_.toFixed(1) + "%</P>",_loc4_,_loc3_.maxRow);
                     _loc11_ = obf_0___z_209.getAptValueAtLevel(param1,_loc7_.rideInfo.level,obf_0___z_209.obf_n_w_1135,_loc7_.rideInfo.cureAptAdded) / 10;
                     _loc3_.addTipInfo(DiversityManager.getString("RidePrompt","rideItemCureApt"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>+" + _loc11_.toFixed(1) + "%</P>",_loc4_,_loc3_.maxRow);
                     _loc3_.addTipInfo(DiversityManager.getString("EquipmentAttribute","moveSpeed"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<P align=\'right\'>" + (_loc7_.rideInfo != null ? _loc7_.rideInfo.rideSpeed : 0) + "</P>",_loc4_,_loc3_.maxRow);
                     _loc3_.addTipInfo(DiversityManager.getString("RideFusionUI","txtGeneration"),_loc4_,_loc3_.maxRow + 1);
                     _loc3_.addTipInfo("<p align=\'right\'>" + _loc7_.rideInfo.generation + "</p>",_loc4_,_loc3_.maxRow);
                     if(_loc7_.rideInfo.generation > 0)
                     {
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + "<P align=\'center\'>" + DiversityManager.getString("ItemPrompt","rideFusion") + "</P>" + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                        _loc12_ = _loc7_.rideInfo.fusionLifeApt / 10;
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("RidePrompt","rideItemLifeApt") + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + "<P align=\'right\'>+" + _loc12_.toFixed(1) + "%</P>" + "</FONT>",_loc4_,_loc3_.maxRow);
                        _loc13_ = _loc7_.rideInfo.fusionAttackApt / 10;
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("RidePrompt","rideItemAttackApt") + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + "<P align=\'right\'>+" + _loc13_.toFixed(1) + "%</P>" + "</FONT>",_loc4_,_loc3_.maxRow);
                        _loc14_ = _loc7_.rideInfo.fusionDefenseApt / 10;
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("RidePrompt","rideItemDefenseApt") + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + "<P align=\'right\'>+" + _loc14_.toFixed(1) + "%</P>" + "</FONT>",_loc4_,_loc3_.maxRow);
                        _loc15_ = _loc7_.rideInfo.fusionCureApt / 10;
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("RidePrompt","rideItemCureApt") + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                        _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + "<P align=\'right\'>+" + _loc15_.toFixed(1) + "%</P>" + "</FONT>",_loc4_,_loc3_.maxRow);
                     }
                  }
                  else
                  {
                     _loc3_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("ItemPrompt","itemDestroyed") + "</P>",_loc4_,_loc3_.maxRow + 1);
                  }
               }
               else
               {
                  _loc3_.addTipInfo(DiversityManager.getString("EquipRepairUI","prompt_GettingInfo"),_loc4_,_loc3_.maxRow + 1);
                  GameContext.bagItemManager.sendViewItem(param2);
               }
            }
            IconItemEquip.showResultAttr(JSONUtil.getObject(_loc5_,["properties","resultAttr"]),_loc3_,_loc4_);
            _loc6_ = JSONUtil.getObject(_loc5_,["properties","bindingSkills"]) as Array;
            if((Boolean(_loc6_)) && _loc6_.length > 0)
            {
               _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("EquipmentAttribute","itemGiveSkill") + "</FONT>",_loc4_,_loc3_.maxRow + 1);
               for each(_loc16_ in _loc6_)
               {
                  _loc17_ = SkillConfig.getSkillConfig(_loc16_);
                  if(_loc17_)
                  {
                     _loc3_.addTipInfo("<FONT color=\'#00FF00\'>" + _loc17_.name + (_loc17_.type == obf_M_F_3694.obf_u_8_4559 ? "(" + DiversityManager.getString("PlayerSkillPrompt","passiveSkill") + ")" : "") + ": " + _loc17_.levelInfo[0].detail + "</FONT>",_loc4_,_loc3_.maxRow + 1);
                  }
               }
            }
            _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["remark"]),_loc4_,_loc3_.maxRow + 2);
            GameItemManager.obf_J_l_4537(_loc5_,_loc3_,_loc4_);
            GameItemManager.setItemTipValidTime(param1,param2,_loc3_,_loc4_);
         }
         GameTipManager.showTip(_loc3_);
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         var _loc2_:GameItemFullInfo = null;
         if(GameContext.localPlayer)
         {
            if(!GameItemManager.obf_D_n_3089(itemCode,true))
            {
               return false;
            }
            _loc2_ = GameItemInfoManager.getItemInfo(itemId);
            if(Boolean(_loc2_) && Boolean(GameItemManager.haveValidTime(itemCode)) && _loc2_.expiredTimeLeftInHour <= 0)
            {
               obf_K_e_3075.obf_t_q_3040.showRenewPlan(itemCode,itemId);
            }
            return GameContext.localPlayer.obf_2_4683(itemId);
         }
         return false;
      }
      
      override public function clone() : IconItem
      {
         var _loc1_:IconItemRide = getNewIconItem(this.itemCode,this.itemId);
         _loc1_.itemCount = this.itemCount;
         return _loc1_;
      }
   }
}

