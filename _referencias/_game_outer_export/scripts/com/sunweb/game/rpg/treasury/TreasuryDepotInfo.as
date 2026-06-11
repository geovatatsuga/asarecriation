package com.sunweb.game.rpg.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class TreasuryDepotInfo extends obf_2_M_853
   {
      
      public var type:int;
      
      public var index:int;
      
      public var attrMap:Object;
      
      public var level:int;
      
      public var exp:int;
      
      public function TreasuryDepotInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","index:ubyte","attrMap:map(string,int)","level:ubyte","exp:int"];
      }
   }
}

