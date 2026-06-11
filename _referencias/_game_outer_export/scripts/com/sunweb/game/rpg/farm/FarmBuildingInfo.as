package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FarmBuildingInfo extends obf_2_M_853
   {
      
      public var id:String;
      
      public var code:String;
      
      public var x:int;
      
      public var y:int;
      
      public var timeLeftInHour:int;
      
      public function FarmBuildingInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","code:string","x:int","y:int","timeLeftInHour:ushort"];
      }
   }
}

