package com.sunweb.game.rpg.worldZone.command.dragon
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DragonUpgrageRequest extends obf_O_8_1034
   {
      
      public var multiple:int;
      
      public function DragonUpgrageRequest()
      {
         super(CommandCodeDragon.PLAYER_DRAGON_UPGRADE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["multiple:ubyte"];
      }
   }
}

