package com.sunweb.game.rpg.playerUI.family
{
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyViewInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.FamilyViewUIMC;
   
   public class FamilyViewUI extends FamilyViewUIMC implements IPlayerUI
   {
      
      public function FamilyViewUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyViewUI","txtTitle");
         DiversityManager.setTextField(txtDeyFamilyLevel,"FamilyViewUI","txtFamilyLevel");
         DiversityManager.setTextField(txtDeyFamilyLeader,"FamilyViewUI","txtFamilyLeader");
         DiversityManager.setTextField(txtDeyFamilyGold,"FamilyViewUI","txtFamilyGold");
         DiversityManager.setTextField(txtDeyFamilyExp,"FamilyViewUI","txtFamilyExp");
         DiversityManager.setTextField(txtDeyFamilyRes2,"FamilyViewUI","txtFamilyRes2");
         DiversityManager.setTextField(txtDeyMemberNumber,"FamilyViewUI","txtFamilyMemberNumber");
         DiversityManager.setTextField(txtDeyFamilyIntroduction,"FamilyViewUI","txtFamilyIntroduction");
         cmdJoin.label = DiversityManager.getString("FamilyViewUI","cmdJoin");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdJoin.addEventListener(MouseEvent.CLICK,this.obf_V_a_4586);
         txtFamilyLeader.addEventListener(TextEvent.LINK,this.obf_M_j_3319);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdJoin.removeEventListener(MouseEvent.CLICK,this.obf_V_a_4586);
         txtFamilyLeader.removeEventListener(TextEvent.LINK,this.obf_M_j_3319);
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
      
      private function obf_V_a_4586(param1:Event) : void
      {
         if(GameContext.localPlayer.hasFamily())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_youHasFamily"));
            return;
         }
         if(VersionConfig.enableJoinFamilyResume)
         {
            WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyListUI","promptInputJoinMsg"),null,txtFamilyName.text,20),obf_F_9_1495.confirmJoinRequest);
         }
         else
         {
            WindowManager.showConfirmBox("",obf_F_9_1495.confirmJoinRequestFast,txtFamilyName.text);
         }
      }
      
      private function obf_M_j_3319(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function setShowInfo(param1:FamilyViewInfo) : void
      {
         txtFamilyName.text = param1.familyName;
         txtFamilyLevel.text = param1.level + "";
         txtFamilyLeader.htmlText = ChatDecoder.decode(obf_g_u_3212.getRoleLinkCode(param1.leaderName));
         while(pointGold.numChildren > 0)
         {
            pointGold.removeChildAt(0);
         }
         pointGold.addChild(obf_a_f_2935.getGoldDisplay(param1.gold));
         txtFamilyExp.text = param1.exp + "";
         txtRes2.text = param1.res2 + "";
         txtMemberNumber.text = param1.onlineMemberNumber + "/" + param1.totalMemberNumber;
         txtFamilyIntroduction.text = param1.declaration;
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
         txtFamilyName.text = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

