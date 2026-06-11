package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IModalWindow;
   import flash.events.Event;
   import mmoprg.BgModuleUI;
   
   public class BackgroundModule extends BgModuleUI implements IModalWindow
   {
      
      public function BackgroundModule()
      {
         super();
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc1_:String = obf_r_8_1121.getParameter(["ost"]);
         DiversityManager.setTextField(txtTip,"BackgroundUI","txtTip",[_loc1_]);
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.stageWidth / 2;
         this.y = this.stage.stageHeight / 2;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

