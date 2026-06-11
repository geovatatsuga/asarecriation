package com.sunweb.game.rpg.worldZone.command.activityBox
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class Specially214BuyAnswer extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function Specially214BuyAnswer()
      {
         super(CommandTermConfig.obf_0_7_m_448);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

