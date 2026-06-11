package obf_y_y_3106
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.RewardBGUIMC;
   
   public class obf_D_o_4484 extends RewardBGUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var obf_5_F_4317:Array;
      
      private var obf_A_e_3998:IPlayerUI;
      
      public function obf_D_o_4484()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.obf_5_F_4317 = new Array();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         cmdPlayerInfo.gotoAndStop(2);
         cmdAllTask.gotoAndStop(1);
         cmdPlayerTask.gotoAndStop(1);
         cmdShop.gotoAndStop(1);
         cmdSuccess.gotoAndStop(1);
         obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_w_0_3587);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"rewardBoxUI","txtTitle");
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("rewardBoxUI","txtRewardInfo") + "</a>";
         DiversityManager.setTextField(cmdPlayerInfo.txtLabel,"rewardBoxUI","cmdPlayerInfo",null,true);
         DiversityManager.setTextField(cmdAllTask.txtLabel,"rewardBoxUI","cmdAllTask",null,true);
         DiversityManager.setTextField(cmdPlayerTask.txtLabel,"rewardBoxUI","cmdPlayerTask",null,true);
         DiversityManager.setTextField(cmdShop.txtLabel,"rewardBoxUI","cmdShop",null,true);
         DiversityManager.setTextField(cmdSuccess.txtLabel,"rewardBoxUI","cmdSuccess",null,true);
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPlayerInfo.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdAllTask.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdPlayerTask.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdShop.addEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdSuccess.addEventListener(MouseEvent.CLICK,this.onClickButton);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"txtRewardInfo");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPlayerInfo.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdAllTask.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdPlayerTask.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdShop.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         cmdSuccess.removeEventListener(MouseEvent.CLICK,this.onClickButton);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
      }
      
      private function changeButton(param1:Object) : void
      {
         cmdPlayerInfo.gotoAndStop(1);
         cmdAllTask.gotoAndStop(1);
         cmdPlayerTask.gotoAndStop(1);
         cmdShop.gotoAndStop(1);
         cmdSuccess.gotoAndStop(1);
         if(param1 == cmdPlayerInfo)
         {
            cmdPlayerInfo.gotoAndStop(2);
         }
         else if(param1 == cmdAllTask)
         {
            cmdAllTask.gotoAndStop(2);
         }
         else if(param1 == cmdPlayerTask)
         {
            cmdPlayerTask.gotoAndStop(2);
         }
         else if(param1 == cmdShop)
         {
            cmdShop.gotoAndStop(2);
         }
         else if(param1 == cmdSuccess)
         {
            cmdSuccess.gotoAndStop(2);
         }
      }
      
      private function onClickButton(param1:Event) : void
      {
         this.changeButton(param1.currentTarget);
         if(this.obf_A_e_3998)
         {
            obf_K_e_3075.closeChildUI(this,this.obf_A_e_3998);
         }
         if(param1.currentTarget == cmdPlayerInfo)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_w_0_3587);
         }
         else if(param1.currentTarget == cmdAllTask)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_0_8_g_462);
         }
         else if(param1.currentTarget == cmdPlayerTask)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_F_e_3603);
         }
         else if(param1.currentTarget == cmdShop)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_t_6_3555);
         }
         else if(param1.currentTarget == cmdSuccess)
         {
            obf_K_e_3075.showChildUI(this,obf_K_e_3075.obf_0___i_152);
         }
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         if(obf_K_e_3075.obf_w_0_3587.getRank <= 0)
         {
            return;
         }
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:IPlayerUI = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.obf_5_F_4317)
         {
            if(Boolean(_loc2_) && _loc2_ is IIconItemUI)
            {
               _loc1_ = _loc1_.concat((_loc2_ as IIconItemUI).getIconItemBags());
            }
         }
         return _loc1_;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
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
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointChildUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = param1;
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.obf_A_e_3998 = null;
      }
   }
}

