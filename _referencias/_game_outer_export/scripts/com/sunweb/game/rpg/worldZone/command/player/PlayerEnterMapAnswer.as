package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class PlayerEnterMapAnswer extends obf_O_8_1034
   {
      
      public var toMapId:String;
      
      public var toPosition:MapPoint;
      
      public var failureReason:String;
      
      public var lineIndex:int;
      
      public function PlayerEnterMapAnswer()
      {
         super(CommandCodePlayer.PLAYER_ENTER_MAP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["toMapId:string","toPosition:com.sunweb.game.rpg.world.map.MapPoint","failureReason:string","lineIndex:byte"];
      }
   }
}

