package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class obf_J_q_3184 extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public var num:int;
      
      public function obf_J_q_3184()
      {
         super(CommandCodeShop.obf_0_8_I_624);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","num:ubyte"];
      }
   }
}

