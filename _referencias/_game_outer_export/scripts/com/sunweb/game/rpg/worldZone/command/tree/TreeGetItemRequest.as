package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeGetItemRequest extends obf_O_8_1034
   {
      
      public function TreeGetItemRequest()
      {
         super(CommandCodePlayerTree.TREE_GET_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

