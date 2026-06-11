package com.sunweb.game.rpg.role
{
   public class RoleSystemInfo extends RoleBaseInfo
   {
      
      public var accountId:String;
      
      public var createTime:String;
      
      public var lastPlayTime:String;
      
      public var deletedFlag:Boolean;
      
      public var willDeleteTime:String;
      
      public var equipmentModels:Object;
      
      public var hasRolePassword:Boolean;
      
      public function RoleSystemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return super.getFieldList().concat(["accountId:string","createTime:string","lastPlayTime:string","deletedFlag:boolean","willDeleteTime:string","equipmentModels:map(byte,string)","hasRolePassword:boolean"]);
      }
   }
}

