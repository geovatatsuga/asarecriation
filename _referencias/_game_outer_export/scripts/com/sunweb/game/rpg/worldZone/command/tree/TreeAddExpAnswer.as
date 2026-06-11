package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeAddExpAnswer extends obf_O_8_1034
   {
      
      public var level:int;
      
      public var exp:int;
      
      public function TreeAddExpAnswer()
      {
         super(CommandCodePlayerTree.TREE_ADD_EXP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["level:ubyte","exp:int"];
      }
   }
}

