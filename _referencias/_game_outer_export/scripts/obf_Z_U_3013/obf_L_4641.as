package obf_Z_U_3013
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.map.obf_0_3_x_417;
   import com.sunweb.game.rpg.netRole.AIObjectsBufferManager;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_L_4641 extends obf_0_3_x_417
   {
      
      private var _trapConfig:Object;
      
      public function obf_L_4641(param1:String)
      {
         this._trapConfig = obf_C_p_3418.getTrapConfig(param1);
         var _loc2_:String = JSONUtil.getStr(this._trapConfig,["modelCode"]);
         super(_loc2_);
         if(!JSONUtil.getBoolean(this._trapConfig,["hideLabel"]))
         {
            this.setAndShowLabel(JSONUtil.getStr(this._trapConfig,["name"]));
         }
         if(JSONUtil.getBoolean(this._trapConfig,["hideShadow"]))
         {
            this.setShadow(null);
         }
         this.zLevel = JSONUtil.getInt(this._trapConfig,["zLevel"]);
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + _modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(_modelCode));
         _loc1_.load();
      }
      
      public function get trapCode() : String
      {
         return JSONUtil.getStr(this._trapConfig,["code"]);
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         obf_D_I_1250 = param1;
      }
   }
}

