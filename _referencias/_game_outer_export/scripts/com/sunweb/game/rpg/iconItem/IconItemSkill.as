package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillCDManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class IconItemSkill extends IconItem
   {
      
      public var level:int;
      
      public function IconItemSkill(param1:DisplayObject, param2:int)
      {
         super(param1);
         if(param2 < 1)
         {
            param2 = 1;
         }
         this.level = param2;
         addType(GameItemType.SKILL);
      }
      
      public static function getNewIconItem(param1:String, param2:int) : IconItemSkill
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:String = _loc4_.iconRes;
         if(_loc5_)
         {
            _loc3_ = ResourceManager.instance.getDisplayObject(_loc5_);
         }
         if(!_loc3_)
         {
            _loc3_ = new Bitmap(new nullItemIcon(1,1));
         }
         var _loc6_:IconItemSkill = new IconItemSkill(_loc3_,param2);
         var _loc7_:Bitmap = PlayerSkillManager.getAutoSkillMask(param1);
         if(_loc7_)
         {
            _loc6_.addIconMask(_loc7_);
         }
         _loc6_.itemName = _loc4_.name;
         _loc6_.itemCode = param1;
         var _loc8_:String = JSONUtil.getStr(_loc4_,["cdFlag"]);
         if(obf_L_l_4100.isEmpty(_loc8_))
         {
            _loc8_ = param1;
         }
         _loc6_.iconMask = SkillCDManager.getCDBitmap(_loc8_);
         return _loc6_;
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         if(Boolean(GameContext.localPlayer) && PlayerSkillManager.obf_0_6_G_255(itemCode))
         {
            return GameContext.localPlayer.sendSkill(itemCode,GameContext.localPlayer.obf_0_6_a_430,null);
         }
         return false;
      }
      
      override public function showTipInfo(param1:IconItemBag) : void
      {
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc2_:Object = SkillConfig.getSkillConfig(this.itemCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = _loc2_["levelInfo"][this.level - 1];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:GameTipUI = new GameTipUI("Items");
         var _loc5_:int = 240;
         var _loc6_:String = "";
         if(Boolean(param1) && param1.parentIconUI == obf_K_e_3075.skillBookUI)
         {
            _loc6_ = " / " + _loc2_["levelInfo"].length;
         }
         _loc4_.addTipInfo("<FONT COLOR=\'#" + obf_0_3_0_538.obf_J_P_1631.toString(16) + "\'><p align=\'center\'>" + _loc2_.name + " Lv." + this.level + _loc6_ + "</p></FONT>",_loc5_,0);
         if(JSONUtil.getInt(_loc2_,["type"]) == obf_M_F_3694.obf_u_8_4559 || JSONUtil.getInt(_loc2_,["type"]) == obf_M_F_3694.obf_Q_5_4064)
         {
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","passiveSkill"),_loc5_,_loc4_.maxRow + 1);
         }
         else if(JSONUtil.getInt(_loc2_,["type"]) == obf_M_F_3694.obf_0_7_O_353)
         {
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","blessSkill"),_loc5_,_loc4_.maxRow + 1);
         }
         else
         {
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","skillSingTime"),_loc5_,_loc4_.maxRow + 2);
            _loc4_.addTipInfo("<p align=\'right\'>" + obf_l_y_733.getTimeStringSec(JSONUtil.getInt(_loc3_,["castRule","singTime"])) + "</p>",_loc5_,_loc4_.maxRow);
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","skillCastTime"),_loc5_,_loc4_.maxRow + 1);
            _loc4_.addTipInfo("<p align=\'right\'>" + obf_l_y_733.getTimeStringSec(JSONUtil.getInt(_loc3_,["castRule","castTime"])) + "</p>",_loc5_,_loc4_.maxRow);
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","skillCDTime"),_loc5_,_loc4_.maxRow + 1);
            _loc4_.addTipInfo("<p align=\'right\'>" + obf_l_y_733.getTimeStringSec(JSONUtil.getInt(_loc3_,["castRule","coldTime"])) + "</p>",_loc5_,_loc4_.maxRow);
            _loc4_.addTipInfo(DiversityManager.getString("PlayerSkillPrompt","skillRange"),_loc5_,_loc4_.maxRow + 1);
            _loc4_.addTipInfo("<p align=\'right\'>" + JSONUtil.getInt(_loc3_,["castRule","range"]) + "</p>",_loc5_,_loc4_.maxRow);
         }
         _loc4_.addTipInfo("  ",_loc5_,_loc4_.maxRow + 1);
         if(Boolean(param1) && Boolean(param1.parentIconUI == obf_K_e_3075.skillBookUI) && !PlayerSkillManager.obf_0_6_G_255(this.itemCode))
         {
            _loc8_ = PlayerSkillManager.getUpSkillCondition(itemCode,1);
            _loc4_.addTipInfo(ConditionScript.getConditionsHTML(_loc8_),_loc5_,_loc4_.maxRow + 1);
         }
         _loc4_.addTipInfo(_loc3_.detail,_loc5_,_loc4_.maxRow + 1);
         var _loc7_:String = this.getCostString(JSONUtil.getObject(_loc3_,["castRule","castCost"]));
         _loc4_.addTipInfo("<FONT COLOR=\'#33FF00\'>" + DiversityManager.getString("PlayerSkillPrompt","costLabel",[_loc7_]) + "</FONT>",_loc5_,_loc4_.maxRow + 1);
         if(Boolean(param1) && (Boolean(param1.parentIconUI == obf_K_e_3075.skillBookUI || param1.parentIconUI == obf_K_e_3075.familyBoxUI || param1.parentIconUI == obf_K_e_3075.playerBlessUI)) && this.level < _loc2_["levelInfo"].length)
         {
            _loc4_.addTipInfo("<font color=\'#00FF00\'>" + DiversityManager.getString("PlayerSkillPrompt","nextSkillLevel") + "</font>",_loc5_,_loc4_.maxRow + 2);
            _loc9_ = PlayerSkillManager.getUpSkillCondition(itemCode,this.level + 1);
            _loc4_.addTipInfo(ConditionScript.getConditionsHTML(_loc9_),_loc5_,_loc4_.maxRow + 1);
            _loc10_ = _loc2_["levelInfo"][this.level];
            _loc4_.addTipInfo(JSONUtil.getStr(_loc10_,["detail"]),_loc5_,_loc4_.maxRow + 2);
            _loc11_ = this.getCostString(JSONUtil.getObject(_loc10_,["castRule","castCost"]));
            _loc4_.addTipInfo("<FONT COLOR=\'#33FF00\'>" + DiversityManager.getString("PlayerSkillPrompt","costLabel",[_loc11_]) + "</FONT>",_loc5_,_loc4_.maxRow + 1);
         }
         GameTipManager.showTip(_loc4_);
      }
      
      private function getCostString(param1:Object) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = "";
         if(JSONUtil.getInt(param1,["hp"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costHP",[JSONUtil.getInt(param1,["hp"])]) + "、";
         }
         if(JSONUtil.getNumber(param1,["hp%"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costHP%",[Number(JSONUtil.getInt(param1,["hp%"])).toFixed(0)]) + "、";
         }
         if(JSONUtil.getInt(param1,["mp"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costMP",[JSONUtil.getInt(param1,["mp"])]) + "、";
         }
         if(JSONUtil.getNumber(param1,["mp%"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costMP%",[Number(JSONUtil.getInt(param1,["mp%"])).toFixed(0)]) + "、";
         }
         if(JSONUtil.getInt(param1,["sp"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costSP",[JSONUtil.getInt(param1,["sp"])]) + "、";
         }
         if(JSONUtil.getNumber(param1,["sp%"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costSP%",[Number(JSONUtil.getInt(param1,["sp%"])).toFixed(0)]) + "、";
         }
         if(JSONUtil.getInt(param1,["charmValue"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costCharmValue",[JSONUtil.getInt(param1,["charmValue"])]) + "、";
         }
         if(JSONUtil.getInt(param1,["charmInt"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costCharmInt",[JSONUtil.getInt(param1,["charmInt"])]) + "、";
         }
         if(JSONUtil.getInt(param1,["petEp"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","petEp",[JSONUtil.getInt(param1,["petEp"])]) + "、";
         }
         if(JSONUtil.getInt(param1,["gold"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costGold",[obf_a_f_2935.getGoldString(JSONUtil.getInt(param1,["gold"]))]) + "、";
         }
         if(JSONUtil.getInt(param1,["money"]) > 0)
         {
            _loc2_ += DiversityManager.getString("PlayerSkillPrompt","costMoney",[JSONUtil.getInt(param1,["money"])]) + "、";
         }
         var _loc3_:Object = JSONUtil.getObject(param1,["items"]);
         if(_loc3_)
         {
            for(_loc4_ in _loc3_)
            {
               _loc2_ += GameItemManager.getItemName(_loc4_) + "x" + _loc3_[_loc4_] + "、";
            }
         }
         if(_loc2_ != "")
         {
            _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
         }
         if(_loc2_ == "")
         {
            _loc2_ = DiversityManager.getString("PlayerSkillPrompt","noCost");
         }
         return _loc2_;
      }
      
      override public function clone() : IconItem
      {
         var _loc1_:IconItemSkill = getNewIconItem(this.itemCode,this.level);
         _loc1_.itemId = this.itemId;
         return _loc1_;
      }
   }
}

