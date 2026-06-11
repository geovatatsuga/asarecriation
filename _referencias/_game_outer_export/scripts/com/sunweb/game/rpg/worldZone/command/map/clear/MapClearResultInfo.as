package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MapClearResultInfo extends obf_2_M_853
   {
      
      public var players:String;
      
      public var clearTimeInSec:int;
      
      public function MapClearResultInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["players:string","clearTimeInSec:int"];
      }
   }
}

