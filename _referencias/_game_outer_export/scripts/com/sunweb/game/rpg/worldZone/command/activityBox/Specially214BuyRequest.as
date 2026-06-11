package com.sunweb.game.rpg.worldZone.command.activityBox
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class Specially214BuyRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function Specially214BuyRequest()
      {
         super(CommandTermConfig.obf_F_D_3557);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

