package obf_a_F_1055
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_b_p_3604
   {
      
      private static var _npcObj:Object = new Object();
      
      public static var obf_h_n_3961:String = "";
      
      public function obf_b_p_3604()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_)
            {
               for(_loc4_ in _loc3_.npcs)
               {
                  _loc5_ = _loc3_.npcs[_loc4_];
                  if(_loc5_)
                  {
                     _npcObj[_loc4_ + "@" + _loc2_] = _loc5_;
                  }
               }
            }
         }
      }
      
      public static function getNpcBrief(param1:String) : Object
      {
         return _npcObj[param1];
      }
      
      public static function getNpcBriefName(param1:String) : String
      {
         var _loc2_:Object = getNpcBrief(param1);
         if(_loc2_)
         {
            return _loc2_.name || "";
         }
         return "";
      }
      
      public static function getNpcFullBriefName(param1:String) : String
      {
         var _loc2_:String = getNpcBriefName(param1);
         var _loc3_:Array = param1.split("@");
         return _loc2_ + "-" + WorldMapManager.getMapName(JSONUtil.getStr(_loc3_,[1]));
      }
      
      public static function checkNpcDistance(param1:String, param2:Boolean) : Boolean
      {
         if(!GameContext.currentMap || !GameContext.currentMap.npcSet.getObject(param1) || GameContext.localPlayer.getLineDistance(GameContext.currentMap.npcSet.getObject(param1)) > WorldConfig.MAX_NPC_TALK_DISTANCE)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("NpcPrompt","outOfNpcDistance"));
            }
            return false;
         }
         return true;
      }
   }
}

