package com.sunweb.game.rpg.worldZone.command.wingSpirit
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerWingSpiritRequest extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public var spiritType:int;
      
      public var doType:int;
      
      public function PlayerWingSpiritRequest()
      {
         super(CommandCodePlayerWingSpirit.PLAYER_WING_SPIRIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string","spiritType:ubyte","doType:ubyte"];
      }
   }
}

