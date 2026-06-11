package com.sunweb.game.rpg.module
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class obf_0_K_4070 extends Sprite implements IModalWindow
   {
      
      private var thisMC:DisplayObject;
      
      private var obf_8_O_2590:String;
      
      public function obf_0_K_4070(param1:String, param2:String)
      {
         super();
         this.thisMC = ResourceManager.instance.getDisplayObject(param1);
         if(this.thisMC)
         {
            this.thisMC.addEventListener("CloseWelcome",this.onClose);
            this.addChild(this.thisMC);
         }
         this.obf_8_O_2590 = param2;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      public static function showWelcome(param1:String) : void
      {
         var _loc2_:String = JSONUtil.getStr(WorldConfig.getObjectSetting("welcome"),[param1]);
         if(!GameContext.userConfig["pai"])
         {
            GameContext.userConfig["pai"] = new Object();
         }
         if(!GameContext.userConfig["dnc"] && !GameContext.userConfig["pai"][param1] && Boolean(ResourceManager.instance.getDisplayObject(_loc2_)))
         {
            WindowManager.showModalWindow(new obf_0_K_4070(_loc2_,param1));
         }
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         if(!obf_L_l_4100.isEmpty(this.obf_8_O_2590))
         {
            GameContext.userConfig["pai"][this.obf_8_O_2590] = true;
            GameContext.saveConfig();
         }
         WindowManager.closeWindow(this);
         if(this.obf_8_O_2590 == "idw" && TaskManager.getDoingTask().length > 0)
         {
            _loc2_ = TaskManager.getDoingTask()[0];
            _loc3_ = JSONUtil.getObject(_loc2_,["finishRule","atAnyNpc"]) as Array;
            if(_loc3_.length > 0)
            {
               _loc4_ = _loc3_[0];
            }
            for each(_loc5_ in _loc3_)
            {
               _loc6_ = _loc5_.split("@");
               if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc6_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            if(!obf_L_l_4100.isEmpty(_loc4_))
            {
               _loc7_ = _loc4_.split("@");
               GameContext.localPlayer.obf_0_8_r_450(_loc7_[1],obf_U_6_3454.obf_H_n_3781,_loc7_[0]);
            }
         }
      }
      
      public function destroy() : void
      {
         if(this.thisMC)
         {
            this.thisMC.removeEventListener("CloseWelcome",this.onClose);
         }
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
   }
}

