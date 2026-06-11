package com.sunweb.game.rpg.world.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MapDamageRankInfo extends obf_2_M_853
   {
      
      public var roleName:String;
      
      public var damageValue:int;
      
      public var damageRank:int;
      
      public function MapDamageRankInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","damageValue:int","damageRank:ushort"];
      }
   }
}

