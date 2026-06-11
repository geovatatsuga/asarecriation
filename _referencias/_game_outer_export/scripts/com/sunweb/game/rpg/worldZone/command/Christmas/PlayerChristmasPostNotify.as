package com.sunweb.game.rpg.worldZone.command.Christmas
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChristmasPostNotify extends obf_O_8_1034
   {
      
      public var playerName:String;
      
      public var itemCode:String;
      
      public function PlayerChristmasPostNotify()
      {
         super(CommandCodePlayerGame.PLAYER_CHRISTMAS_POST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["playerName:string","itemCode:string"];
      }
   }
}

