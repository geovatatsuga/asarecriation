package com.sunweb.game.rpg.playingCard
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class CardInfo extends obf_2_M_853
   {
      
      public var cardId:String;
      
      public var face:int;
      
      public function CardInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["cardId:string","face:ubyte"];
      }
   }
}

