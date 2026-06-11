package com.sunweb.game.rpg.worldZone.command.tree
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreeInfoNotify extends obf_O_8_1034
   {
      
      public var rank:int;
      
      public var level:int;
      
      public var exp:int;
      
      public function TreeInfoNotify()
      {
         super(CommandCodePlayerTree.TREE_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rank:ubyte","level:ubyte","exp:int"];
      }
   }
}

