package com.sunweb.game.rpg.playerUI.fastApplyUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_X_t_4110
   {
      
      private static var obf_0_1_l_361:IPlayerUI;
      
      private static var fastApplyUIList:Array = new Array();
      
      public function obf_X_t_4110()
      {
         super();
      }
      
      public static function showNextFastApplyUI() : void
      {
         if(Boolean(obf_0_1_l_361) || Boolean(!fastApplyUIList) || fastApplyUIList.length <= 0)
         {
            return;
         }
         var _loc1_:IPlayerUI = fastApplyUIList.shift();
         obf_0_1_l_361 = _loc1_;
         if(_loc1_)
         {
            obf_K_e_3075.showUI(_loc1_);
         }
         else
         {
            showNextFastApplyUI();
         }
      }
      
      public static function showFastApplyUI(param1:IPlayerUI) : void
      {
         fastApplyUIList.push(param1);
         showNextFastApplyUI();
      }
      
      public static function closeFastApplyUI(param1:IPlayerUI) : void
      {
         obf_K_e_3075.closeUI(param1);
         param1.destroy();
         obf_0_1_l_361 = null;
         showNextFastApplyUI();
      }
      
      public static function showPlayerAttrUI() : void
      {
         if(WorldConfig.getValue("functionSwitch","fastRoleAttrPoint"))
         {
            return;
         }
         if(!GameContext.localPlayer || GameContext.localPlayer.fullInfo.freeAttrPt <= 0)
         {
            return;
         }
         var _loc1_:obf_E_8_1846 = new obf_E_8_1846();
         showFastApplyUI(_loc1_);
      }
      
      public static function obf_f_n_2108(param1:String, param2:String) : void
      {
         if(WorldConfig.getValue("functionSwitch","fastEquipment"))
         {
            return;
         }
         if(EquipmentManager.obf_3_Z_1689(param1))
         {
            showFastApplyUI(new obf_V_G_1174(param1,param2));
         }
      }
      
      public static function obf_j_6_2682() : void
      {
         var _loc2_:IconItemBag = null;
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc1_:Array = obf_K_e_3075.playerBagUI.getAllBags();
         for each(_loc2_ in _loc1_)
         {
            if(!(_loc2_.isLocked || !_loc2_.haveIconItem))
            {
               if(_loc2_.haveIconItem.itemType == GameItemType.EQUIPMENT)
               {
                  obf_f_n_2108(_loc2_.haveIconItem.itemCode,_loc2_.haveIconItem.itemId);
               }
            }
         }
      }
      
      public static function obf_G_J_1663() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(WorldConfig.getValue("functionSwitch","fastLearnSkill"))
         {
            return;
         }
         if(!GameContext || !obf_K_e_3075.skillBookUI)
         {
            return;
         }
         for(_loc1_ in obf_K_e_3075.skillBookUI.allSkillBox)
         {
            _loc2_ = PlayerSkillManager.getSkillLevel(_loc1_);
            _loc3_ = SkillConfig.getSkillConfig(_loc1_);
            if(_loc2_ <= 0)
            {
               if(_loc2_ < JSONUtil.getInt(_loc3_,["levelInfo","length"]))
               {
                  _loc4_ = PlayerSkillManager.getUpSkillCondition(_loc1_,_loc2_ + 1);
                  if(ConditionScript.checkCondition(_loc4_))
                  {
                     showFastApplyUI(new obf_q_k_2348(_loc1_));
                  }
               }
            }
         }
      }
   }
}

