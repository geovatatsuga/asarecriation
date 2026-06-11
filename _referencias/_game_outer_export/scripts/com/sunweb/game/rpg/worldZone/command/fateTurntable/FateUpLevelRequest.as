package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FateUpLevelRequest extends obf_O_8_1034
   {
      
      public var id:int;
      
      public function FateUpLevelRequest()
      {
         super(CommandCodeFateTurntable.FATE_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["id:ubyte"];
      }
   }
}

