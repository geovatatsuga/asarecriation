package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEnterMapRequest extends obf_O_8_1034
   {
      
      public var fromMapId:String;
      
      public var fromExitId:String;
      
      public function PlayerEnterMapRequest()
      {
         super(CommandCodePlayer.PLAYER_ENTER_MAP_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["fromMapId:string","fromExitId:string"];
      }
   }
}

