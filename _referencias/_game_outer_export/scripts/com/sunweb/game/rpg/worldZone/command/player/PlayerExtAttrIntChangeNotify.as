package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerExtAttrIntChangeNotify extends obf_O_8_1034
   {
      
      public var attr:int;
      
      public var valueChanged:int;
      
      public var valueCurrent:int;
      
      public function PlayerExtAttrIntChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["attr:byte","valueChanged:int","valueCurrent:int"];
      }
   }
}

