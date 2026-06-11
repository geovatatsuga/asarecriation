package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SetPlayerConstellationRequest extends obf_O_8_1034
   {
      
      public var dateTime:String;
      
      public function SetPlayerConstellationRequest()
      {
         super(CommandCodePlayerConstellation.SET_PLAYER_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["dateTime:string"];
      }
   }
}

