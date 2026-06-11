package com.sunweb.game.util
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class obf_e_P_918
   {
      
      private static var _stage:Stage;
      
      private static var _defaultCursor:DisplayObject;
      
      private static var obf_3_g_3997:String;
      
      private static var _defaultCursorName:String = "default";
      
      private static var obf_0_1_3_628:Object = new Object();
      
      private static var obf_0_4_E_455:Sprite = new Sprite();
      
      public function obf_e_P_918()
      {
         super();
      }
      
      public static function initialize(param1:Stage, param2:DisplayObject) : void
      {
         _stage = param1;
         _defaultCursor = param2;
         obf_0_4_E_455.x = _stage.mouseX;
         obf_0_4_E_455.y = _stage.mouseY;
         obf_0_4_E_455.mouseEnabled = false;
         obf_0_4_E_455.mouseChildren = false;
         _stage.addChild(obf_0_4_E_455);
         _stage.addEventListener(MouseEvent.MOUSE_MOVE,updateCursor);
         useDefaultCursor();
      }
      
      public static function obf_6_A_2075() : void
      {
         var _loc1_:String = null;
         Mouse.show();
         _stage.removeEventListener(MouseEvent.MOUSE_MOVE,updateCursor);
         _stage.removeChild(obf_0_4_E_455);
         while(obf_0_4_E_455.numChildren > 0)
         {
            obf_0_4_E_455.removeChildAt(obf_0_4_E_455.numChildren - 1);
         }
         for(_loc1_ in obf_0_1_3_628)
         {
            delete obf_0_1_3_628[_loc1_];
         }
         _defaultCursor = null;
         _stage = null;
      }
      
      public static function get cursor() : Sprite
      {
         return obf_0_4_E_455;
      }
      
      private static function updateCursor(param1:MouseEvent) : void
      {
         obf_0_4_E_455.x = param1.stageX;
         obf_0_4_E_455.y = param1.stageY;
      }
      
      public static function setDefaultCursor(param1:DisplayObject) : void
      {
         _defaultCursor = param1;
         if(obf_3_g_3997 == _defaultCursorName)
         {
            useDefaultCursor();
         }
      }
      
      public static function obf_k_D_2157(param1:String, param2:DisplayObject) : void
      {
         obf_0_1_3_628[param1] = param2;
      }
      
      public static function obf_Y_D_2125(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            obf_k_D_2157(_loc2_,param1[_loc2_]);
         }
      }
      
      public static function useCursor(param1:String) : void
      {
         obf_3_g_3997 = param1;
         if(param1 == _defaultCursorName)
         {
            useDefaultCursor();
         }
         else
         {
            useCustomCursor(obf_0_1_3_628[param1]);
         }
      }
      
      public static function get obf_C_D_2031() : String
      {
         return obf_3_g_3997;
      }
      
      public static function useDefaultCursor() : void
      {
         obf_3_g_3997 = _defaultCursorName;
         useCustomCursor(_defaultCursor);
      }
      
      public static function useCustomCursor(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         while(obf_0_4_E_455.numChildren > 0)
         {
            obf_0_4_E_455.removeChildAt(obf_0_4_E_455.numChildren - 1);
         }
         obf_0_4_E_455.addChild(param1);
      }
   }
}

