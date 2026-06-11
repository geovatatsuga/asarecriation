package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDiedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var x:int;
      
      public var y:int;
      
      public var byPlayerId:String;
      
      public function PlayerDiedNotify()
      {
         super(CommandCodePlayer.PLAYER_DIED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","x:short","y:short","byPlayerId:string"];
      }
   }
}

