package com.sunweb.game.rpg.playerUI.cloak
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ActivationMC;
   
   public class CLoakActivationMC extends ActivationMC
   {
      
      public static const obf_S_S_1707:String = "ActivationMC_EVENT";
      
      private var obf_D_c_1975:IconItemBag;
      
      private var _itemConfig:Object;
      
      public function CLoakActivationMC(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this.obf_D_c_1975 = new IconItemBag(obf_V_L_2703,param1,0);
         this.obf_D_c_1975.addValidType(GameItemType.ALL);
         this.obf_D_c_1975.lockDrag = true;
         this.addListener();
      }
      
      public function get itemConfig() : Object
      {
         return this._itemConfig;
      }
      
      public function set itemConfig(param1:Object) : void
      {
         this._itemConfig = param1;
      }
      
      private function addListener() : void
      {
         cmdActivation.addEventListener(MouseEvent.CLICK,this.obf_0_4_b_151);
      }
      
      private function removeListener() : void
      {
         cmdActivation.removeEventListener(MouseEvent.CLICK,this.obf_0_4_b_151);
      }
      
      private function obf_0_4_b_151(param1:Event) : void
      {
         dispatchEvent(new Event(obf_S_S_1707));
      }
      
      public function get iconBag() : IconItemBag
      {
         return this.obf_D_c_1975;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function setName(param1:String) : void
      {
         obf_A_u_3278.text = param1;
      }
      
      public function setLevel(param1:int) : void
      {
         activationLv.text = param1 + "";
      }
      
      public function setRemark(param1:String) : void
      {
         txtActivationExplain.htmlText = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtActivationName,"CloakBoxUI","txtUnlockName");
         DiversityManager.setTextField(txtActivationLv,"CloakBoxUI","txtUnlockLv");
         DiversityManager.setTextField(txtActivationMaterial,"CloakBoxUI","txtActivationMaterial");
         cmdActivation.label = DiversityManager.getString("CloakBoxUI","cmdActivation");
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this.obf_D_c_1975) && this.obf_D_c_1975.parent == this)
         {
            this.obf_D_c_1975.destroy();
            this.removeChild(this.obf_D_c_1975);
         }
         this.obf_D_c_1975 = null;
      }
   }
}

