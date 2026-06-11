package com.sunweb.game.rpg.playerUI.baby
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.baby.BabyInfo;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBuyAttrMaxAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyLevelAttrNotify;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.BabyUIMC;
   
   public class obf_x_A_3522 extends BabyUIMC implements IIconItemUI
   {
      
      private var tempX:int;
      
      private var monster:obf_9_c_4534;
      
      private var materiaBag:IconItemBag;
      
      private var obf_e_N_1910:int;
      
      public var currentLv:int;
      
      private var upMaxButtonArr:Array;
      
      private var obf_q_g_899:int;
      
      private var obf_0_0_3_263:int;
      
      private var obf_0_1_q_144:int;
      
      private var obf_3_F_1239:int;
      
      private var attrMaxArr:Array;
      
      private var _sex:int;
      
      private var obf_7_O_836:TimeLimiter = new TimeLimiter(200);
      
      private var time:TimeLimiter = new TimeLimiter(500);
      
      public function obf_x_A_3522()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         barPullulation.gotoAndStop(1);
         barSaturation.gotoAndStop(1);
         this.initDiversity();
         cmdNurserySchool.visible = false;
         this.tempX = cmdNurserySchool.x;
         cmdCollege.x = this.tempX;
         this.materiaBag = new IconItemBag(materialIconBar,this,0);
         this.materiaBag.lockDrag = true;
         this.materiaBag.addValidType(GameItemType.ALL);
         this.upMaxButtonArr = [cmdUpperLimit1,cmdUpperLimit2,cmdUpperLimit3,cmdUpperLimit4];
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         remark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdNurserySchool.addEventListener(MouseEvent.CLICK,this.obf_B_L_825);
         cmdCollege.addEventListener(MouseEvent.CLICK,this.obf_V_H_2567);
         cmdWorld.addEventListener(MouseEvent.CLICK,this.obf_H_d_3296);
         cmdBlood.addEventListener(MouseEvent.CLICK,this.obf_0_O_1748);
         cmdFeed.addEventListener(MouseEvent.CLICK,this.obf_0_2_K_469);
         for each(_loc1_ in this.upMaxButtonArr)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         }
         obf_K_e_3075.addUIMouseToolTip(remark,"remarkBaby");
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdNurserySchool.removeEventListener(MouseEvent.CLICK,this.obf_B_L_825);
         cmdCollege.removeEventListener(MouseEvent.CLICK,this.obf_V_H_2567);
         cmdWorld.removeEventListener(MouseEvent.CLICK,this.obf_H_d_3296);
         cmdBlood.removeEventListener(MouseEvent.CLICK,this.obf_0_O_1748);
         cmdFeed.removeEventListener(MouseEvent.CLICK,this.obf_0_2_K_469);
         for each(_loc1_ in this.upMaxButtonArr)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         }
         obf_K_e_3075.removeUIMouseToolTip(remark);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_B_L_825(param1:Event) : void
      {
         if(obf_K_e_3075.obf_y_X_2167.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_y_X_2167);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_y_X_2167);
         }
         param1.stopPropagation();
      }
      
      private function obf_V_H_2567(param1:Event) : void
      {
         if(obf_K_e_3075.obf_R_v_3742.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_R_v_3742);
         }
         else
         {
            if(this.currentLv < obf_s_1265.getCollegeConfig().open)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantLv"));
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.obf_R_v_3742);
         }
         param1.stopPropagation();
      }
      
      private function obf_H_d_3296(param1:Event) : void
      {
         if(obf_K_e_3075.worldUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.worldUI);
         }
         else
         {
            if(this.currentLv < obf_s_1265.getTravelConfig().open)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantLv"));
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.worldUI);
         }
         param1.stopPropagation();
      }
      
      private function obf_0_O_1748(param1:Event) : void
      {
         if(obf_K_e_3075.obf_g_7_4476.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_g_7_4476);
         }
         else
         {
            if(this.currentLv < obf_s_1265.getBloodConfig().open)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantLv"));
               return;
            }
            obf_K_e_3075.showUI(obf_K_e_3075.obf_g_7_4476);
         }
         param1.stopPropagation();
      }
      
      private function obf_0_2_K_469(param1:Event) : void
      {
         var _loc2_:String = obf_s_1265.getMaterialCode();
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantMaterial"));
            return;
         }
         obf_s_1265.sendBabyEatRequest(_loc2_);
      }
      
      private function obf_e_s_3253(param1:Event) : void
      {
         var _loc2_:int = int(obf_s_1265.getBuyAttr().maxValue);
         var _loc3_:Object = obf_s_1265.getBabyLevelConfig(this.currentLv);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = _loc2_ + _loc3_.addAttrMax;
         var _loc5_:int = this.upMaxButtonArr.indexOf(param1.currentTarget);
         if(this.attrMaxArr[_loc5_] >= _loc4_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","upperLimit"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("BoyUI","sure",[obf_s_1265.getBuyAttr().money]),this.obf_i_k_2402,{"bt":param1.currentTarget});
      }
      
      private function obf_i_k_2402(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < obf_s_1265.getBuyAttr().money)
            {
               WindowManager.showMessageBox(DiversityManager.getString("BoyUI","noMoney"));
               return;
            }
            obf_s_1265.sendBabyBuyAttrMaxRequest(this.upMaxButtonArr.indexOf(param1.par.bt) + 1);
         }
      }
      
      private function showItem() : void
      {
         this.materiaBag.dropIconItem();
         var _loc1_:IconItem = IconItemManager.getIconItemByCode(obf_s_1265.getMaterialCode(),"");
         if(!_loc1_)
         {
            return;
         }
         _loc1_.itemCount = 1;
         if(GameContext.bagItemManager.getHaveItemCount(_loc1_.itemCode,true) < _loc1_.itemCount)
         {
            _loc1_.countTextColor = 16711680;
         }
         this.materiaBag.pushIconItem(_loc1_);
      }
      
      public function showData(param1:BabyInfo) : void
      {
         this.obf_E_j_2700();
         this.attrMaxArr = new Array();
         this.currentLv = param1.level;
         var _loc2_:Object = obf_s_1265.getBabyLevelConfig(param1.level);
         if(!_loc2_)
         {
            return;
         }
         babyLv.text = param1.level + "";
         this.obf_q_g_899 = param1.strength;
         this.obf_0_0_3_263 = param1.agility;
         this.obf_0_1_q_144 = param1.wisdom;
         this.obf_3_F_1239 = param1.vitality;
         this.attrMaxArr.push(param1.strengthMax);
         this.attrMaxArr.push(param1.agilityMax);
         this.attrMaxArr.push(param1.wisdomMax);
         this.attrMaxArr.push(param1.vitalityMax);
         txtStrength.text = this.obf_q_g_899 + "/" + param1.strengthMax;
         txtAgility.text = this.obf_0_0_3_263 + "/" + param1.agilityMax;
         txtWisdom.text = this.obf_0_1_q_144 + "/" + param1.wisdomMax;
         txtSinew.text = this.obf_3_F_1239 + "/" + param1.vitalityMax;
         this._sex = param1.sex;
         this.monster = new obf_9_c_4534(_loc2_.modelCode + param1.sex);
         if(this.monster)
         {
            this.monster.x = 0;
            point.addChild(this.monster);
            this.monster.doAction(obf_S_c_3330.obf_r_q_3113,0,true);
         }
         this.obf_W_7_1006(param1.exp,param1.level);
         this.obf_0_0_l_635(param1.foodValue);
         obf_K_e_3075.worldUI.setRimeValue(param1.exp,param1.level);
      }
      
      public function obf_y_J_818(param1:PlayerBabyLevelAttrNotify) : void
      {
         this.obf_E_j_2700();
         this.attrMaxArr = new Array();
         var _loc2_:Object = obf_s_1265.getBabyLevelConfig(param1.level);
         this.monster = new obf_9_c_4534(_loc2_.modelCode + this._sex);
         if(this.monster)
         {
            this.monster.x = 0;
            point.addChild(this.monster);
            this.monster.doAction(obf_S_c_3330.obf_r_q_3113,0,true);
         }
         this.obf_W_7_1006(param1.exp,param1.level);
         babyLv.text = param1.level + "";
         this.currentLv = param1.level;
         this.obf_q_g_899 = param1.strength;
         this.obf_0_0_3_263 = param1.agility;
         this.obf_0_1_q_144 = param1.wisdom;
         this.obf_3_F_1239 = param1.vitality;
         this.attrMaxArr.push(param1.strengthMax);
         this.attrMaxArr.push(param1.agilityMax);
         this.attrMaxArr.push(param1.wisdomMax);
         this.attrMaxArr.push(param1.vitalityMax);
         txtStrength.text = this.obf_q_g_899 + "/" + param1.strengthMax;
         txtAgility.text = this.obf_0_0_3_263 + "/" + param1.agilityMax;
         txtWisdom.text = this.obf_0_1_q_144 + "/" + param1.wisdomMax;
         txtSinew.text = this.obf_3_F_1239 + "/" + param1.vitalityMax;
         obf_K_e_3075.worldUI.setRimeValue(param1.exp,param1.level);
      }
      
      public function obf_V_x_2326(param1:PlayerBabyBuyAttrMaxAnswer) : void
      {
         this.attrMaxArr = new Array();
         txtStrength.text = "";
         txtAgility.text = "";
         txtWisdom.text = "";
         txtSinew.text = "";
         this.attrMaxArr.push(param1.strengthMax);
         this.attrMaxArr.push(param1.agilityMax);
         this.attrMaxArr.push(param1.wisdomMax);
         this.attrMaxArr.push(param1.vitalityMax);
         txtStrength.text = this.obf_q_g_899 + "/" + param1.strengthMax;
         txtAgility.text = this.obf_0_0_3_263 + "/" + param1.agilityMax;
         txtWisdom.text = this.obf_0_1_q_144 + "/" + param1.wisdomMax;
         txtSinew.text = this.obf_3_F_1239 + "/" + param1.vitalityMax;
      }
      
      private function obf_W_7_1006(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         txtLvBarValue.text = "";
         var _loc3_:Object = obf_s_1265.getBabyLevelConfig(param2);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 20)
         {
            txtLvBarValue.text = param1 + "/" + _loc3_.exp;
            _loc4_ = 100 * Number(param1 / _loc3_.exp);
            if(_loc4_ < 2)
            {
               _loc4_ = 2;
            }
            barPullulation.gotoAndStop(_loc4_);
         }
         else
         {
            txtLvBarValue.text = 0 + "/" + 0;
            barPullulation.gotoAndStop(0);
         }
      }
      
      public function obf_0_0_l_635(param1:int) : void
      {
         txtFeedBarValue.text = "";
         this.obf_e_N_1910 = param1;
         txtFeedBarValue.text = param1 + "/" + 100;
         var _loc2_:int = 100 * Number(param1 / 100);
         if(_loc2_ < 2)
         {
            _loc2_ = 2;
         }
         barSaturation.gotoAndStop(_loc2_);
      }
      
      public function showShool(param1:int) : void
      {
         if(param1 >= obf_s_1265.getCollegeConfig().open)
         {
            cmdNurserySchool.visible = false;
            cmdCollege.visible = true;
            cmdCollege.x = this.tempX;
         }
         else
         {
            cmdCollege.visible = false;
            cmdNurserySchool.visible = true;
         }
      }
      
      private function obf_E_j_2700() : void
      {
         babyLv.text = "";
         txtStrength.text = "";
         txtAgility.text = "";
         txtWisdom.text = "";
         txtSinew.text = "";
         while(point.numChildren > 0)
         {
            point.removeChildAt(0);
         }
         if(this.monster)
         {
            this.monster.destroy();
         }
         this.monster = null;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.time.checkTimeout() && Boolean(this.monster))
         {
            this.monster.onUpdate();
         }
         if(this.obf_7_O_836.checkTimeout())
         {
            if(this.obf_e_N_1910 <= 0)
            {
               cmdNurserySchool.enabled = false;
               cmdCollege.enabled = false;
               cmdWorld.enabled = false;
               cmdBlood.enabled = false;
            }
            else
            {
               cmdNurserySchool.enabled = true;
               cmdCollege.enabled = true;
               cmdWorld.enabled = true;
               cmdBlood.enabled = true;
            }
         }
      }
      
      public function getIconItemBags() : Array
      {
         return [this.materiaBag];
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtBabyLv,"BoyUI","txtBabyLv");
         DiversityManager.setTextField(txtAtrrName,"BoyUI","txtAtrrName");
         DiversityManager.setTextField(txtSaturation,"BoyUI","txtSaturation");
         DiversityManager.setTextField(txtMaterial,"BoyUI","txtMaterial");
         DiversityManager.setTextField(txtDeyTitle,"BoyUI","txtDeyTitle");
         DiversityManager.setTextField(txtDayStrength,"BoyUI","txtDayStrength");
         DiversityManager.setTextField(txtDayAgility,"BoyUI","txtDayAgility");
         DiversityManager.setTextField(txtDayWisdom,"BoyUI","txtDayWisdom");
         DiversityManager.setTextField(txtDaySinew,"BoyUI","txtDaySinew");
         DiversityManager.setTextField(txtLvPlan,"BoyUI","txtLvPlan");
         remark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("BoyUI","remark") + "</a>";
         cmdFeed.label = DiversityManager.getString("BoyUI","cmdFeed");
         cmdNurserySchool.label = DiversityManager.getString("BoyUI","cmdNurserySchool");
         cmdCollege.label = DiversityManager.getString("BoyUI","cmdCollege");
         cmdWorld.label = DiversityManager.getString("BoyUI","cmdWorld");
         cmdBlood.label = DiversityManager.getString("BoyUI","cmdBlood");
         cmdUpperLimit1.label = DiversityManager.getString("BoyUI","cmdUpperLimit");
         cmdUpperLimit2.label = DiversityManager.getString("BoyUI","cmdUpperLimit");
         cmdUpperLimit3.label = DiversityManager.getString("BoyUI","cmdUpperLimit");
         cmdUpperLimit4.label = DiversityManager.getString("BoyUI","cmdUpperLimit");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showItem();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

