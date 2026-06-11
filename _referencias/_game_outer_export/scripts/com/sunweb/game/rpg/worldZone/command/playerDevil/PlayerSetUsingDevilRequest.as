package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetUsingDevilRequest extends obf_O_8_1034
   {
      
      public var devilId:String;
      
      public function PlayerSetUsingDevilRequest()
      {
         super(CommandCodePlayerDevil.PLAYER_SET_USING_DEVIL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string"];
      }
   }
}

