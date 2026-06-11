package com.sunweb.game.rpg.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class AngelInfo extends obf_2_M_853
   {
      
      public var id:String;
      
      public var level:int;
      
      public var exp:int;
      
      public function AngelInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","level:ubyte","exp:ushort"];
      }
   }
}

