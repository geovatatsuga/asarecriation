package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeUpRankRequest extends obf_O_8_1034
   {
      
      public function TreeUpRankRequest()
      {
         super(CommandCodePlayerTree.TREE_UP_RANK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

