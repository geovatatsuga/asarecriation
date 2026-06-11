package obf_b_m_2084
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.challenge.obf_0_5_f_69;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.EffectUIMC;
   
   public class obf_W_9_2222 extends EffectUIMC implements IModalWindow
   {
      
      public function obf_W_9_2222(param1:Boolean)
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         DiversityManager.setTextField(txtRusult,"RobotChallengeUI","txtRusult");
         cmdOut.label = DiversityManager.getString("RobotChallengeUI","cmdOut");
         this.addListener();
         this.showResult(param1);
      }
      
      private function addListener() : void
      {
         bgbox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdOut.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         bgbox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdOut.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClick(param1:Event) : void
      {
         WindowManager.closeWindow(this);
         obf_0_5_f_69.sendOutMap();
      }
      
      private function showResult(param1:Boolean) : void
      {
         while(pointRusult.numChildren > 0)
         {
            pointRusult.removeChildAt(0);
         }
         if(param1)
         {
            obf_0_P_4381.obf_m_X_1194("win@winlose",pointRusult);
         }
         else
         {
            obf_0_P_4381.obf_m_X_1194("lose@winlose",pointRusult);
         }
         txtGet.text = DiversityManager.getString("RobotChallengeUI","txtGet",[param1 ? 10 : 5]);
         txtGet.textColor = param1 ? 6684671 : 16711680;
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

