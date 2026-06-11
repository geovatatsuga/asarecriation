package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_e_1465;
   
   public class obf_J_D_1836 extends obf_e_1465
   {
      
      public function obf_J_D_1836(param1:int)
      {
         super(obf_Y_1494.obf_x_b_4157(param1));
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(modelCode));
         _loc1_.load();
      }
      
      public function setName(param1:String) : void
      {
         this.setAndShowLabel(param1);
      }
   }
}

