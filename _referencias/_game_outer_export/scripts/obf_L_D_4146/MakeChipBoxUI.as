package obf_L_D_4146
{
   import obf_H_I_939.obf_u_Z_4014;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MakeChipBoxUIMC;
   
   public class MakeChipBoxUI extends MakeChipBoxUIMC implements IPlayerUI
   {
      
      private const obf_D_i_2247:String = "$chipKey";
      
      public function MakeChipBoxUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdMake.addEventListener(MouseEvent.CLICK,this.obf_0_5_5_394);
         cmdDraw.addEventListener(MouseEvent.CLICK,this.obf_0_5_d_453);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdMake.addEventListener(MouseEvent.CLICK,this.obf_0_5_5_394);
         cmdDraw.addEventListener(MouseEvent.CLICK,this.obf_0_5_d_453);
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
      
      private function obf_0_5_5_394(param1:Event) : void
      {
         param1.stopPropagation();
         if(!obf_K_e_3075.makeChipUI)
         {
            return;
         }
         if(obf_K_e_3075.makeChipUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.makeChipUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.makeChipUI);
         }
         this.closeUI();
      }
      
      private function obf_0_5_d_453(param1:Event) : void
      {
         if(obf_u_Z_4014.makeChipGetBadKeyToDay < 1)
         {
            return;
         }
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_D_i_2247);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MakeChipBoxUI","alreadyDraw"));
            return;
         }
         obf_u_Z_4014.sendFreeGetBadKeyReq();
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"MakeChipBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtExplain,"MakeChipBoxUI","txtExplain");
         DiversityManager.setTextField(txtName1,"MakeChipBoxUI","txtName1");
         DiversityManager.setTextField(txtName2,"MakeChipBoxUI","txtName2");
         DiversityManager.setTextField(txtName3,"MakeChipBoxUI","txtName3");
         DiversityManager.setTextField(txtExplain1,"MakeChipBoxUI","txtExplain1");
         DiversityManager.setTextField(txtExplain2,"MakeChipBoxUI","txtExplain2");
         DiversityManager.setTextField(txtExplain3,"MakeChipBoxUI","txtExplain3");
         cmdMake.label = DiversityManager.getString("MakeChipBoxUI","cmdMake");
         cmdDraw.label = DiversityManager.getString("MakeChipBoxUI","cmdDraw");
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

