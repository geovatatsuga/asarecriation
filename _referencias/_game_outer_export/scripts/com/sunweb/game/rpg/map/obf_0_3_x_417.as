package com.sunweb.game.rpg.map
{
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   
   public class obf_0_3_x_417 extends obf_0_Y_3475
   {
      
      public static var obf_L_1_2895:String = "cff";
      
      protected var _modelCode:String;
      
      public function obf_0_3_x_417(param1:String)
      {
         super();
         this._modelCode = param1;
         useMonsterModel(this._modelCode,obf_L_1_2895,true);
      }
   }
}

