package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerItemCDCheckNotify extends obf_O_8_1034
   {
      
      public var cdItems:Array;
      
      public function PlayerItemCDCheckNotify()
      {
         super(CommandCodeBag.PLAYER_ITEM_CD_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["cdItems:array(com.sunweb.game.rpg.world.info.CDItemInfo)"];
      }
   }
}

