package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_q_Z_3851 extends obf_e_1465
   {
      
      private var _itemConfig:Object;
      
      public function obf_q_Z_3851(param1:String)
      {
         this._itemConfig = GameItemManager.getItemConfig(param1);
         var _loc2_:String = JSONUtil.getStr(this._itemConfig,["properties","modelCode"]);
         super(_loc2_);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(modelCode));
         _loc1_.load();
      }
   }
}

