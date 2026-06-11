package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChangeModelNotify extends obf_O_8_1034
   {
      
      public var modelCode:String;
      
      public function PlayerChangeModelNotify()
      {
         super(CommandCodePlayer.PLAYER_CHANGE_MODEL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["modelCode:string"];
      }
   }
}

