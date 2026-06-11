package com.sunweb.game.rpg.worldZone.command.aegis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AegisUpLevelAnswer extends obf_O_8_1034
   {
      
      public var aegisValue:int;
      
      public var aegisLevel:int;
      
      public function AegisUpLevelAnswer()
      {
         super(AegisEventType.PLAYER_UP_LEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["aegisValue:ushort","aegisLevel:ubyte"];
      }
   }
}

