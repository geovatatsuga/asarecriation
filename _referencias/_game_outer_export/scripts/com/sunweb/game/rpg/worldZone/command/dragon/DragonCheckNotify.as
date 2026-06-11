package com.sunweb.game.rpg.worldZone.command.dragon
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DragonCheckNotify extends obf_O_8_1034
   {
      
      public var dragonLevel:int;
      
      public var dragonExp:int;
      
      public function DragonCheckNotify()
      {
         super(CommandCodeDragon.PLAYER_DRAGON_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["dragonLevel:int","dragonExp:int"];
      }
   }
}

