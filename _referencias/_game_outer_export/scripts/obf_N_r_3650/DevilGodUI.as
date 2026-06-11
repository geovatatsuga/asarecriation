package obf_N_r_3650
{
   import obf_S_0_4540.DevilGodManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.skill.obf_b_5_962;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.DevilGodBoxUIMC;
   import playerUI.SkillShowBoxUIMC;
   
   public class DevilGodUI extends DevilGodBoxUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var bags:Array;
      
      private var skillShowBoxList:Array;
      
      private var devilGodImage:obf_9_c_4534;
      
      public var devilGodLevel:int;
      
      public var powerValue:int;
      
      public var devilGodGrow:int;
      
      private var imageActiveTimeInv:TimeLimiter;
      
      public function DevilGodUI()
      {
         var _loc2_:SkillShowBoxUIMC = null;
         var _loc3_:obf_b_5_962 = null;
         this.imageActiveTimeInv = new TimeLimiter(2000);
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         bgBox1.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         bgBox3.mouseEnabled = false;
         txtAttrExplain.mouseEnabled = false;
         this.onResize(null);
         this.bags = new Array();
         this.skillShowBoxList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this["skillBag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new obf_b_5_962(_loc2_,this,"");
               _loc3_.cmdUpButton.visible = false;
               _loc3_.iconBag.showInfoTip = true;
               this.skillShowBoxList.push(_loc3_);
               this.bags.push(_loc3_.iconBag);
            }
            _loc1_++;
         }
         growBar.gotoAndStop(1);
         powerBar.gotoAndStop(1);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdEatPet.addEventListener(MouseEvent.CLICK,this.obf_W_3699);
         cmdUseMoney.addEventListener(MouseEvent.CLICK,this.obf_w_A_2725);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.iconBag.addEventListener(MouseEvent.MOUSE_OVER,this.obf_x_m_2333);
            _loc1_.iconBag.addEventListener(MouseEvent.MOUSE_OUT,this.obf_L_H_2052);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdEatPet.removeEventListener(MouseEvent.CLICK,this.obf_W_3699);
         cmdUseMoney.removeEventListener(MouseEvent.CLICK,this.obf_w_A_2725);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.iconBag.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_x_m_2333);
            _loc1_.iconBag.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_L_H_2052);
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
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
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.devilGodImage) && this.imageActiveTimeInv.checkTimeout())
         {
            this.devilGodImage.onUpdate();
            this.devilGodImage.doAction(obf_S_c_3330.obf_r_q_3113,obf_D_0_1300.DOWN,true);
         }
      }
      
      private function obf_W_3699(param1:Event) : void
      {
         param1.stopPropagation();
         if(!obf_K_e_3075.devilGodUsePetUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.devilGodUsePetUI);
         }
      }
      
      private function obf_w_A_2725(param1:Event) : void
      {
         param1.stopPropagation();
         if(!obf_K_e_3075.devilGodUseMoneyUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.devilGodUseMoneyUI);
         }
      }
      
      private function obf_x_m_2333(param1:Event) : void
      {
         var _loc2_:int = 200;
         GameTipManager.closeTip("DevilGodSkillExplain");
         var _loc3_:IconItemBag = param1.currentTarget as IconItemBag;
         if(!_loc3_ || !_loc3_.haveIconItem)
         {
            return;
         }
         var _loc4_:IconItemSkill = _loc3_.haveIconItem as IconItemSkill;
         if(!_loc4_ || obf_L_l_4100.isEmpty(_loc4_.itemCode))
         {
            return;
         }
         var _loc5_:Object = SkillConfig.getSkillConfig(_loc4_.itemCode);
         var _loc6_:int = _loc4_.itemCount;
         var _loc7_:Object = _loc5_["levelInfo"][_loc6_ - 1];
         if(!_loc7_)
         {
            return;
         }
         var _loc8_:GameTipUI = new GameTipUI("DevilGodSkillExplain");
         _loc8_.addTipInfo("<FONT COLOR=\'#" + obf_0_3_0_538.obf_J_P_1631.toString(16) + "\'><p align=\'center\'>" + _loc5_.name + " Lv." + _loc6_ + "</p></FONT>",_loc2_,0);
         _loc8_.addTipInfo(_loc7_.detail,_loc2_,_loc8_.maxRow + 1);
         GameTipManager.showTip(_loc8_);
      }
      
      private function obf_L_H_2052(param1:Event) : void
      {
         GameTipManager.closeTip("DevilGodSkillExplain");
      }
      
      public function showAllInfo() : void
      {
         if(this.devilGodLevel < 1)
         {
            return;
         }
         txtAttrExplain.htmlText = "";
         var _loc1_:Array = DevilGodManager.devilGodDevilGodInfo;
         var _loc2_:Object = _loc1_[this.devilGodLevel - 1];
         var _loc3_:String = DiversityManager.getString("DevilGodUI","devilGodLevel") + this.devilGodLevel + "\n\n";
         var _loc4_:Number = _loc2_.attrMul * 100;
         var _loc5_:String = DiversityManager.getString("DevilGodUI","devilGodCurrentAttr") + _loc4_.toFixed(2) + "%";
         txtAttrExplain.htmlText = _loc3_ + _loc5_;
         this.showDevilGodImage(_loc2_.model);
         this.showDevilGodSkills(_loc2_.skill);
      }
      
      private function showDevilGodSkills(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc5_:obf_b_5_962 = null;
         var _loc6_:IconItemSkill = null;
         PlayerSkillManager.setDevilGodSkill(param1);
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            if(_loc2_ >= this.skillShowBoxList.length)
            {
               return;
            }
            _loc4_ = SkillConfig.getSkillConfig(_loc3_);
            if(!_loc4_)
            {
               return;
            }
            _loc5_ = this.skillShowBoxList[_loc2_];
            _loc6_ = IconItemSkill.getNewIconItem(_loc3_,1);
            if(!_loc6_)
            {
               return;
            }
            _loc6_.level = param1[_loc3_];
            _loc6_.itemCount = _loc6_.level;
            _loc5_.iconBag.lockDrag = JSONUtil.getInt(_loc4_,["type"]) == obf_M_F_3694.obf_u_8_4559;
            _loc5_.iconBag.dropIconItem();
            _loc5_.iconBag.pushIconItem(_loc6_);
            _loc2_++;
         }
      }
      
      private function obf_O_k_4227() : void
      {
         while(pointModle.numChildren > 0)
         {
            pointModle.removeChildAt(0);
         }
         if(this.devilGodImage)
         {
            this.devilGodImage.destroy();
         }
         this.devilGodImage = null;
      }
      
      private function showDevilGodImage(param1:String) : void
      {
         this.obf_O_k_4227();
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         this.devilGodImage = new obf_9_c_4534(param1);
         pointModle.addChild(this.devilGodImage);
      }
      
      public function showDevilGodLevel(param1:int) : void
      {
         this.devilGodLevel = param1;
      }
      
      public function showDevilGodPower(param1:int) : void
      {
         this.powerValue = param1;
         var _loc2_:Array = DevilGodManager.devilGodDevilGodInfo;
         if(this.devilGodLevel >= _loc2_.length)
         {
            DiversityManager.setTextField(txtGrow,"DevilGodUI","txtMaxLevel");
            growBar.gotoAndStop(1);
            cmdUseMoney.enabled = false;
            DiversityManager.setTextField(txtPower,"DevilGodUI","txtMaxLevel");
            powerBar.gotoAndStop(1);
            cmdEatPet.enabled = false;
            return;
         }
         DiversityManager.setTextField(txtPower,"DevilGodUI","txtPower",[param1 + "/" + DevilGodManager.devilGodPowerMax]);
         var _loc3_:int = param1 / DevilGodManager.devilGodPowerMax * 100;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         powerBar.gotoAndStop(_loc3_);
      }
      
      public function showDevilGodGrow(param1:int) : void
      {
         this.devilGodGrow = param1;
         var _loc2_:Array = DevilGodManager.devilGodDevilGodInfo;
         if(this.devilGodLevel >= _loc2_.length)
         {
            DiversityManager.setTextField(txtGrow,"DevilGodUI","txtMaxLevel");
            growBar.gotoAndStop(1);
            cmdUseMoney.enabled = false;
            DiversityManager.setTextField(txtPower,"DevilGodUI","txtMaxLevel");
            powerBar.gotoAndStop(1);
            cmdEatPet.enabled = false;
            return;
         }
         var _loc3_:int = int(_loc2_[this.devilGodLevel - 1].upGrow);
         DiversityManager.setTextField(txtGrow,"DevilGodUI","txtGrow",[param1 + "/" + _loc3_]);
         var _loc4_:int = param1 / _loc3_ * 100;
         if(_loc4_ < 1)
         {
            _loc4_ = 1;
         }
         growBar.gotoAndStop(_loc4_);
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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
         DiversityManager.setTextField(txtDeyTitle,"DevilGodUI","txtDeyTitle");
         DiversityManager.setTextField(txtAttrs,"DevilGodUI","txtAttrs");
         DiversityManager.setTextField(txtSkills,"DevilGodUI","txtSkills");
         DiversityManager.setTextField(txtPower,"DevilGodUI","txtPower",[0]);
         DiversityManager.setTextField(txtGrow,"DevilGodUI","txtGrow",[0]);
         cmdUseMoney.label = DiversityManager.getString("DevilGodUI","cmdUseMoney");
         cmdEatPet.label = DiversityManager.getString("DevilGodUI","cmdEatPet");
      }
      
      public function showUI() : void
      {
         this.visible = true;
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

