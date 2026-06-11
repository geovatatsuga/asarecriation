package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemotePKValueChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var pkValueChanged:int;
      
      public var pkValueCurrent:int;
      
      public function RemotePKValueChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_PK_VALUE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","pkValueChanged:byte","pkValueCurrent:byte"];
      }
   }
}

