package com.sunweb.game.rpg.module
{
   import com.sunweb.game.res.obf_A_P_806;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.getTimer;
   import playerUI.ProgressBoxUI;
   
   public class ProgressBoxModule extends ProgressBoxUI implements IModalWindow
   {
      
      private static var bgDisplays:Array;
      
      private static var obf_5_5_2171:Array;
      
      private static var bgIndex:int = 0;
      
      private var _loaders:Array;
      
      private var _progressTime:TimeLimiter;
      
      private var _time:int;
      
      private var _bytesLoaded:int;
      
      private var _itemsLoaded:Number = 0;
      
      private var obf_1_x_2066:Loader;
      
      public function ProgressBoxModule(param1:Array)
      {
         var _loc2_:obf_A_P_806 = null;
         var _loc3_:int = 0;
         this._progressTime = new TimeLimiter(200);
         super();
         this.obf_1_x_2066 = getBGDisplay();
         this.setBGDisplayXY();
         obf_m_E_2908.addChild(this.obf_1_x_2066);
         this.addEventListener(Event.ENTER_FRAME,this.onProgress);
         this._loaders = param1;
         for each(_loc2_ in this._loaders)
         {
            this._bytesLoaded += _loc2_.getBytesLoaded();
            this._itemsLoaded += _loc2_.getItemsLoaded() + _loc2_.getLoadingLoadedCount();
         }
         this._time = getTimer();
         this.stop();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         _loc3_ = int(DiversityManager.getString("LoadingPrompt","count"));
         DiversityManager.setTextField(txtDeyPrompt1,"LoadingPrompt",int(Math.random() * _loc3_) + "",null,true);
      }
      
      public static function initBG() : void
      {
         var _loc1_:String = null;
         var _loc2_:Loader = null;
         obf_5_5_2171 = obf_C_o_3363.getAttr("loadingBG") as Array;
         if(!obf_5_5_2171)
         {
            return;
         }
         bgDisplays = new Array();
         for each(_loc1_ in obf_5_5_2171)
         {
            _loc2_ = new Loader();
            _loc2_.load(new URLRequest(GameContext.getFullResUrl(_loc1_)));
            _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,obf_Y_8_1973);
            bgDisplays.push(_loc2_);
         }
         if(bgDisplays.length > 0)
         {
            bgIndex = int(Math.round(Math.random() * (bgDisplays.length - 1)));
         }
      }
      
      public static function getBGDisplay() : Loader
      {
         if(!bgDisplays || !obf_5_5_2171)
         {
            return new Loader();
         }
         if(bgIndex >= bgDisplays.length)
         {
            bgIndex = 0;
         }
         var _loc1_:String = bgIndex < obf_5_5_2171.length ? obf_5_5_2171[bgIndex] : "";
         var _loc2_:Loader = bgDisplays[bgIndex];
         if(!_loc2_)
         {
            return new Loader();
         }
         if(obf_L_l_4100.isEmpty(_loc2_.contentLoaderInfo.url))
         {
            _loc2_.load(new URLRequest(_loc1_));
         }
         ++bgIndex;
         return _loc2_;
      }
      
      private static function obf_Y_8_1973(param1:Event) : void
      {
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,obf_Y_8_1973);
      }
      
      private function setBGDisplayXY() : void
      {
         if(!this.obf_1_x_2066)
         {
            return;
         }
         if(this.obf_1_x_2066.content)
         {
            if(this.obf_1_x_2066.content is Bitmap)
            {
               this.obf_1_x_2066.x = -(this.obf_1_x_2066.content.width / 2);
               this.obf_1_x_2066.y = -(this.obf_1_x_2066.content.height / 2);
            }
            else
            {
               this.obf_1_x_2066.x = 0;
               this.obf_1_x_2066.y = 0;
            }
            this.obf_1_x_2066.visible = true;
         }
         else
         {
            this.obf_1_x_2066.visible = false;
         }
      }
      
      private function onProgress(param1:Event) : void
      {
         var _loc5_:obf_A_P_806 = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         if(!this._progressTime.checkTimeout())
         {
            return;
         }
         this.setBGDisplayXY();
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         for each(_loc5_ in this._loaders)
         {
            _loc2_ += _loc5_.getItemsTotal();
            _loc3_ += _loc5_.getItemsLoaded() + _loc5_.getLoadingLoadedCount();
            _loc4_ += _loc5_.getBytesLoaded();
         }
         _loc3_ -= this._itemsLoaded;
         _loc2_ -= this._itemsLoaded;
         _loc6_ = 100 * Number(_loc3_ / _loc2_);
         this.gotoAndStop(_loc6_);
         _loc7_ = (getTimer() - this._time) / 1000;
         _loc8_ = "";
         _loc8_ = int((_loc4_ - this._bytesLoaded) / _loc7_ / 1024) + " Kb/s";
         _loc8_ = _loc8_ + ("\n" + _loc6_ + "%");
         this.labelText.text = _loc8_;
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
      
      public function destroy() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onProgress);
         if(obf_m_E_2908.contains(this.obf_1_x_2066))
         {
            obf_m_E_2908.removeChild(this.obf_1_x_2066);
         }
         this.obf_1_x_2066 = null;
      }
   }
}

