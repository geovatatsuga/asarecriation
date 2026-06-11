package com.sunweb.game.rpg.worldZone.command.activity
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PayMarkActivityNotify extends obf_O_8_1034
   {
      
      public var isValid:Boolean = false;
      
      public var dateFrom:String;
      
      public var dateTo:String;
      
      public var items:Object;
      
      public function PayMarkActivityNotify()
      {
         super(CommandCodeActivity.PAY_MARK_ACTIVITY_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isValid:boolean","dateFrom:string","dateTo:string","items:map(string,int)"];
      }
   }
}

