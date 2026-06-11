package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUpLandAnswer extends obf_O_8_1034
   {
      
      public var landsLevel:Object;
      
      public var creatures:Number;
      
      public var origins:int;
      
      public function PlayerUpLandAnswer()
      {
         super(CommandCodePlayerCountry.PLAYER_UP_LAND_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["landsLevel:map(string,ubyte)","creatures:uint","origins:int"];
      }
   }
}

