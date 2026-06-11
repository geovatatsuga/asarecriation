package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.Facebook;
   
   public class obf_4_B_1970 extends Facebook implements IPlayerUI
   {
      
      public function obf_4_B_1970()
      {
         super();
         this.x = GameContext.gameStage.stageWidth - obf_K_e_3075.smallMapUI.width;
         cmdFree.visible = false;
         cmdFaceBook.visible = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdFaceBook.addEventListener(MouseEvent.CLICK,this.onClickFaceBook);
         cmdFree.addEventListener(MouseEvent.CLICK,this.obf_8_5_1314);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function removeListener() : void
      {
         cmdFaceBook.removeEventListener(MouseEvent.CLICK,this.onClickFaceBook);
         cmdFree.removeEventListener(MouseEvent.CLICK,this.obf_8_5_1314);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onClickFaceBook(param1:MouseEvent) : void
      {
         obf_H_l_800.call("likeClicked");
      }
      
      private function obf_8_5_1314(param1:MouseEvent) : void
      {
         obf_C_o_3363.openActionURL("FreeResult");
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - obf_K_e_3075.smallMapUI.width;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function showUI() : void
      {
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

