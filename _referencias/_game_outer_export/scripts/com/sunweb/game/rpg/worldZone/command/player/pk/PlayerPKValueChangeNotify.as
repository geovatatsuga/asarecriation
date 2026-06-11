package com.sunweb.game.rpg.worldZone.command.player.pk
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   
   public class PlayerPKValueChangeNotify extends obf_O_8_1034
   {
      
      public var pkValueChanged:int;
      
      public var pkValueCurrent:int;
      
      public function PlayerPKValueChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_PK_VALUE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["pkValueChanged:byte","pkValueCurrent:byte"];
      }
   }
}

