package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteMpChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var mpChanged:int;
      
      public var mpPercentCurrent:int;
      
      public var skillCode:String;
      
      public function RemoteMpChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_MP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","mpChanged:short","mpPercentCurrent:byte","skillCode:string"];
      }
   }
}

