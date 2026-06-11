package com.sunweb.game.rpg.playerUI.playerInfo
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquippedItemInfo;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.godSoul.obf_t_a_1082;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SoulAttr;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulEquipmentNotify;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_A_x_3023;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   import playerUI.MindBoxMC;
   
   public class MindBox extends MindBoxMC implements IPlayerUI, IIconItemUI
   {
      
      private var bags:Array;
      
      private var bagKindSky:Object;
      
      private var bagKindTerra:Object;
      
      private var bagKindGod:Object;
      
      private var currSoul:int = 2;
      
      private var _skyLv:int;
      
      private var _terraLv:int;
      
      private var _godLv:int;
      
      private var obf_0_8_l_207:SoulAttr;
      
      private var obf_B_f_4308:SoulAttr;
      
      private var obf_o_P_2154:SoulAttr;
      
      private var resLoaded:Boolean;
      
      public function MindBox()
      {
         var _loc2_:IconItemBag = null;
         super();
         this.initDiversity();
         this.bags = new Array();
         this.bagKindSky = new Object();
         this.bagKindTerra = new Object();
         this.bagKindGod = new Object();
         this.visible = false;
         var _loc1_:Array = [["bagWeapon",EquipmentKind.WEAPON],["bagShield",EquipmentKind.SHIELD],["bagClothes",EquipmentKind.CLOTHES],["bagHat",EquipmentKind.HAT],["bagShoes",EquipmentKind.SHOES],["bagGlove",EquipmentKind.GLOVE],["bagRing",EquipmentKind.RING],["bagAmulet",EquipmentKind.AMULET]];
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new IconItemBag(this["equ1"][_loc1_[_loc3_][0]],this,_loc3_,_loc1_[_loc3_][1] + "equ1");
            _loc2_.addValidType(GameItemType.EQUIPMENT);
            this.bags.push(_loc2_);
            this.bagKindSky[_loc1_[_loc3_][1] + ""] = _loc2_;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new IconItemBag(this["equ2"][_loc1_[_loc3_][0]],this,_loc3_,_loc1_[_loc3_][1] + "equ2");
            _loc2_.addValidType(GameItemType.EQUIPMENT);
            this.bags.push(_loc2_);
            this.bagKindTerra[_loc1_[_loc3_][1] + ""] = _loc2_;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new IconItemBag(this["equ3"][_loc1_[_loc3_][0]],this,_loc3_,_loc1_[_loc3_][1] + "equ3");
            _loc2_.addValidType(GameItemType.EQUIPMENT);
            this.bags.push(_loc2_);
            this.bagKindGod[_loc1_[_loc3_][1] + ""] = _loc2_;
            _loc3_++;
         }
         cmdGodMind.visible = false;
         this.addListener();
      }
      
      public function get obf_p_1_3777() : SoulAttr
      {
         return this.obf_o_P_2154;
      }
      
      public function set obf_p_1_3777(param1:SoulAttr) : void
      {
         this.obf_o_P_2154 = param1;
      }
      
      public function get obf_9_4630() : SoulAttr
      {
         return this.obf_B_f_4308;
      }
      
      public function set obf_9_4630(param1:SoulAttr) : void
      {
         this.obf_B_f_4308 = param1;
      }
      
      public function get skyAttr() : SoulAttr
      {
         return this.obf_0_8_l_207;
      }
      
      public function set skyAttr(param1:SoulAttr) : void
      {
         this.obf_0_8_l_207 = param1;
      }
      
      public function get terraLv() : int
      {
         return this._terraLv;
      }
      
      public function set terraLv(param1:int) : void
      {
         this._terraLv = param1;
      }
      
      public function get skyLv() : int
      {
         return this._skyLv;
      }
      
      public function set skyLv(param1:int) : void
      {
         this._skyLv = param1;
      }
      
      public function get godLv() : int
      {
         return this._godLv;
      }
      
      public function set godLv(param1:int) : void
      {
         this._godLv = param1;
      }
      
      private function addListener() : void
      {
         cmdLvUp.addEventListener(MouseEvent.CLICK,this.obf_6_i_1012);
         cmdTianMind.addEventListener(MouseEvent.CLICK,this.obf_0_3_g_499);
         cmdDiMind.addEventListener(MouseEvent.CLICK,this.obf_Y_O_4371);
         cmdGodMind.addEventListener(MouseEvent.CLICK,this.obf_X_G_3896);
      }
      
      private function removerListener() : void
      {
         cmdLvUp.removeEventListener(MouseEvent.CLICK,this.obf_6_i_1012);
         cmdTianMind.removeEventListener(MouseEvent.CLICK,this.obf_0_3_g_499);
         cmdDiMind.removeEventListener(MouseEvent.CLICK,this.obf_Y_O_4371);
         cmdGodMind.removeEventListener(MouseEvent.CLICK,this.obf_X_G_3896);
      }
      
      private function obf_6_i_1012(param1:MouseEvent) : void
      {
         if(this._skyLv == 0 && this._terraLv == 0 && this._godLv == 0)
         {
            return;
         }
         var _loc2_:String = obf_t_a_1082.getSuffCode();
         if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < int(txtStar.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MindBox","noStuff"));
            return;
         }
         if(uint(txtExp.text) > uint(txtAllExp.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MindBox","noExp"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.level <= this.getLv(this.currSoul))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MindBox","noLv",[obf_W_l_2992.getSoulName(this.currSoul)]));
            return;
         }
         obf_t_a_1082.sendLvUP(this.currSoul);
      }
      
      public function getLv(param1:int) : int
      {
         if(param1 == obf_W_l_2992.obf_C_X_4367)
         {
            return this._skyLv;
         }
         if(param1 == obf_W_l_2992.obf_0_3_N_708)
         {
            return this._terraLv;
         }
         if(param1 == obf_W_l_2992.obf_i_q_2098)
         {
            return this._godLv;
         }
         return 0;
      }
      
      private function obf_0_3_g_499(param1:MouseEvent) : void
      {
         if(!ConditionScript.checkCondition(obf_t_a_1082.goulConfig.skySoulOpenCondition,null,true))
         {
            return;
         }
         txtRemark.text = DiversityManager.getString("MindBox","1Atrr");
         this.setMind(obf_W_l_2992.obf_C_X_4367);
      }
      
      public function setMind(param1:int) : void
      {
         this.currSoul = param1;
         if(param1 == obf_W_l_2992.obf_C_X_4367)
         {
            if(this.contains(equ2))
            {
               this.removeChild(equ2);
            }
            else if(this.contains(equ3))
            {
               this.removeChild(equ3);
            }
            if(!this.contains(equ1))
            {
               this.addChild(equ1);
            }
            this.setAttr(this._skyLv,this.obf_0_8_l_207);
            cmdTianMind.filters = [new GlowFilter(6684671)];
            cmdDiMind.filters = null;
            cmdGodMind.filters = null;
         }
         else if(param1 == obf_W_l_2992.obf_0_3_N_708)
         {
            if(this.contains(equ1))
            {
               this.removeChild(equ1);
            }
            if(this.contains(equ3))
            {
               this.removeChild(equ3);
            }
            if(!this.contains(equ2))
            {
               this.addChild(equ2);
            }
            this.setAttr(this._terraLv,this.obf_B_f_4308);
            cmdTianMind.filters = null;
            cmdGodMind.filters = null;
            cmdDiMind.filters = [new GlowFilter(6684671)];
         }
         else if(param1 == obf_W_l_2992.obf_i_q_2098)
         {
            if(this.contains(equ1))
            {
               this.removeChild(equ1);
            }
            else if(this.contains(equ2))
            {
               this.removeChild(equ2);
            }
            if(!this.contains(equ3))
            {
               this.addChild(equ3);
            }
            this.setAttr(this._godLv,this.obf_o_P_2154);
            cmdGodMind.filters = [new GlowFilter(6684671)];
            cmdDiMind.filters = null;
            cmdTianMind.filters = null;
         }
         if(uint(txtExp.text) > uint(txtAllExp.text))
         {
            cmdLvUp.enabled = false;
         }
         else
         {
            cmdLvUp.enabled = true;
         }
         if(uint(txtLv.text) >= obf_t_a_1082.getPlayerLevelNum(this.currSoul))
         {
            cmdLvUp.enabled = false;
         }
      }
      
      private function obf_Y_O_4371(param1:MouseEvent) : void
      {
         if(!ConditionScript.checkCondition(obf_t_a_1082.goulConfig.terraSoulOpenCondition,null,true))
         {
            return;
         }
         txtRemark.text = DiversityManager.getString("MindBox","2Atrr");
         this.setMind(obf_W_l_2992.obf_0_3_N_708);
      }
      
      private function obf_X_G_3896(param1:MouseEvent) : void
      {
         if(!ConditionScript.checkCondition(obf_t_a_1082.goulConfig.deitySoulOpenCondition,null,true))
         {
            return;
         }
         txtRemark.text = DiversityManager.getString("MindBox","3Atrr");
         this.setMind(obf_W_l_2992.obf_i_q_2098);
      }
      
      private function setAttr(param1:int, param2:SoulAttr) : void
      {
         var _loc5_:DisplayObject = null;
         this.obf_k_f_2185();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.bold = true;
         txtMindName.text = obf_W_l_2992.getSoulName(this.currSoul);
         txtMindName.setTextFormat(_loc3_);
         txtLv.text = param1 + "";
         if(param1 < obf_t_a_1082.getPlayerLevelNum(this.currSoul))
         {
            txtExp.text = obf_t_a_1082.getPlayerLevelNumber(param1 + 2,this.currSoul) + "";
         }
         else
         {
            txtExp.text = "";
            cmdLvUp.enabled = false;
         }
         txtStar.text = obf_t_a_1082.getStuffNum(param1 + 2,this.currSoul) + "";
         txtRemark.text = DiversityManager.getString("MindBox",this.currSoul + "Atrr");
         if(obf_3_817.numChildren <= 0)
         {
            _loc5_ = obf_I_5_1944.getJobImage(GameContext.localPlayer.fullInfo.jobCode,GameContext.localPlayer.fullInfo.sex);
            if(_loc5_)
            {
               _loc5_.scaleX = 0.4;
               _loc5_.scaleY = 0.4;
               obf_3_817.addChild(_loc5_);
            }
         }
         if(!param2)
         {
            return;
         }
         var _loc4_:Number = 0.5;
         if(this.currSoul == 1)
         {
            _loc4_ = 0.5;
         }
         else if(this.currSoul == 2)
         {
            _loc4_ = 0.3;
         }
         else if(this.currSoul == 3)
         {
            _loc4_ = 0.7;
         }
         txtPhysicalAttack.text = Math.round(param2.physicalAttack * _loc4_) + "";
         txtMagicAttack.text = Math.round(param2.magicAttack * _loc4_) + "";
         txtPhysicalDefense.text = Math.round(param2.physicalDefense * _loc4_) + "";
         txtMagicDefense.text = Math.round(param2.magicDefense * _loc4_) + "";
         txtHp.text = Math.round(param2.hpMax * _loc4_) + "";
         txtMp.text = Math.round(param2.mpMax * _loc4_) + "";
         txtHit.text = Math.round(param2.hitValueAddValue * _loc4_) + "";
         txtHitRate.text = obf_A_x_3023.getRateString(param2.hitRateAddValue * _loc4_);
         txtDodge.text = Math.round(param2.dodgeValueAddValue * _loc4_) + "";
         txtDodgeRate.text = obf_A_x_3023.getRateString(param2.dodgeRateAddValue * _loc4_);
         txtCrit.text = Math.round(param2.critValueAddValue * _loc4_) + "";
         txtCritRate.text = obf_A_x_3023.getRateString(param2.critRateAddValue * _loc4_);
      }
      
      private function obf_k_f_2185() : void
      {
         txtPhysicalAttack.text = "";
         txtMagicAttack.text = "";
         txtPhysicalDefense.text = "";
         txtMagicDefense.text = "";
         txtHp.text = "";
         txtMp.text = "";
         txtHit.text = "";
         txtHitRate.text = "";
         txtDodge.text = "";
         txtDodgeRate.text = "";
         txtCrit.text = "";
         txtCritRate.text = "";
      }
      
      public function set allExp(param1:uint) : void
      {
         txtAllExp.text = param1 + "";
         if(uint(txtExp.text) > uint(txtAllExp.text))
         {
            cmdLvUp.enabled = false;
         }
         else
         {
            cmdLvUp.enabled = true;
         }
         if(uint(txtLv.text) >= obf_t_a_1082.getPlayerLevelNum(this.currSoul))
         {
            cmdLvUp.enabled = false;
         }
      }
      
      public function get equipBags() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKindSky)
         {
            if(this.bagKindSky[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindSky[_loc2_]);
            }
         }
         for(_loc2_ in this.bagKindTerra)
         {
            if(this.bagKindTerra[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindTerra[_loc2_]);
            }
         }
         for(_loc2_ in this.bagKindGod)
         {
            if(this.bagKindGod[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindGod[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public function get equipSkyBags() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKindSky)
         {
            if(this.bagKindSky[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindSky[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public function get equipTerraBags() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKindTerra)
         {
            if(this.bagKindTerra[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindTerra[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public function get equipGodBags() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKindGod)
         {
            if(this.bagKindGod[_loc2_] is IconItemBag)
            {
               _loc1_.push(this.bagKindGod[_loc2_]);
            }
         }
         return _loc1_;
      }
      
      public function setAllEquip(param1:GodSoulEquipmentNotify) : void
      {
         var _loc2_:EquippedItemInfo = null;
         if(param1.soulType == 0)
         {
            for each(_loc2_ in param1.changedSkySoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_C_X_4367);
            }
            for each(_loc2_ in param1.changedTerraSoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_0_3_N_708);
            }
            for each(_loc2_ in param1.changedDeitySoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_i_q_2098);
            }
         }
         else if(param1.soulType == obf_W_l_2992.obf_C_X_4367)
         {
            for each(_loc2_ in param1.changedSkySoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_C_X_4367);
            }
         }
         else if(param1.soulType == obf_W_l_2992.obf_0_3_N_708)
         {
            for each(_loc2_ in param1.changedTerraSoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_0_3_N_708);
            }
         }
         else if(param1.soulType == obf_W_l_2992.obf_i_q_2098)
         {
            for each(_loc2_ in param1.changedDeitySoulEquipments)
            {
               obf_K_e_3075.obf_J_K_2135.setEquip(_loc2_,obf_W_l_2992.obf_i_q_2098);
            }
         }
         this.setMind(this.currSoul);
      }
      
      private function setEquip(param1:EquippedItemInfo, param2:int) : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:Object = null;
         var _loc5_:IconItemEquip = null;
         if(!param1 || !GameContext.localPlayer)
         {
            return;
         }
         if(param2 == obf_W_l_2992.obf_C_X_4367)
         {
            _loc3_ = this.bagKindSky[param1.equipmentKind + ""];
         }
         else if(param2 == obf_W_l_2992.obf_0_3_N_708)
         {
            _loc3_ = this.bagKindTerra[param1.equipmentKind + ""];
         }
         else if(param2 == obf_W_l_2992.obf_i_q_2098)
         {
            _loc3_ = this.bagKindGod[param1.equipmentKind + ""];
         }
         if(!_loc3_)
         {
            return;
         }
         _loc3_.dropIconItem();
         _loc3_.bagMC.alpha = 0.5;
         if(param1.equipment)
         {
            _loc4_ = GameItemManager.getItemConfig(param1.equipment.itemCode);
            _loc5_ = IconItemEquip.getNewIconItem(param1.equipment.itemCode,param1.equipment.itemId);
            _loc3_.pushIconItem(_loc5_);
            _loc3_.bagMC.alpha = 1;
         }
      }
      
      public function useIcon(param1:IconItem, param2:IconItemBag) : void
      {
         var _loc3_:GameItemFullInfo = GameItemInfoManager.getItemInfo(param1.itemId);
         if(Boolean(_loc3_) && Boolean(GameItemManager.haveValidTime(param1.itemCode)) && _loc3_.expiredTimeLeftInHour <= 0)
         {
            obf_K_e_3075.obf_t_q_3040.showRenewPlan(param1.itemCode,param1.itemId);
            WindowManager.showMessageBox(DiversityManager.getString("ItemPrompt","useItemError_ItemExpired"));
         }
         if(!obf_t_a_1082.obf_D_n_3089(param1.itemCode,this.currSoul,true))
         {
            return;
         }
         obf_t_a_1082.sendSetEquip(param2.itemIndex,this.currSoul);
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return 0;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtAmulet,"RoleUI","txtAmulet");
         DiversityManager.setTextField(txtRing,"RoleUI","txtRing");
         DiversityManager.setTextField(txtHat,"RoleUI","txtHat");
         DiversityManager.setTextField(txtWeapon,"RoleUI","txtWeapon");
         DiversityManager.setTextField(txtShield,"RoleUI","txtShield");
         DiversityManager.setTextField(txtClothes,"RoleUI","txtClothes");
         DiversityManager.setTextField(txtGlove,"RoleUI","txtGlove");
         DiversityManager.setTextField(txtShoes,"RoleUI","txtShoes");
         DiversityManager.setTextField(txtDeyExp,"MindBox","txtDeyExp");
         DiversityManager.setTextField(txtDeyAllExp,"MindBox","txtDeyAllExp");
         DiversityManager.setTextField(txtDeyLv,"MindBox","txtDeyLv");
         DiversityManager.setTextField(txtDeyPhysicalAttack,"MindBox","txtDeyPhysicalAttack");
         DiversityManager.setTextField(txtDeyMagicAttack,"MindBox","txtDeyMagicAttack");
         DiversityManager.setTextField(txtDeyPhysicalDefense,"MindBox","txtDeyPhysicalDefense");
         DiversityManager.setTextField(txtDeyMagicDefense,"MindBox","txtDeyMagicDefense");
         DiversityManager.setTextField(txtDeyHp,"MindBox","txtDeyHp");
         DiversityManager.setTextField(txtDeyMp,"MindBox","txtDeyMp");
         DiversityManager.setTextField(txtDeyHit,"MindBox","txtDeyHit");
         DiversityManager.setTextField(txtDeyHitRate,"MindBox","txtDeyHitRate");
         DiversityManager.setTextField(txtDeyDodge,"MindBox","txtDeyDodge");
         DiversityManager.setTextField(txtDeyDodgeRate,"MindBox","txtDeyDodgeRate");
         DiversityManager.setTextField(txtDeyCrit,"MindBox","txtDeyCrit");
         DiversityManager.setTextField(txtDeyCritRate,"MindBox","txtDeyCritRate");
         DiversityManager.setTextField(txtSay,"MindBox","txtSay");
         cmdLvUp.label = DiversityManager.getString("MindBox","lvUp");
         cmdTianMind.label = DiversityManager.getString("MindBox","1");
         cmdDiMind.label = DiversityManager.getString("MindBox","2");
         cmdGodMind.label = DiversityManager.getString("MindBox","3");
         DiversityManager.setTextField(txtDayStar,"MindBox","txtDayStar");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removerListener();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(Boolean(param3) && Boolean(param1.haveIconItem) && param1.haveIconItem.itemType != GameItemType.SKILL)
         {
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,param1.haveIconItem.itemName,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
         if(!(Boolean(obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_2_N_1475) && Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT))
         {
            if(obf_K_e_3075.refineBoxUI.visible && param1.haveIconItem is IconItemEquip && !param3)
            {
               obf_K_e_3075.refineBoxUI.pushEquipIn(param1.haveIconItem.clone() as IconItemEquip);
            }
            else if(obf_K_e_3075.obf_5_i_2480.visible && param1.haveIconItem is IconItemEquip && !param3)
            {
               obf_K_e_3075.obf_5_i_2480.pushEquipIn(param1.haveIconItem.clone() as IconItemEquip);
            }
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT)
         {
            obf_t_a_1082.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,this.currSoul,-1);
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!(param3.parentIconUI is PlayerBagUI) || !GameItemType.contrastType(GameItemType.EQUIPMENT,param2.itemType))
         {
            param2.destroy();
            return;
         }
         this.useIcon(param2,param3);
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(!(param3 is PlayerBagUI))
         {
            return;
         }
         obf_t_a_1082.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,this.currSoul,param2 ? param2.itemIndex : -1);
      }
   }
}

