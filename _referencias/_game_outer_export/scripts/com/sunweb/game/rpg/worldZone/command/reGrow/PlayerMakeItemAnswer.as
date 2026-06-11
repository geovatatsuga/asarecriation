package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMakeItemAnswer extends obf_O_8_1034
   {
      
      public var exp:uint;
      
      public function PlayerMakeItemAnswer()
      {
         super(CommandCodePlayerReGrow.PLAYER_MAKE_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["exp:uint"];
      }
   }
}

