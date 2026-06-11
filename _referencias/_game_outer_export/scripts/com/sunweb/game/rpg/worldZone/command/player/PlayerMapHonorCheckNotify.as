package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMapHonorCheckNotify extends obf_O_8_1034
   {
      
      public var mapid:String;
      
      public var mapHonorChanged:int;
      
      public var mapHonorCurrent:int;
      
      public function PlayerMapHonorCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_MAP_HONOR_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapid:string","mapHonorChanged:int","mapHonorCurrent:int"];
      }
   }
}

