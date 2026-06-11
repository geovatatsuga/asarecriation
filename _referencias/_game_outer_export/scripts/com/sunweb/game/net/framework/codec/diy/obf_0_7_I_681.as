package com.sunweb.game.net.framework.codec.diy
{
   public class obf_0_7_I_681
   {
      
      public var obf_J_g_2260:String;
      
      public var obf_M_A_4351:String;
      
      public var arrayType:String;
      
      public var mapKeyType:String;
      
      public var mapValueType:String;
      
      protected var _definition:String;
      
      public function obf_0_7_I_681(param1:String = null)
      {
         super();
         if(param1 != null)
         {
            this.parse(param1);
         }
      }
      
      public function getDefinition() : String
      {
         return this._definition;
      }
      
      public function parse(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._definition = param1;
         param1 = param1.replace(/ /g,"");
         var _loc2_:int = param1.indexOf(":");
         this.obf_J_g_2260 = param1.substring(0,_loc2_);
         this.obf_M_A_4351 = param1.substring(_loc2_ + 1);
         var _loc3_:int = this.obf_M_A_4351.indexOf("(");
         if(_loc3_ > -1)
         {
            _loc4_ = this.obf_M_A_4351.indexOf(")");
            this.arrayType = this.obf_M_A_4351.substring(_loc3_ + 1,_loc4_);
            this.obf_M_A_4351 = this.obf_M_A_4351.substring(0,_loc3_);
            _loc5_ = this.arrayType.indexOf(",");
            if(_loc5_ > -1)
            {
               this.mapKeyType = this.arrayType.substring(0,_loc5_);
               this.mapValueType = this.arrayType.substring(_loc5_ + 1);
               this.arrayType = null;
            }
         }
         else
         {
            this.arrayType = null;
         }
      }
   }
}

