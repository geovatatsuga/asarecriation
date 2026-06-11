package com.sunweb.game.rpg.playerUI.systems
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.sysmsg.SysMsgInfo;
   import com.sunweb.game.rpg.sysmsg.obf_a_L_2059;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.SysMsgUIMC;
   
   public class SysMsgUI extends SysMsgUIMC implements IPlayerUI
   {
      
      private var obf_J_k_4026:int;
      
      private var obf_e_e_4222:Boolean = true;
      
      public function SysMsgUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         scrollContent.visible = false;
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
         DiversityManager.setTextField(txtDeyTitle,"SysMsgUI","txtTitle");
         cmdPrv.label = DiversityManager.getString("SysMsgUI","cmdPrvPage");
         cmdNext.label = DiversityManager.getString("SysMsgUI","cmdNextPage");
         cmdTop.label = DiversityManager.getString("SysMsgUI","cmdFirstPage");
      }
      
      public function get page() : int
      {
         return this.obf_J_k_4026;
      }
      
      public function set obf_5_8_3960(param1:Boolean) : void
      {
         this.obf_e_e_4222 = param1;
         if(param1 && this.visible && this.obf_J_k_4026 == 1)
         {
            obf_a_L_2059.obf_5_U_4501(1);
         }
         if(obf_K_e_3075.systemTipUI)
         {
            obf_K_e_3075.systemTipUI.setNewSysmsg(param1);
         }
      }
      
      public function get obf_5_8_3960() : Boolean
      {
         return this.obf_e_e_4222;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrv.addEventListener(MouseEvent.CLICK,this.obf_I_e_3834);
         cmdNext.addEventListener(MouseEvent.CLICK,this.obf_c_R_2056);
         cmdTop.addEventListener(MouseEvent.CLICK,this.obf_F_P_2050);
         txtContent.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPrv.removeEventListener(MouseEvent.CLICK,this.obf_I_e_3834);
         cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_c_R_2056);
         cmdTop.removeEventListener(MouseEvent.CLICK,this.obf_F_P_2050);
         txtContent.removeEventListener(TextEvent.LINK,this.onClickLink);
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_I_e_3834(param1:Event) : void
      {
         if(this.obf_J_k_4026 > 1)
         {
            obf_a_L_2059.obf_5_U_4501(this.obf_J_k_4026 - 1);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("SysMsgUI","promptIsFirstNow"));
         }
      }
      
      private function obf_c_R_2056(param1:Event) : void
      {
         obf_a_L_2059.obf_5_U_4501(this.obf_J_k_4026 + 1);
      }
      
      private function obf_F_P_2050(param1:Event) : void
      {
         if(this.obf_J_k_4026 > 1)
         {
            obf_a_L_2059.obf_5_U_4501(1);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("SysMsgUI","promptIsFirstNow"));
         }
      }
      
      public function showSysMsg(param1:Array, param2:int) : void
      {
         var _loc4_:SysMsgInfo = null;
         if(!param1 || param1.length == 0)
         {
            return;
         }
         this.obf_J_k_4026 = param2;
         DiversityManager.setTextField(txtPage,"SysMsgUI","txtPage",[param2],true);
         var _loc3_:String = "";
         for each(_loc4_ in param1)
         {
            _loc3_ += _loc4_.msgTime + "-" + ChatDecoder.decode(_loc4_.msgContent) + "\n";
         }
         txtContent.htmlText = _loc3_;
         scrollContent.visible = scrollContent.enabled;
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
         if(this.obf_e_e_4222)
         {
            obf_a_L_2059.obf_5_U_4501(1);
         }
         this.visible = true;
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

