package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.utils.JSONUtil;
   import flash.filters.GlowFilter;
   
   public class obf_t_T_3981 extends obf_e_1465
   {
      
      public function obf_t_T_3981(param1:String)
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         var _loc3_:String = JSONUtil.getStr(_loc2_,["properties","modelCode"]);
         super(_loc3_);
         this._labelTextField.filters = [new GlowFilter(0,1,2,2,1000,1)];
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(modelCode));
         _loc1_.load();
      }
      
      public function setName(param1:String, param2:String) : void
      {
         var _loc3_:String = "";
         _loc3_ += param1;
         _loc3_ += "\n<font color=\'#00FF00\'>" + DiversityManager.getString("PetUI","petNameShow",[param2]) + "</font>";
         this.setAndShowLabel(_loc3_);
      }
   }
}

