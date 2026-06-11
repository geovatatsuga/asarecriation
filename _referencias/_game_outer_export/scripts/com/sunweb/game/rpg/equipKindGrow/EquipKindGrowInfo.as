package com.sunweb.game.rpg.equipKindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.utils.JSONUtil;
   
   public class EquipKindGrowInfo extends obf_2_M_853
   {
      
      public var kind:int;
      
      public var level:int;
      
      public var exp:int;
      
      public var temper:Object;
      
      public var newTemper:Object;
      
      public function EquipKindGrowInfo()
      {
         super();
      }
      
      public function init(param1:int) : void
      {
         this.kind = param1;
         this.level = 0;
         this.exp = 0;
         this.temper = null;
         this.newTemper = null;
      }
      
      public function parse(param1:Object) : void
      {
         this.kind = JSONUtil.getInt(param1,["kind"]);
         this.level = JSONUtil.getInt(param1,["level"]);
         this.exp = JSONUtil.getInt(param1,["exp"]);
         this.temper = JSONUtil.getObject(param1,["temper"]);
         this.newTemper = JSONUtil.getObject(param1,["newTemper"]);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","level:ubyte","exp:int","temper:map(short,float)","newTemper:map(short,float)"];
      }
   }
}

