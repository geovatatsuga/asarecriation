package com.sunweb.game.rpg.worldZone.command.aegis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AegisUpdateAnswer extends obf_O_8_1034
   {
      
      public var isSuccessed:Boolean;
      
      public var aegisPray:int;
      
      public var aegisList:Array;
      
      public var aegisRank:int;
      
      public var aegisLevel:int;
      
      public function AegisUpdateAnswer()
      {
         super(AegisEventType.PLAYER_UPDATE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSuccessed:boolean","aegisPray:int","aegisList:array(ubyte)","aegisRank:ubyte","aegisLevel:ubyte"];
      }
   }
}

