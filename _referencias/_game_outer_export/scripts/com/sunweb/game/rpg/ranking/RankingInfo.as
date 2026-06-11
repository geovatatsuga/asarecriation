package com.sunweb.game.rpg.ranking
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RankingInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var value:int;
      
      public var value2:int;
      
      public function RankingInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","value:uint","value2:uint"];
      }
   }
}

