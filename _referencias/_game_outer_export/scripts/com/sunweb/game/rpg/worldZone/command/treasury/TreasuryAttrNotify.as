package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreasuryAttrNotify extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var attrMap:Object;
      
      public function TreasuryAttrNotify()
      {
         super(CommandCodeTreasury.TREASURY_ATTR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","attrMap:map(string,int)"];
      }
   }
}

