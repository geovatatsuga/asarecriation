package obf_a_l_3879
{
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import playerUI.cardPrompt;
   
   public class obf_N_Q_1998 extends cardPrompt implements IPlayerUI
   {
      
      public function obf_N_Q_1998()
      {
         super();
         this.visible = false;
         this.alpha = 0.9;
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
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
      }
   }
}

