package com.sunweb.game.rpg.worldZone.command.aegis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AegisPrayAnswer extends obf_O_8_1034
   {
      
      public var aegisPray:int;
      
      public var aegisList:Array;
      
      public var aegisValue:int;
      
      public var turnIndex:int;
      
      public function AegisPrayAnswer()
      {
         super(AegisEventType.PLAYER_PRAY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["aegisPray:int","aegisList:array(ubyte)","aegisValue:ushort","turnIndex:ubyte"];
      }
   }
}

