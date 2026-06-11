package com.sunweb.game.rpg.worldZone.command.wardrobe
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WardrobeAddRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public function WardrobeAddRequest()
      {
         super(CommandCodeWardrobe.WARDRODE_ADD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string"];
      }
   }
}

