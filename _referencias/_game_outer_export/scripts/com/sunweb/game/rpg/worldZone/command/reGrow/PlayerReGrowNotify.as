package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReGrowNotify extends obf_O_8_1034
   {
      
      public var reGrowLevel:int;
      
      public var reGrowExp:Number;
      
      public function PlayerReGrowNotify()
      {
         super(CommandCodePlayerReGrow.PLAYER_RE_GROW_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["reGrowLevel:int","reGrowExp:uint"];
      }
   }
}

