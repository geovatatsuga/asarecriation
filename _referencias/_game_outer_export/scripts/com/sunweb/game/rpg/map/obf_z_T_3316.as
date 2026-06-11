package com.sunweb.game.rpg.map
{
   import flash.utils.getTimer;
   
   public class obf_z_T_3316 extends MapGroundObject
   {
      
      public var code:String;
      
      protected var obf_T_e_2291:int;
      
      protected var obf_W_i_2355:int;
      
      protected var obf_5_e_3288:Boolean;
      
      public function obf_z_T_3316(param1:String, param2:String, param3:String)
      {
         super(param3);
         this.zLevel = -10;
         id = param1;
         this.code = param2;
         this.obf_u_9_1772();
      }
      
      public function obf_H_4702(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         this.obf_T_e_2291 = param1 * 1000;
         this.obf_W_i_2355 = getTimer();
         this.obf_5_e_3288 = true;
         _labelTextField.textColor = 16711680;
      }
      
      public function obf_u_9_1772() : void
      {
         this.obf_T_e_2291 = 0;
         this.obf_W_i_2355 = 0;
         this.obf_5_e_3288 = false;
         _labelTextField.textColor = _labelColor;
      }
      
      public function get isInProtection() : Boolean
      {
         return this.obf_5_e_3288;
      }
      
      override public function onUpdate() : void
      {
         if(!this.obf_5_e_3288)
         {
            return;
         }
         if(getTimer() - this.obf_W_i_2355 > this.obf_T_e_2291)
         {
            this.obf_u_9_1772();
         }
      }
   }
}

