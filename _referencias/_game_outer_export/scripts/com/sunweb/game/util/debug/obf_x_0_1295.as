package com.sunweb.game.util.debug
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class obf_x_0_1295 extends Sprite
   {
      
      public static var instance:obf_x_0_1295 = null;
      
      private var obf_X_4_2074:obf_o_R_1065 = new obf_o_R_1065();
      
      private var obf_5_o_4452:obf_m_v_1088 = new obf_m_v_1088();
      
      private var obf_F_p_3892:TextField = new TextField();
      
      public function obf_x_0_1295(param1:Boolean = false)
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.obf_y_v_2029);
         addEventListener(Event.REMOVED_FROM_STAGE,this.obf_q_m_1513);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 16711680;
         _loc2_.size = 12;
         _loc2_.bold = false;
         _loc2_.font = "Verdana";
         this.obf_F_p_3892.multiline = true;
         this.obf_F_p_3892.width = 500;
         this.obf_F_p_3892.height = 300;
         this.obf_F_p_3892.textColor = 13553358;
         this.obf_F_p_3892.defaultTextFormat = _loc2_;
         this.obf_F_p_3892.y = 40;
         if(param1)
         {
            this.addChild(this.obf_F_p_3892);
         }
         if(instance == null)
         {
            instance = this;
         }
      }
      
      public static function obf_r_w_3556(... rest) : void
      {
         if(instance == null)
         {
            trace(rest);
         }
         else
         {
            instance.obf_r_w_3556(rest);
         }
      }
      
      private function obf_y_v_2029(param1:Event) : void
      {
         this.addChild(this.obf_X_4_2074);
         this.obf_5_o_4452.y = 20;
         this.addChild(this.obf_5_o_4452);
      }
      
      private function obf_q_m_1513(param1:Event) : void
      {
         this.removeChild(this.obf_X_4_2074);
         this.removeChild(this.obf_5_o_4452);
      }
      
      public function obf_r_w_3556(... rest) : void
      {
         trace(rest);
         if(this.obf_F_p_3892.text.length > 0)
         {
            this.obf_F_p_3892.appendText("\n");
         }
         this.obf_F_p_3892.appendText((rest as Array).join(" "));
         this.obf_F_p_3892.scrollV = this.obf_F_p_3892.maxScrollV;
      }
   }
}

