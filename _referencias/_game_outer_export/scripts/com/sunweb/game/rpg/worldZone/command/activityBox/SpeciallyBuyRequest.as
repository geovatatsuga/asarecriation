package com.sunweb.game.rpg.worldZone.command.activityBox
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SpeciallyBuyRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public var itemNum:int;
      
      public function SpeciallyBuyRequest()
      {
         super(CommandTermConfig.SPECIALLY_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","itemNum:ubyte"];
      }
   }
}

