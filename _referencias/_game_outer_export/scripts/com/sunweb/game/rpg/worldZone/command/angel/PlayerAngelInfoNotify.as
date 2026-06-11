package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelInfoNotify extends obf_O_8_1034
   {
      
      public var angelList:Array;
      
      public var angelGodLevel:int;
      
      public var angelGodExp:int;
      
      public var rankMap:Object;
      
      public function PlayerAngelInfoNotify()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["angelList:array(com.sunweb.game.rpg.angel.AngelInfo)","angelGodLevel:ubyte","angelGodExp:int","rankMap:map(string,string)"];
      }
   }
}

