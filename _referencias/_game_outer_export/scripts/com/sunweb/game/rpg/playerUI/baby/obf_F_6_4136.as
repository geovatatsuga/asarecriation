package com.sunweb.game.rpg.playerUI.baby
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import playerUI.WorldUIMC;
   
   public class obf_F_6_4136 extends WorldUIMC implements IIconItemUI
   {
      
      private var mandLands:Array;
      
      private var stopTime:int;
      
      private var isExplore:Boolean = false;
      
      private var materiaBag:IconItemBag;
      
      private var isAward:Boolean;
      
      private var obf_n_2_1416:int = 0;
      
      private var obf_j_B_1080:int;
      
      private var obf_0_0_h_368:int;
      
      private var obf_7_O_836:TimeLimiter = new TimeLimiter(200);
      
      public function obf_F_6_4136()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         this.initDiversity();
         this.materiaBag = new IconItemBag(materialIconBar,this,0);
         this.materiaBag.lockDrag = true;
         this.materiaBag.addValidType(GameItemType.ALL);
         this.mandLands = [cmdMandLand1,cmdMandLand2,cmdMandLand3,cmdMandLand4,cmdMandLand5];
         cmdMandLand1.mouseEnabled = false;
         cmdMandLand2.mouseEnabled = false;
         cmdMandLand3.mouseEnabled = false;
         cmdMandLand4.mouseEnabled = false;
         cmdMandLand5.mouseEnabled = false;
         txtValue.mouseEnabled = false;
         txtLvValue.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         remark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdExplore.addEventListener(MouseEvent.CLICK,this.obf_O_4691);
         cmdAugury.addEventListener(MouseEvent.CLICK,this.obf_n_T_3180);
         cmdCelerity.addEventListener(MouseEvent.CLICK,this.obf_M_e_1215);
         cmdAward.addEventListener(MouseEvent.CLICK,this.obf_x_1085);
         obf_K_e_3075.addUIMouseToolTip(remark,"remarkWorld");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdExplore.removeEventListener(MouseEvent.CLICK,this.obf_O_4691);
         cmdAugury.removeEventListener(MouseEvent.CLICK,this.obf_n_T_3180);
         cmdCelerity.removeEventListener(MouseEvent.CLICK,this.obf_M_e_1215);
         cmdAward.removeEventListener(MouseEvent.CLICK,this.obf_x_1085);
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
      
      private function obf_h_1_2833(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("babyWorldTip");
         var _loc3_:int = 80;
         var _loc4_:Array = obf_s_1265.getTravelConfig().landConfig;
         var _loc5_:String = _loc4_[this.mandLands.indexOf(param1.currentTarget)].name;
         _loc2_.addTipInfo(_loc5_,_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_q_U_1691(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("babyWorldTip");
      }
      
      private function obf_O_4691(param1:Event) : void
      {
         if(this.isExplore)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","exploreing"));
            return;
         }
         obf_s_1265.senBabyTravelRequest();
         this.isExplore = true;
      }
      
      private function obf_x_1085(param1:Event) : void
      {
         obf_s_1265.sendBabyTravelOverRequest();
      }
      
      private function obf_n_T_3180(param1:Event) : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("BoyUI","sure2",[obf_s_1265.getTravelConfig().refreshMoney]),this.obf_i_k_2402);
      }
      
      private function obf_i_k_2402(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < obf_s_1265.getTravelConfig().refreshMoney)
            {
               WindowManager.showMessageBox(DiversityManager.getString("BoyUI","noMoney"));
               return;
            }
            obf_s_1265.sendBabyResetLuckLandRequest();
         }
      }
      
      private function obf_M_e_1215(param1:Event) : void
      {
         var _loc2_:String = obf_s_1265.getTravelConfig().overItem;
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantMaterial"));
            return;
         }
         obf_s_1265.sendTravelFastRequest();
      }
      
      public function obf_9_U_906(param1:int, param2:int, param3:int) : void
      {
         worldName.text = "";
         exploreName.text = "";
         var _loc4_:Object = obf_s_1265.getTravelConfig();
         var _loc5_:Array = JSONUtil.getValue(_loc4_,["landConfig"]) as Array;
         worldName.text = _loc5_[param1].name;
         var _loc6_:TextFormat = new TextFormat();
         _loc6_.underline = true;
         worldName.setTextFormat(_loc6_);
         if(param2 > -1)
         {
            this.obf_n_2_1416 = param3 * 1000;
            this.obf_j_B_1080 = getTimer();
            this.isAward = true;
            exploreName.text = _loc5_[param2].name;
            this.obf_0_0_h_368 = param2;
         }
         else
         {
            this.isAward = false;
            exploreName.text = DiversityManager.getString("BoyUI","noExplore");
         }
         var _loc7_:TextFormat = new TextFormat();
         _loc7_.underline = true;
         exploreName.setTextFormat(_loc7_);
      }
      
      public function setRimeValue(param1:int, param2:int) : void
      {
         txtValue.text = "";
         txtLvValue.text = "";
         txtLvValue.text = DiversityManager.getString("BoyUI","txtLvValue",[param2]);
         var _loc3_:Object = obf_s_1265.getBabyLevelConfig(param2);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 20)
         {
            txtValue.text = DiversityManager.getString("BoyUI","txtValue",[param1,_loc3_.exp]);
         }
         else
         {
            txtValue.text = DiversityManager.getString("BoyUI","txtValue",[0,0]);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.obf_7_O_836.checkTimeout())
         {
            if(this.obf_n_2_1416 > 0 && this.isAward)
            {
               _loc2_ = this.getDurationTimeInMS(this.obf_n_2_1416,this.obf_j_B_1080);
               if(_loc2_ <= 0)
               {
                  this.isExplore = false;
                  _loc2_ = 0;
                  this.obf_n_2_1416 = 0;
                  cmdAward.visible = true;
                  this.isExplore = false;
                  leavingsTime.text = DiversityManager.getString("BoyUI","canAward");
                  this.removeShineEffect();
               }
               else
               {
                  leavingsTime.text = obf_l_y_733.getTimeStringHHMMSS(_loc2_);
                  cmdAward.visible = false;
                  this.isExplore = true;
                  this.showEffect();
               }
            }
            else if(this.obf_n_2_1416 <= 0 && !this.isAward)
            {
               cmdAward.visible = false;
               this.isExplore = false;
               leavingsTime.text = DiversityManager.getString("BoyUI","canExplore");
               this.removeShineEffect();
            }
            else if(this.obf_n_2_1416 <= 0 && this.isAward)
            {
               cmdAward.visible = true;
               this.isExplore = false;
               leavingsTime.text = DiversityManager.getString("BoyUI","canAward");
               this.removeShineEffect();
            }
         }
      }
      
      public function getDurationTimeInMS(param1:int, param2:int) : Number
      {
         var _loc3_:int = getTimer();
         return param1 - (_loc3_ - param2);
      }
      
      private function showEffect() : void
      {
         while(this["effectPoint" + (this.obf_0_0_h_368 + 1)].numChildren > 0)
         {
            this["effectPoint" + (this.obf_0_0_h_368 + 1)].removeChildAt(0);
         }
         obf_0_P_4381.obf_q_h_1296("openCard@cardEfect",this["effectPoint" + (this.obf_0_0_h_368 + 1)],null,true,0,0);
      }
      
      private function removeShineEffect() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            while(this["effectPoint" + _loc1_].numChildren > 0)
            {
               this["effectPoint" + _loc1_].removeChildAt(0);
            }
            _loc1_++;
         }
      }
      
      private function showItem() : void
      {
         this.materiaBag.dropIconItem();
         var _loc1_:IconItem = IconItemManager.getIconItemByCode(obf_s_1265.getTravelConfig().overItem,"");
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
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         DiversityManager.setTextField(txtDeyTitle,"BoyUI","cmdWorld");
         DiversityManager.setTextField(txtWorldName,"BoyUI","txtWorldName");
         DiversityManager.setTextField(txtExploreName,"BoyUI","txtExploreName");
         cmdAugury.label = DiversityManager.getString("BoyUI","cmdAugury");
         cmdCelerity.label = DiversityManager.getString("BoyUI","cmdCelerity");
         cmdAward.label = DiversityManager.getString("BoyUI","cmdAward");
         cmdExplore.label = DiversityManager.getString("BoyUI","cmdExplore");
         remark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("BoyUI","remark") + "</a>";
         if(obf_s_1265.getTravelConfig())
         {
            _loc1_ = obf_s_1265.getTravelConfig().landConfig;
            _loc2_ = 1;
            while(_loc2_ <= 5)
            {
               (this["txtDatLand" + _loc2_] as TextField).text = _loc1_[_loc2_ - 1].name;
               _loc2_++;
            }
         }
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.showItem();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeShineEffect();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

