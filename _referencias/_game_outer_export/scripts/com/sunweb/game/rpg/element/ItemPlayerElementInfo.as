package com.sunweb.game.rpg.element
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ItemPlayerElementInfo extends obf_2_M_853
   {
      
      public var level:int;
      
      public var exp:int;
      
      public var isLock:Boolean;
      
      public function ItemPlayerElementInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["level:ubyte","exp:int","isLock:boolean"];
      }
   }
}

