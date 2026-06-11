package com.sunweb.game.rpg.worldZone.command.dragon
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DragonUpgradeAnswer extends obf_O_8_1034
   {
      
      public var dragonLevel:int;
      
      public var dragonExp:int;
      
      public var dragonUpChanceNum:int;
      
      public var resultType:int;
      
      public var addExp:int;
      
      public function DragonUpgradeAnswer()
      {
         super(CommandCodeDragon.PLAYER_DRAGON_UPGRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["dragonLevel:int","dragonExp:int","dragonUpChanceNum:vint","resultType:ubyte","addExp:int"];
      }
   }
}

