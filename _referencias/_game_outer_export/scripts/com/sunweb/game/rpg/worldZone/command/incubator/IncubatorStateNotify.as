package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorStateNotify extends obf_O_8_1034
   {
      
      public var state:int;
      
      public function IncubatorStateNotify()
      {
         super(CommandCodeIncubator.INCUBATOR_STATE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["state:ubyte"];
      }
   }
}

