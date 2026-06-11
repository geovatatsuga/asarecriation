package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeUpRankAnswer extends obf_O_8_1034
   {
      
      public var rank:int;
      
      public var level:int;
      
      public var exp:int;
      
      public function TreeUpRankAnswer()
      {
         super(CommandCodePlayerTree.TREE_UP_RANK_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["rank:ubyte","level:ubyte","exp:int"];
      }
   }
}

