package com.sunweb.game.rpg.playerUI.cloak
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import playerUI.UnlockMC;
   
   public class CloakUnlockMC extends UnlockMC
   {
      
      public function CloakUnlockMC()
      {
         super();
         this.initDiversity();
      }
      
      public function setName(param1:String) : void
      {
         obf_M_v_2594.text = param1;
      }
      
      public function setLevel(param1:int) : void
      {
         unlockLv.text = param1 + "";
      }
      
      public function setRemark(param1:String) : void
      {
         txtUnlockExplain.htmlText = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtUnlockName,"CloakBoxUI","txtUnlockName");
         DiversityManager.setTextField(txtUnlockLv,"CloakBoxUI","txtUnlockLv");
         DiversityManager.setTextField(txtUnlockMaterial,"CloakBoxUI","txtUnlockMaterial");
      }
   }
}

