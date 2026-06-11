package com.sunweb.game.rpg.worldZone.command.aegis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AegisPlayerRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function AegisPlayerRequest()
      {
         super(AegisEventType.PLAYER_AEGIS_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

