package com.sunweb.game.rpg.world.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MapItemInfo extends obf_2_M_853
   {
      
      public var x:int;
      
      public var y:int;
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int = 1;
      
      public var protectionTimeLeft:int;
      
      public function MapItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["x:short","y:short","itemId:string","itemCode:string","itemCount:ubyte","protectionTimeLeft:byte"];
      }
   }
}

