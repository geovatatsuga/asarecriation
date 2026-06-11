package com.sunweb.game.rpg.playerDevil
{
   public class DevilFullInfo extends ItemPlayerDevilInfo
   {
      
      public var devilId:String;
      
      public var devilCode:String;
      
      public function DevilFullInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string","devilCode:string"].concat(super.getFieldList());
      }
   }
}

