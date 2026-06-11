package com.sunweb.game.rpg.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class DevilBriefInfo extends obf_2_M_853
   {
      
      public var devilId:String;
      
      public var devilCode:String;
      
      public function DevilBriefInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string","devilCode:string"];
      }
   }
}

