package com.sunweb.game.rpg.lockTower
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_5_y_508
   {
      
      public var hp:int;
      
      public var atk:int;
      
      public var obf_7_l_4176:int;
      
      public var obf_y_1_1936:int;
      
      public var obf_0_1_P_161:int;
      
      public function obf_0_5_y_508()
      {
         super();
      }
      
      public function addObject(param1:Object) : void
      {
         this.hp += JSONUtil.getInt(param1,["200"]);
         this.atk += JSONUtil.getInt(param1,["140"]);
         this.obf_7_l_4176 += JSONUtil.getInt(param1,["150"]);
         this.obf_y_1_1936 += JSONUtil.getInt(param1,["160"]);
         this.obf_0_1_P_161 += JSONUtil.getInt(param1,["170"]);
      }
   }
}

