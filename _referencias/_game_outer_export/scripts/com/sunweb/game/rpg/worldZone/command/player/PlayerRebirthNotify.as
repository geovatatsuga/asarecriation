package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRebirthNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var x:int;
      
      public var y:int;
      
      public var expLost:int;
      
      public var moneyLost:int;
      
      public function PlayerRebirthNotify()
      {
         super(CommandCodePlayer.PLAYER_REBIRTH_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","x:short","y:short","expLost:int","moneyLost:int"];
      }
   }
}

