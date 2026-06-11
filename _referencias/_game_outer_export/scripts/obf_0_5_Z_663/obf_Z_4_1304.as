package obf_0_5_Z_663
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.GenieMagicSkillCeilUIMC;
   
   public class obf_Z_4_1304 extends GenieMagicSkillCeilUIMC
   {
      
      public static const obf_v_y_2674:String = "GenieMagic_Click_Up";
      
      private var obf_H_r_2263:Object;
      
      private var obf_F_V_4405:String;
      
      public function obf_Z_4_1304(param1:Object)
      {
         super();
         this.initDiversity();
         this.addListener();
      }
      
      public function get configObj() : Object
      {
         return this.obf_H_r_2263;
      }
      
      public function set configObj(param1:Object) : void
      {
         this.obf_H_r_2263 = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtSkill,"GenieMagicBoxUI","txtSkill");
      }
      
      private function addListener() : void
      {
         cmdAdd.addEventListener(MouseEvent.CLICK,this.obf_T_C_2129);
         cmdAdd.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         cmdAdd.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeListener() : void
      {
         cmdAdd.removeEventListener(MouseEvent.CLICK,this.obf_T_C_2129);
         cmdAdd.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         cmdAdd.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function obf_T_C_2129(param1:MouseEvent) : void
      {
         this.dispatchEvent(new Event(obf_v_y_2674));
      }
      
      private function onMouseOver(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("GenieMagicSkillUpCondition");
         var _loc3_:int = 200;
         _loc2_.addTipInfo("<P align=\'center\'><font color=\'#FFFF00\'>" + DiversityManager.getString("PlayerSkillPrompt","learnSkillPrompt_Title") + "</font></P>",_loc3_,0);
         _loc2_.addTipInfo(this.getTips(),_loc3_,_loc2_.maxRow + 1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         GameTipManager.closeTip("GenieMagicSkillUpCondition");
      }
      
      public function setRemark(param1:String) : void
      {
         txtSkill.htmlText = param1;
      }
      
      public function getTips() : String
      {
         return this.obf_F_V_4405;
      }
      
      public function setTips(param1:String) : void
      {
         this.obf_F_V_4405 = param1;
      }
      
      public function setGrade(param1:int, param2:int) : void
      {
         txtLevel.text = "";
         txtLevel.text = param1 + "/" + param2;
      }
      
      override public function get height() : Number
      {
         return 50;
      }
      
      override public function get width() : Number
      {
         return 240;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

