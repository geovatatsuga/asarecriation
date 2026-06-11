package com.sunweb.game.rpg.worldZone.command.aegis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AegisPlayerNotify extends obf_O_8_1034
   {
      
      public var aegisPray:int;
      
      public var aegisList:Array;
      
      public var aegisRank:int;
      
      public var aegisLevel:int;
      
      public var aegisValue:int;
      
      public function AegisPlayerNotify()
      {
         super(AegisEventType.PLAYER_AEGIS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["aegisPray:int","aegisList:array(ubyte)","aegisRank:ubyte","aegisLevel:ubyte","aegisValue:ushort"];
      }
   }
}

