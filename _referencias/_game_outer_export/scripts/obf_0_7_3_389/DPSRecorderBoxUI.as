package obf_0_7_3_389
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.world.map.MapDamageRankInfo;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.DPSRecorderBox;
   
   public class DPSRecorderBoxUI extends DPSRecorderBox
   {
      
      private var player:String;
      
      public function DPSRecorderBoxUI()
      {
         super();
         this.addListener();
      }
      
      private function addListener() : void
      {
         txtPlayer.addEventListener(MouseEvent.CLICK,this.obf_2_O_2810);
      }
      
      private function removeListener() : void
      {
         txtPlayer.removeEventListener(MouseEvent.CLICK,this.obf_2_O_2810);
      }
      
      private function obf_2_O_2810(param1:Event) : void
      {
         obf_X_Z_4427.showRoleMenu(this.player,new Point(GameContext.gameStage.mouseX,GameContext.gameStage.mouseY));
      }
      
      public function showDPSInfo(param1:MapDamageRankInfo, param2:int = 0, param3:int = 0) : void
      {
         if(!param1)
         {
            return;
         }
         this.player = param1.roleName;
         txtPlayer.text = param1.damageRank + ":" + param1.roleName;
         txtDPS.text = param1.damageValue + "K";
         var _loc4_:int = param2 - param3;
         var _loc5_:int = (param1.damageValue - param3) / _loc4_ * 100;
         barDPS.gotoAndStop(_loc5_);
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.removeListener();
      }
   }
}

