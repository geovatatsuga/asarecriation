package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerHpChangeNotify extends obf_O_8_1034
   {
      
      public var hpChanged:Number;
      
      public var hpCurrent:Number;
      
      public var skillCode:String;
      
      public var isCriticalStrike:Boolean;
      
      public var isHidden:Boolean;
      
      public function PlayerHpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["hpChanged:double","hpCurrent:double","skillCode:string","isCriticalStrike:boolean","isHidden:boolean"];
      }
   }
}

