package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUpLandRequest extends obf_O_8_1034
   {
      
      public var landName:String;
      
      public function PlayerUpLandRequest()
      {
         super(CommandCodePlayerCountry.PLAYER_UP_LAND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["landName:string"];
      }
   }
}

