package com.sunweb.game.rpg.role
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MapTrapInfo extends obf_2_M_853
   {
      
      public var id:String;
      
      public var trapCode:String;
      
      public var x:int;
      
      public var y:int;
      
      public function MapTrapInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","trapCode:string","x:short","y:short"];
      }
   }
}

