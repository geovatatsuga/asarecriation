package com.sunweb.game.rpg.worldZone.command.wardrobe
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WardrobeUplevelAnswer extends obf_O_8_1034
   {
      
      public var currentLv:int;
      
      public var currentCount:int;
      
      public function WardrobeUplevelAnswer()
      {
         super(CommandCodeWardrobe.WARDRODE_UPLEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["currentLv:short","currentCount:ushort"];
      }
   }
}

