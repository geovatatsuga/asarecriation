package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeAddExpRequest extends obf_O_8_1034
   {
      
      public function TreeAddExpRequest()
      {
         super(CommandCodePlayerTree.TREE_ADD_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

