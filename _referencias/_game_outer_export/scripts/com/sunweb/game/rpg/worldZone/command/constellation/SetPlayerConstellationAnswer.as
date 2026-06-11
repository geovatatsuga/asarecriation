package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SetPlayerConstellationAnswer extends obf_O_8_1034
   {
      
      public var constellation:int;
      
      public var constellationLevel:int;
      
      public var taskId:int;
      
      public var luckLevel:int;
      
      public function SetPlayerConstellationAnswer()
      {
         super(CommandCodePlayerConstellation.SET_PLAYER_CONSTELLATION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["constellation:ubyte","constellationLevel:ubyte","taskId:int","luckLevel:ubyte"];
      }
   }
}

