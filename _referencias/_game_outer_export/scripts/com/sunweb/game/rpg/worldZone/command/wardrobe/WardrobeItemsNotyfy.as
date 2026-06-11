package com.sunweb.game.rpg.worldZone.command.wardrobe
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WardrobeItemsNotyfy extends obf_O_8_1034
   {
      
      public var items:Array;
      
      public var attrs:Object;
      
      public function WardrobeItemsNotyfy()
      {
         super(CommandCodeWardrobe.WARDRODE_ITEMS_NOYIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:array(com.sunweb.game.rpg.wardrobe.WardrobeInfo)","attrs:map(ushort,int)"];
      }
   }
}

