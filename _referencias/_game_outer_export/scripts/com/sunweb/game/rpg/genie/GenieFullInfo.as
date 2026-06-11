package com.sunweb.game.rpg.genie
{
   public class GenieFullInfo extends ItemPlayerGenieInfo
   {
      
      public var genieId:String;
      
      public var genieCode:String;
      
      public function GenieFullInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string","genieCode:string"].concat(super.getFieldList());
      }
   }
}

