package com.sunweb.game.rpg.world
{
   import com.sunweb.game.ui.WindowManager;
   
   public class PromptsManager
   {
      
      private static var promptsObject:Object;
      
      public function PromptsManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         promptsObject = param1;
      }
      
      public static function checkRoleLevelUp(param1:int) : void
      {
         if(!promptsObject)
         {
            return;
         }
         if(Boolean(promptsObject.roleLevelUp) && Boolean(promptsObject.roleLevelUp[param1 + ""]))
         {
            WindowManager.showInfoBox(promptsObject.roleLevelUp[param1 + ""]);
         }
      }
      
      public static function checkSkillLevelUp(param1:int, param2:int) : void
      {
         if(!promptsObject)
         {
            return;
         }
         if(Boolean(promptsObject.skillLevelUp) && Boolean(promptsObject.skillLevelUp[param1 + "-" + param2]))
         {
            WindowManager.showInfoBox(promptsObject.skillLevelUp[param1 + "-" + param2]);
         }
      }
      
      public static function checkGainItem(param1:String) : void
      {
         if(!promptsObject)
         {
            return;
         }
         if(Boolean(promptsObject.gainItem) && Boolean(promptsObject.gainItem[param1]))
         {
            WindowManager.showInfoBox(promptsObject.gainItem[param1]);
         }
      }
      
      public static function checkEnterMap(param1:String) : void
      {
         if(!promptsObject)
         {
            return;
         }
         if(Boolean(promptsObject.enterMap) && Boolean(promptsObject.enterMap[param1]))
         {
            WindowManager.showInfoBox(promptsObject.enterMap[param1]);
         }
      }
      
      public static function checkReceiveTask(param1:int) : void
      {
         if(!promptsObject)
         {
            return;
         }
         if(Boolean(promptsObject.receiveTask) && Boolean(promptsObject.receiveTask[param1]))
         {
            WindowManager.showInfoBox(promptsObject.receiveTask[param1]);
         }
      }
   }
}

