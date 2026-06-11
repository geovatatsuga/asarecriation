package com.sunweb.game.rpg.playerUI.family
{
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyJoinRequestInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.FamilyJoinListUIMC;
   
   public class FamilyJoinListUI extends FamilyJoinListUIMC implements IPlayerUI
   {
      
      public function FamilyJoinListUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyJoinListUI","titlePlayerName"));
         _loc2_.dataField = "playerId";
         _loc2_.editable = false;
         _loc2_.width = 80;
         _loc2_.minWidth = 80;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyJoinListUI","titleJoinTime"));
         _loc3_.dataField = "requestTime";
         _loc3_.editable = false;
         _loc1_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("FamilyJoinListUI","titleMsg"));
         _loc4_.dataField = "requestMsg";
         _loc4_.editable = false;
         _loc1_.push(_loc4_);
         listJoin.columns = _loc1_;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyJoinListUI","txtTitle");
         cmdIsAgreed.label = DiversityManager.getString("FamilyJoinListUI","cmdIsAgreed");
         cmdNotAgreed.label = DiversityManager.getString("FamilyJoinListUI","cmdNotAgreed");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdIsAgreed.addEventListener(MouseEvent.CLICK,this.obf_C_F_2461);
         cmdNotAgreed.addEventListener(MouseEvent.CLICK,this.obf_7_P_4219);
         listJoin.addEventListener(ListEvent.ITEM_CLICK,this.obf_u_4_2701);
         txtPlayerName.addEventListener(TextEvent.LINK,this.obf_b_E_977);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdIsAgreed.removeEventListener(MouseEvent.CLICK,this.obf_C_F_2461);
         cmdNotAgreed.removeEventListener(MouseEvent.CLICK,this.obf_7_P_4219);
         listJoin.removeEventListener(ListEvent.ITEM_CLICK,this.obf_u_4_2701);
         txtPlayerName.removeEventListener(TextEvent.LINK,this.obf_b_E_977);
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
      
      private function obf_b_E_977(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function setPlayerList(param1:Array) : void
      {
         var _loc2_:FamilyJoinRequestInfo = null;
         txtPlayerName.htmlText = "";
         txtRequestMsg.text = "";
         listJoin.dataProvider = new DataProvider();
         for each(_loc2_ in param1)
         {
            listJoin.addItem(_loc2_);
         }
      }
      
      private function obf_u_4_2701(param1:ListEvent) : void
      {
         var _loc2_:FamilyJoinRequestInfo = param1.item as FamilyJoinRequestInfo;
         txtPlayerName.htmlText = ChatDecoder.decode(obf_g_u_3212.getRoleLinkCode(_loc2_.playerId));
         txtRequestMsg.text = _loc2_.requestMsg;
      }
      
      private function obf_C_F_2461(param1:Event) : void
      {
         if(!listJoin.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyJoinListUI","prompt_NotSelectPlayer"));
            return;
         }
         obf_F_9_1495.sendProcessJoin(listJoin.selectedItem.playerId,true);
      }
      
      private function obf_7_P_4219(param1:Event) : void
      {
         if(!listJoin.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyJoinListUI","prompt_NotSelectPlayer"));
            return;
         }
         obf_F_9_1495.sendProcessJoin(listJoin.selectedItem.playerId,false);
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
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         listJoin.dataProvider.removeAll();
         txtPlayerName.htmlText = "";
         txtRequestMsg.text = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

