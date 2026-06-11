package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapDamageValueCheckNotify extends obf_O_8_1034
   {
      
      public var damageValue:int;
      
      public function MapDamageValueCheckNotify()
      {
         super(CommandCodeMap.MAP_DAMAGE_VALUE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["damageValue:int"];
      }
   }
}

