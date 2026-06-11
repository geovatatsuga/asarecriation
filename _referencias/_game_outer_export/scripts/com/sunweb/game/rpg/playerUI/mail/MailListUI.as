package com.sunweb.game.rpg.playerUI.mail
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.mail.MailListItemInfo;
   import com.sunweb.game.rpg.mail.obf_G_6_4257;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MailUIMC;
   
   public class MailListUI extends MailUIMC implements IPlayerUI
   {
      
      private var _pageIndex:int;
      
      private var listTimeInv:TimeLimiter;
      
      public function MailListUI()
      {
         super();
         this.initDiversity();
         this.x = this.width / 2 + 50;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("MailListUI","listTitle"));
         _loc2_.dataField = "mailTitle";
         _loc2_.editable = false;
         _loc2_.sortable = false;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("MailListUI","listSender"));
         _loc3_.dataField = "mailSender";
         _loc3_.editable = false;
         _loc3_.sortable = false;
         _loc1_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("MailListUI","listDate"));
         _loc4_.dataField = "mailDate";
         _loc4_.editable = false;
         _loc4_.sortable = false;
         _loc1_.push(_loc4_);
         listMail.columns = _loc1_;
         listMail.labelFunction = this.mailListLabel;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"MailListUI","txtTitle");
         cmdPreviousPage.label = DiversityManager.getString("MailListUI","cmdPreviousPage");
         cmdNextPage.label = DiversityManager.getString("MailListUI","cmdNextPage");
         cmdSendMail.label = DiversityManager.getString("MailListUI","cmdSend");
         cmdViewMail.label = DiversityManager.getString("MailListUI","cmdView");
         cmdDelMail.label = DiversityManager.getString("MailListUI","cmdDelete");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdPreviousPage.addEventListener(MouseEvent.CLICK,this.obf_L_f_2709);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
         cmdDelMail.addEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdViewMail.addEventListener(MouseEvent.CLICK,this.obf_0_0_j_245);
         listMail.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.obf_0_0_j_245);
         cmdSendMail.addEventListener(MouseEvent.CLICK,this.onClickSend);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdPreviousPage.removeEventListener(MouseEvent.CLICK,this.obf_L_f_2709);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
         cmdDelMail.removeEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdViewMail.removeEventListener(MouseEvent.CLICK,this.obf_0_0_j_245);
         listMail.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.obf_0_0_j_245);
         cmdSendMail.removeEventListener(MouseEvent.CLICK,this.onClickSend);
      }
      
      public function setListCmdTimeInv() : void
      {
         cmdPreviousPage.enabled = false;
         cmdNextPage.enabled = false;
         cmdViewMail.enabled = false;
         this.listTimeInv = new TimeLimiter(1000);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.visible) && Boolean(this.listTimeInv) && this.listTimeInv.checkTimeout())
         {
            cmdPreviousPage.enabled = true;
            cmdNextPage.enabled = true;
            cmdViewMail.enabled = true;
            this.listTimeInv = null;
         }
      }
      
      private function onClickSend(param1:Event) : void
      {
         obf_G_6_4257.showSendMailUI(obf_G_6_4257.obf_0_9_5_629,"");
      }
      
      private function obf_S_X_2204(param1:Event) : void
      {
         if(!listMail.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailListUI","prompt_SelectDelete"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("MailListUI","prompt_DeleteConfirm"),this.confirmDelete,listMail.selectedItem.mailId);
      }
      
      private function confirmDelete(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_G_6_4257.sendDeleteMail(param1.par);
         }
      }
      
      private function obf_0_0_j_245(param1:Event) : void
      {
         if(this.listTimeInv)
         {
            return;
         }
         if(!listMail.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailListUI","prompt_SelectView"));
            return;
         }
         listMail.selectedItem.hasRead = true;
         listMail.invalidateList();
         obf_G_6_4257.sendViewMail(listMail.selectedItem.mailId);
         this.setListCmdTimeInv();
      }
      
      private function obf_L_f_2709(param1:Event) : void
      {
         if(this._pageIndex <= 0)
         {
            return;
         }
         --this._pageIndex;
         obf_G_6_4257.sendMailList(this._pageIndex);
         this.setListCmdTimeInv();
      }
      
      private function obf_C_R_4204(param1:Event) : void
      {
         ++this._pageIndex;
         obf_G_6_4257.sendMailList(this._pageIndex);
         this.setListCmdTimeInv();
      }
      
      public function refreshList() : void
      {
         obf_G_6_4257.sendMailList(this._pageIndex);
         this.setListCmdTimeInv();
      }
      
      public function setMailList(param1:Array, param2:int) : void
      {
         var _loc3_:MailListItemInfo = null;
         this._pageIndex = param2;
         DiversityManager.setTextField(txtPage,"MailListUI","txtPage",[this._pageIndex + 1],true);
         listMail.removeAll();
         for each(_loc3_ in param1)
         {
            if(_loc3_)
            {
               listMail.addItem(_loc3_);
            }
         }
      }
      
      private function mailListLabel(param1:Object, param2:DataGridColumn) : String
      {
         if(!param1.hasRead && param2.dataField == "mailTitle")
         {
            return "* " + param1[param2.dataField];
         }
         return param1[param2.dataField];
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
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         if(!this.listTimeInv)
         {
            this.refreshList();
         }
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

