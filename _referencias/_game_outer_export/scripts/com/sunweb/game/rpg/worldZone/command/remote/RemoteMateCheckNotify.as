package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteMateCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var mateName:String;
      
      public var mateRelation:int;
      
      public function RemoteMateCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_MATE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","mateName:string","mateRelation:byte"];
      }
   }
}

