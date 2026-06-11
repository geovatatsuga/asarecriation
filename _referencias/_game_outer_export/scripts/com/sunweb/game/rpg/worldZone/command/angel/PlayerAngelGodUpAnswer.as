package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelGodUpAnswer extends obf_O_8_1034
   {
      
      public var angelGodLevel:int;
      
      public var angelGodExp:int;
      
      public var rankMap:Object;
      
      public function PlayerAngelGodUpAnswer()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_GOD_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["angelGodLevel:ubyte","angelGodExp:int","rankMap:map(string,string)"];
      }
   }
}

