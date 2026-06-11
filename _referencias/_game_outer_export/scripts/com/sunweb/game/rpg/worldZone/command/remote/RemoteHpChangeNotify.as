package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteHpChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var hpChanged:Number;
      
      public var hpPercentCurrent:int;
      
      public var skillCode:String;
      
      public var isCriticalStrike:Boolean;
      
      public function RemoteHpChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","hpChanged:double","hpPercentCurrent:byte","skillCode:string","isCriticalStrike:boolean"];
      }
   }
}

